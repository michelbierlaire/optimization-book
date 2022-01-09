"""
Algorithms from Part VI of the book
Bierlaire (2015) Optimization: Principles and Algorithms. EPFL Press.

Michel Bierlaire
Mon Jan  3 17:23:22 2022
"""

from collections import namedtuple
import numpy as np
import pandas as pd
import networkx as nx
import optimization_book.exceptions as excep

Node = namedtuple('Node', 'name x y')


class Arc:
    """Arc representation"""

    def __init__(self, upstream, downstream, cost):
        """
        :param upstream: upstream node
        :type upstream: Node

        :param downstream: downstream node
        :type downstream: Node

        :param cost: arc cost
        :type cost: float
        """
        self.up = upstream
        self.down = downstream
        self.cost = cost
        self.visited = False

    def __str__(self):
        return f'{self.up.name} -> {self.down.name}'

    def __repr__(self):
        return f'{self.up.name} -> {self.down.name}'


class Path:
    """Path representation"""

    def __init__(self, list_of_arcs=None):
        self.list_of_arcs = list_of_arcs

    def prepend(self, arc):
        """Insert an arc at the beginning of the path

        :param arc: arc to be inserted
        :type arc: Arc

        :raise optimizationError: if the arc is not connected to the path
        """
        if arc.down != self.list_of_arcs[0].up:
            raise excep.optimizationError(
                f'Arc {arc} cannot be inserted in a path before '
                f'arc {self.list_of_arcs[0]}'
            )
        if arc in self.list_of_arcs:
            raise excep.optimizationError(
                f'Arc {arc} is already in the path. '
                f'It cannot be inserted as the path would not be '
                f'simple anymore.'
            )
        self.list_of_arcs.insert(0, arc)

    def append(self, arc):
        """Insert an arc at the end of the path

        :param arc: arc to be inserted
        :type arc: Arc

        :raise optimizationError: if the arc is not connected to the path
        """
        if arc.up != self.list_of_arcs[-1].down:
            raise excep.optimizationError(
                f'Arc {arc} cannot be inserted in a path after '
                f'arc {self.list_of_arcs[-1]}'
            )
        if arc in self.list_of_arcs:
            raise excep.optimizationError(
                f'Arc {arc} is already in the path. '
                f'It cannot be inserted as the path would not be '
                f'simple anymore.'
            )
        self.list_of_arcs.append(arc)

    def cost(self):
        """Calculates the cost of the path

        :return: cost of the path, that is the sum of the cost of all links
        :rtype: float
        """
        return sum([a.cost for a in self.list_of_arcs])

    def __str__(self):
        return self.__repr__()

    def __repr__(self):
        if self.list_of_arcs:
            result = str(self.list_of_arcs[0])
            for arc in self.list_of_arcs[1:]:
                result += f' -> {arc.down.name}'

            result += f' [Cost: {self.cost()}]'
            return result

        return 'Empty'


class Network:
    """
    Network representation
    """

    def __init__(self, arcs):
        """Constructor

        :param arcs: a list n arcs
        :type arcs: list(Arc)
        """
        self.arcs = arcs
        self.nodes = list({node for a in arcs for node in (a.up, a.down)})
        self.m = len(self.nodes)
        self.n = len(arcs)

        self.successors = {node: [] for node in self.nodes}
        self.predecessors = {node: [] for node in self.nodes}
        for arc in self.arcs:
            self.successors[arc.up].append(arc)
            self.predecessors[arc.down].append(arc)

    def copy_with_negative_costs(self):
        new_arcs = [Arc(arc.up, arc.down, -arc.cost) for arc in self.arcs]
        return Network(new_arcs)
    
    def _node_from_name(self, node_name):
        """Retrieve a node from its name

        :param node_name: name of the node
        :type node_name: str

        :return: the node
        :rtype: Node

        :raise optimizationError: if the name if unknown
        :raise optimizationError: if several nodes share the same name
        """
        index = [
            idx
            for idx, node in enumerate(self.nodes)
            if node.name == node_name
        ]
        if len(index) < 1:
            raise excep.optimizationError(f'Node {node_name} is unknown')
        if len(index) > 1:
            raise excep.optimizationError(
                f'Several nodes have the same name: {node_name}'
            )
        return self.nodes[index[0]]

    def draw(self):
        """
        A simple drawing of the graph based on the networkx package.
        """
        graph = nx.DiGraph()
        for node in self.nodes:
            graph.add_node(node.name, pos=(node.x, node.y))
        edge_labels = {}
        for arc in self.arcs:
            graph.add_edge(arc.up.name, arc.down.name, cost=arc.cost)
            edge_labels[(arc.up.name, arc.down.name)] = f'{arc.cost}'
        pos = nx.get_node_attributes(graph, 'pos')
        nx.draw(graph, pos, with_labels=True, font_weight='bold')
        nx.draw_networkx_edge_labels(graph, pos, edge_labels=edge_labels)
        graph.clear()


def path_enumeration(network, orig_name, dest_name):
    """Enumerate all simple paths between two nodes in a network.

    :param network: network object
    :type network: Network

    :param orig_name: name of the origin node
    :type orig_name: str

    :param dest_name: name of the destination node
    :type dest_name: str
    """
    orig = network._node_from_name(orig_name)
    dest = network._node_from_name(dest_name)
    return _path_enumeration(network, orig, dest)


def _path_enumeration(network, orig, dest):
    """Recursively enumerate all simple paths between two nodes in a network.

    :param network: network object
    :type network: Network

    :param orig: origin node
    :type orig: Node

    :param dest: destination node
    :type dest_name: Node
    """
    results = []
    for arc in network.successors[orig]:
        if not arc.visited:
            arc.visited = True
            if arc.down == dest:
                results.append(Path([arc]))
            else:
                paths = _path_enumeration(network, arc.down, dest)
                for path in paths:
                    path.prepend(arc)
                results += paths
        arc.visited = False
    return results


class LabeledNode:
    """Associated a node with its label
    """
    def __init__(self, node, label):
        """Constructore

        :param node: node
        :type node: Node

        :param label: label
        :type label: float
        """
        self.node = node
        self.label = label

    def __lt__(self, other):
        return self.label < other.label

    def __repr__(self):
        return f'{self.node} {self.label}'


class ShortestPathAlgorithm:
    """Class that calculates the shortest path tree and provide various
    outputs.
    """

    def __init__(self, network, starting_node, dijkstra=False):
        """:param network: the network.
        :type network: class Network

        :param starting_node: name of the starting node.
        :type starting_node: str

        :param dijkstra: if True, the node with the lowest label is
            treated at each iteration.
        :type dijkstra: bool
        """

        self.network = network
        self.starting_node = LabeledNode(
            network._node_from_name(starting_node),
            0,
        )
        self.dijkstra = dijkstra
        self.results = None
        # Initialization of the labels.
        self.labeled_nodes = {
            node: LabeledNode(node, np.inf) for node in self.network.nodes
        }
        self.labeled_nodes[self.starting_node.node] = self.starting_node

        # Initialization of the predecessors
        self.pred = {}
        self.arc_costs = {}
        self.negative_costs = False
        self.min_cost = None

        for arc in self.network.arcs:
            self.arc_costs[(arc.up, arc.down)] = arc.cost
            if self.min_cost is None:
                self.min_cost = arc.cost
            elif arc.cost < self.min_cost:
                self.min_cost = arc.cost
            if arc.cost < 0:
                self.negative_costs = True

        # Keep track of the labels through the iterations
        label_names = [f'ell_{node.name}' for node in network.nodes]
        label_names.sort()
        columns = ['Iter.', 'Set', 'Node'] + label_names

        self.iterations = pd.DataFrame(columns=columns)

        # Keep track of the predecessors through the iterations
        self.pi_names = [f'pi_{node.name}' for node in network.nodes]
        self.pi_names.sort()
        columns = ['Iter.'] + self.pi_names

        self.pi = pd.DataFrame(columns=columns)

    def _generate_output(self):
        """Function preparing the output at the end of the algorithm.

        :return: a dictionary where the keys are nodes, and the values
            are tuples containing the label of the node (that is, it's
            distance form the origin) and its predecessor in the
            shortest path.
        :rtype: dict(Node: (float, Node))
        """
        return {
            node: (labeled_node.label, self.pred.get(node))
            for node, labeled_node in self.labeled_nodes.items()
        }

    def run(self):
        """Execution of the algorithm"""

        # We check if there are negative costs and, if so, we calculate
        # the lower bound.
        m = self.network.m
        if self.negative_costs:
            lowerbound = (m - 1) * self.min_cost

        # Initialization of the set.
        S = {self.starting_node}

        current_iteration = 0
        while S:
            nodes_in_set = [labeled_node.node.name for labeled_node in S]
            nodes_in_set.sort()
            set_details = '{' + ', '.join(nodes_in_set) + '}'

            if self.dijkstra:
                # Choose the node with the smallest label
                i = min(S)
                S.remove(i)
            else:
                # Choose an arbitrary node in the set
                i = S.pop()

            # Collect information about the current iteration
            iter_row = {
                'Iter.': current_iteration,
                'Set': set_details,
                'Node': i.node.name,
            }
            for node, labeled_node in self.labeled_nodes.items():
                iter_row[f'ell_{node.name}'] = labeled_node.label
            self.iterations = self.iterations.append(
                iter_row, ignore_index=True
            )

            # Collect information about the predecessors in the shortest path.
            pi_row = {key: '-1' for key in self.pi_names}
            pi_row['Iter.'] = current_iteration

            for node, pi in self.pred.items():
                pi_row[f'pi_{node.name}'] = pi.down.name
            self.pi = self.pi.append(pi_row, ignore_index=True)

            current_iteration += 1

            # Process all the successors.
            for arc in self.network.successors[i.node]:
                if self.labeled_nodes[arc.down].label > i.label + arc.cost:
                    self.labeled_nodes[arc.down].label = i.label + arc.cost
                    if (
                        self.labeled_nodes[arc.down].label < 0
                        and self.labeled_nodes[arc.down].label < lowerbound
                    ):
                        print(
                            f'The label of node {arc.down.name} '
                            f'is {self.labeled_nodes[arc.down].label}, '
                            f'that is below the lower '
                            f'bound {lowerbound}. It is an unbounded problem.'
                        )
                        self.results = self._generate_output()
                        return

                    S.add(self.labeled_nodes[arc.down])
                    self.pred[arc.down] = arc

        # Collect information about the last iteration
        iter_row = {'Iter.': current_iteration, 'Set': S, 'Node': None}
        for node, labeled_node in self.labeled_nodes.items():
            iter_row[f'ell_{node.name}'] = labeled_node.label
        self.iterations = self.iterations.append(iter_row, ignore_index=True)

        # Collect information about the predecessors in the shortest
        # path for the last iteration, When there is no predecessor,
        # -1 is reported.

        pi_row = {key: '-1' for key in self.pi_names}
        pi_row['Iter.'] = current_iteration
        for node, pi in self.pred.items():
            pi_row[f'pi_{node.name}'] = pi.down.name
        self.pi = self.pi.append(pi_row, ignore_index=True)

        self.results = self._generate_output()

    def print_results(self):
        """Print the results in a human readable format."""
        if self.results is None:
            print('The algorithm has not been executed yet.')
        for node, the_tuple in self.results.items():
            print(
                f'Label of node {node.name}: {the_tuple[0]}. '
                f'Incoming arc: {the_tuple[1]}'
            )

    def shortest_path_tree(self):
        """Extract the shortest path tree
        :return: the shortest path tree
        :rtype: Network

        :raise optimizationError: if the algorithm has not been run yet.
        """
        if self.results is None:
            raise excep.optimizationError(
                'The algorithm has not been executed yet.'
            )
        return Network(self.pred.values())

class LongestPathAlgorithm(ShortestPathAlgorithm):
    """Class that calculates the longest path tree and provide various
    outputs.
    """
    def __init__(self, network, starting_node, dijkstra=False):
        modified_network = network.copy_with_negative_costs()
        super().__init__(modified_network, starting_node, dijkstra)
