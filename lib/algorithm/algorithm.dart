///
///
/// this file contains:
/// [Vertex]
///   - [VertexComparable]
///   - [Node]
///   - [NodeBinary], [NodeBinaryComparable], [NodeAvl]
///   - [NodeTrie], [NodeTrieString]
///   - [NodeTree]
///
/// [Heap]
///
/// [Edge], [EdgeType]
/// [Graph]
///   - [AdjacencyList]
///   - [AdjacencyMatrix]
///
/// see https://medium.com/@m.m.shahmeh/data-structures-algorithms-in-dart-5-5-660e0ef30a4d
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
// part of dastore;
import 'dart:math' as math;

import 'package:dastore/dastore.dart';



class Vertex<E> {
  E data;

  Vertex(this.data);

  @override
  bool operator ==(covariant Vertex<E> other) => data == other.data;

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() => data.toString();
}

class VertexComparable<E> extends Vertex<E>
    implements Comparable<VertexComparable<E>> {
  num value;

  VertexComparable(this.value, super.data);

  @override
  int compareTo(VertexComparable<E> other) => value == other.value
      ? 0
      : value > other.value
          ? 1
          : -1;

  @override
  String toString() => '$value-$data';
}

class Node<E> extends Vertex<E> {
  Node<E>? next;

  Node(super.data, this.next);

  bool get isEnd => next == null;
}

class NodeBinary<E> extends Vertex<E> {
  NodeBinary<E>? left;
  NodeBinary<E>? right;

  NodeBinary(super.data, {this.left, this.right});

  @override
  String toString() => _diagram(this);

  String _diagram(
    NodeBinary<E>? node, [
    String top = '',
    String root = '',
    String bottom = '',
  ]) {
    if (node == null) return '$root null\n';
    if (node.left == null && node.right == null) {
      return '$root${node.data}\n';
    }
    final a = _diagram(node.right, '$top  ', '$top--', '$top| ');
    final b = '$root${node.data}\n';
    final c = _diagram(node.left, '$bottom| ', '$bottom--', '$bottom  ');
    return '$a$b$c';
  }

  ///
  /// getters
  /// [values]
  /// [leftest], [rightest]
  /// [height]
  ///

  List<E> get values {
    List<E> dataAndItsChildren(NodeBinary<E> node) {
      final left = node.left;
      final right = node.right;
      return [
        node.data,
        if (left != null) ...dataAndItsChildren(left),
        if (right != null) ...dataAndItsChildren(right),
      ];
    }

    return dataAndItsChildren(this);
  }

  NodeBinary<E> get leftest => left?.leftest ?? this;

  NodeBinary<E> get rightest => right?.rightest ?? this;

  int get height {
    int h = 0;
    void traversal(NodeBinary<E> node, int level) {
      final left = node.left;
      final right = node.right;
      final isLeftNotNull = left != null;
      if (isLeftNotNull || right != null) {
        // TODO: Node Tree Height
        if (level > h) {
          h++;
        }
      }
    }

    traversal(this, h);
    throw UnimplementedError();
  }

  ///
  /// methods
  ///

  bool contains(E value) => values.contains(value);

  void traversalInOrder(void Function(E data) action) {
    left?.traversalInOrder(action);
    action(data);
    right?.traversalInOrder(action);
  }

  void traversalPreOrder(void Function(E data) action) {
    action(data);
    left?.traversalInOrder(action);
    right?.traversalInOrder(action);
  }

  void traversalPostOrder(void Function(E data) action) {
    left?.traversalInOrder(action);
    right?.traversalInOrder(action);
    action(data);
  }

  NodeBinary<E> _createNode(E data) => NodeBinary(data);
}

class NodeBinaryComparable<E extends Comparable<dynamic>>
    extends NodeBinary<E> {
  NodeBinaryComparable(super.data);

  set root(NodeBinary<E> node) => data = node.data;

  NodeBinary<E> _updateInsert(NodeBinary<E>? node, E value) {
    if (node == null) {
      return _createNode(data);
    } else {
      final c = value.compareTo(node.data);
      if (c == 0) {
        throw UnimplementedError('$value already exist');
      } else if (c < 0) {
        node.left = _updateInsert(node.left, value);
      } else {
        node.right = _updateInsert(node.right, value);
      }
      return node;
    }
  }

  NodeBinary<E>? _updateRemove(NodeBinary<E>? node, E value) {
    if (node == null) return null;

    final data = node.data;
    if (value == data) {
      final left = node.left;
      final right = node.right;
      if (left != null && right != null) {
        final replacement = right.leftest.data;
        node.data = replacement;
        node.right = _updateRemove(right, replacement);
      } else {
        return left ?? right;
      }
    } else if (value.compareTo(data) < 0) {
      node.left = _updateRemove(node.left, value);
    } else {
      node.right = _updateRemove(node.right, value);
    }
    return node;
  }

  void insert(E value) => root = _updateInsert(this, value);

  void remove(E value) {
    if (value == data) {
      throw UnimplementedError('root data must not be removed');
    } else {
      root = _updateRemove(this, value)!;
    }
  }

  @override
  bool contains(E value) {
    NodeBinary<E>? node = this;
    while (node != null) {
      if (node.data == value) return true;
      node = value.compareTo(node.data) < 0 ? node.left : node.right;
    }
    return false;
  }

  NodeBinary<E>? get min => leftest;

  NodeBinary<E>? get max => rightest;
}

///
/// TODO: Understand Node AVL
///
/// overrides:
/// [left], [right]
/// [height], [heightLeft], [heightRight], [balanceFactor]
/// [_createNode], [_updateInsert], [_updateRemove]
///
/// concept implementation:
/// [leftRotate], [rightRotate]
/// [leftRightRotate], [rightLeftRotate]
/// [balance]
///
///
class NodeAvl<E extends Comparable<dynamic>> extends NodeBinaryComparable<E> {
  NodeAvl(super.data);

  @override
  NodeAvl<E>? get left => super.left as NodeAvl<E>?;

  @override
  NodeAvl<E>? get right => super.right as NodeAvl<E>?;

  @override
  int height = 0;

  int get heightLeft => left?.height ?? -1;

  int get heightRight => right?.height ?? -1;

  int get balanceFactor => heightLeft - heightRight;

  @override
  NodeAvl<E> _createNode(E data) => NodeAvl(data);

  @override
  NodeAvl<E> _updateInsert(covariant NodeAvl<E>? node, E value) {
    final balanced = balance(super._updateInsert(node, value) as NodeAvl<E>);
    balanced.height = 1 + math.max(balanced.heightLeft, balanced.heightRight);
    return balanced;
  }

  @override
  NodeAvl<E> _updateRemove(covariant NodeAvl<E>? node, E value) {
    final balanced = balance(super._updateRemove(node, value) as NodeAvl<E>);
    balanced.height = 1 + math.max(balanced.heightLeft, balanced.heightRight);
    return balanced;
  }

  NodeAvl<E> leftRotate(NodeAvl<E> node) {
    final pivot = node.right!;
    node.right = pivot.left;
    pivot.left = node;
    node.height = 1 + math.max(pivot.heightLeft, pivot.heightRight);
    return pivot;
  }

  NodeAvl<E> rightRotate(NodeAvl<E> node) {
    final pivot = node.left!;
    node.left = pivot.right;
    pivot.right = node;
    node.height = 1 + math.max(node.heightLeft, node.heightRight);
    pivot.height = 1 + math.max(pivot.heightLeft, pivot.heightRight);
    return pivot;
  }

  NodeAvl<E> leftRightRotate(NodeAvl<E> node) {
    if (node.left == null) return node;
    node.left = leftRotate(node.left!);
    return rightRotate(node);
  }

  NodeAvl<E> rightLeftRotate(NodeAvl<E> node) {
    if (node.right == null) return node;
    node.right = rightRotate(node.right!);
    return leftRotate(node);
  }

  NodeAvl<E> balance(NodeAvl<E> node) {
    switch (node.balanceFactor) {
      case 2:
        final left = node.left;
        return left != null && left.balanceFactor == -1
            ? leftRightRotate(node)
            : rightRotate(node);
      case -2:
        final right = node.right;
        return right != null && right.balanceFactor == 1
            ? rightLeftRotate(node)
            : leftRotate(node);
      default:
        return node;
    }
  }
}

///
/// TODO: Understand Node Trie
///
class NodeTrie<T> {
  T? key;
  NodeTrie<T>? parent;

  NodeTrie({this.key, this.parent});

  final Map<T, NodeTrie<T>?> children = {};
  bool isTerminating = false;
}

class NodeTrieString {
  NodeTrie<int> root = NodeTrie(key: null, parent: null);

  void insert(String text) {
    var current = root;

    for (var codeUnit in text.codeUnits) {
      current.children[codeUnit] ??= NodeTrie(key: codeUnit, parent: current);
      current = current.children[codeUnit]!;
    }

    current.isTerminating = true;
  }

  bool contains(String text) {
    var current = root;
    for (var codeUnit in text.codeUnits) {
      final child = current.children[codeUnit];
      if (child == null) return false;
      current = child;
    }
    return current.isTerminating;
  }

  void remove(String text) {
    var current = root;
    for (var codeUnit in text.codeUnits) {
      final child = current.children[codeUnit];
      if (child == null) return;
      current = child;
    }
    if (!current.isTerminating) return;
    current.isTerminating = false;

    while (current.parent != null &&
        current.children.isEmpty &&
        !current.isTerminating) {
      current.parent!.children[current.key!] = null;
      current = current.parent!;
    }
  }

  ///
  /// match
  ///

  List<String> _moreMatches(String prefix, NodeTrie<int> node) {
    List<String> results = [];
    if (node.isTerminating) results.add(prefix);

    for (final child in node.children.values) {
      final codeUnit = child!.key!;
      results.addAll(
        _moreMatches('$prefix${String.fromCharCode(codeUnit)}', child),
      );
    }
    return results;
  }

  List<String> matchPrefix(String prefix) {
    var current = root;
    for (var codeUnit in prefix.codeUnits) {
      final child = current.children[codeUnit];
      if (child == null) return [];
      current = child;
    }

    return _moreMatches(prefix, current);
  }
}

///
/// [add]
/// [_forEachNodeDepthFirst], [_forEachNodeBreadthFirst]
/// [forEachNode], [forEachData]
/// [foldNode], [foldData]
/// [whereNode], [whereData]
///
///
class NodeTree<E> extends Vertex<E> {
  final List<NodeTree<E>> children;

  NodeTree(super.data, this.children);

  bool get isLeaf => children.isEmpty;

  void add(NodeTree<E> child) => children.add(child);

  void _forEachNodeDepthFirst(void Function(NodeTree<E> node) action) {
    action(this);
    for (final child in children) {
      child._forEachNodeDepthFirst(action);
    }
  }

  void _forEachNodeBreadthFirst(void Function(NodeTree<E> node) action) {
    action(this);
    final queue = <NodeTree<E>>[...children];
    while (queue.isNotEmpty) {
      var node = queue.removeFirst();
      action(node);
      node.children.forEach(queue.add);
    }
  }

  void forEachNode(
    void Function(NodeTree<E> node) action, {
    bool isDepthFirst = false, // false indicates breadth first
  }) =>
      isDepthFirst
          ? _forEachNodeDepthFirst(action)
          : _forEachNodeBreadthFirst(action);

  void forEachData(
    void Function(E data) action, {
    bool isDepthFirst = false, // false indicates breadth first
  }) =>
      forEachNode((node) => action(node.data), isDepthFirst: isDepthFirst);

  F foldNode<F>(
    F initialValue,
    F Function(F previousValue, NodeTree<E> node) combine,
  ) {
    var value = initialValue;
    forEachNode((node) => value = combine(value, node));
    return value;
  }

  F foldData<F>(F initialValue, F Function(F previousValue, E data) combine) {
    var value = initialValue;
    forEachData((data) => value = combine(value, data));
    return value;
  }

  List<NodeTree<E>> whereNode(E data) =>
      foldNode([], (list, n) => n.data == data ? (list..add(n)) : list);

  List<E> whereData(E data) =>
      foldData([], (list, d) => d == data ? (list..add(d)) : list);
}

/// TODO: Understand Heap
class Heap<E extends Comparable<dynamic>> {
  final List<E> elements;
  final bool isIncreasing;

  Heap({List<E>? elements, this.isIncreasing = false})
      : elements = elements ?? [] {
    _buildHeap();
  }

  @override
  String toString() => 'isIncreasing: $isIncreasing--$elements';

  bool get isEmpty => elements.isEmpty;

  int get size => elements.length;

  E? get peek => isEmpty ? null : elements.first;

  int _leftChildIndex(int parentIndex) => 2 * parentIndex + 1;

  int _rightChildIndex(int parentIndex) => 2 * parentIndex + 2;

  int _parentIndex(int childIndex) => (childIndex - 1) ~/ 2;

  bool _prioritize(E valueA, E valueB) => isIncreasing
      ? valueA.compareTo(valueB) < 0
      : valueA.compareTo(valueB) > 0;

  int _higherPriority(int indexA, int indexB) {
    final elements = this.elements;
    if (indexA >= elements.length) return indexB;
    final valueA = elements[indexA];
    final valueB = elements[indexB];
    final isAFirst = _prioritize(valueA, valueB);
    return isAFirst ? indexA : indexB;
  }

  void swap(int indexA, int indexB) => elements.swap(indexA, indexB);

  void _shiftUp(int index) {
    var child = index;
    var parent = _parentIndex(child);
    while (child > 0 && child == _higherPriority(child, parent)) {
      swap(child, parent);
      child = parent;
      parent = _parentIndex(child);
    }
  }

  void _shiftDown(int index) {
    var parent = index;
    while (true) {
      final left = _leftChildIndex(parent);
      final right = _rightChildIndex(parent);
      var chosen = _higherPriority(left, parent);
      chosen = _higherPriority(right, chosen);
      if (chosen == parent) return;
      swap(parent, chosen);
      parent = chosen;
    }
  }

  void insert(E value) {
    elements.add(value);
    _shiftUp(elements.length - 1);
  }

  E? removeAt(int index) {
    final lastIndex = elements.length - 1;
    if (index < 0 || index > lastIndex) return null;
    if (index == lastIndex) elements.removeLast();
    swap(index, lastIndex);
    final value = elements.removeLast();
    _shiftDown(index);
    _shiftUp(index);
    return value;
  }

  E? removeLast() {
    if (isEmpty) return null;
    swap(0, elements.length - 1);
    final value = elements.removeLast();
    _shiftDown(0);
    return value;
  }

  int indexOf(E value, {int index = 0}) {
    if (index >= elements.length) return -1;
    if (_prioritize(value, elements[index])) return -1;
    if (value == elements[index]) return index;
    final left = indexOf(value, index: _leftChildIndex(index));
    if (left != -1) return left;
    return indexOf(value, index: _rightChildIndex(index));
  }

  void _buildHeap() {
    if (isEmpty) return;
    final start = elements.length ~/ 2 - 1;
    for (var i = start; i >= 0; i--) {
      _shiftDown(i);
    }
  }
}

///
///
/// edge, graph
///
///

class Edge<E> {
  const Edge(
    this.source,
    this.destination,
    this.weight,
  );

  final Vertex<E> source;
  final Vertex<E> destination;
  final double weight;

  @override
  String toString() => '$source==$weight=>$destination';
}

enum EdgeType { directed, undirected }

abstract class Graph<E> {
  Iterable<Vertex<E>> get vertices;

  Vertex<E> createVertex(E data);

  void addEdge(
    Vertex<E> source,
    Vertex<E> destination, {
    EdgeType edgeType,
    double weight,
  });

  List<Edge<E>> edgesOf(Vertex<E> source);

  Iterable<Vertex<E>> destinationsOf(Vertex<E> source) =>
      edgesOf(source).map((e) => e.destination);

  double? weight(Vertex<E> source, Vertex<E> destination);

  List<Vertex<E>> breathFirstSearch(Vertex<E> source) {
    final queue = <Vertex<E>>[source];
    final enqueued = <Vertex<E>>[source];
    final visited = <Vertex<E>>[];

    while (true) {
      try {
        final current = queue.removeFirst(); // dequeue
        visited.add(current);
        final neighbors = destinationsOf(current);
        for (var destination in neighbors) {
          if (enqueued.notContains(destination)) {
            queue.add(destination);
            enqueued.add(destination);
          }
        }
      } catch (_) {
        break;
      }
    }

    return visited;
  }

  List<Vertex<E>> depthFirstSearch(Vertex<E> source) {
    final stack = <Vertex<E>>[];
    final pushed = <Vertex<E>>[];
    final visited = <Vertex<E>>[];

    stack.add(source);
    pushed.add(source);
    visited.add(source);

    outerLoop:
    while (stack.isNotEmpty) {
      final neighbors = destinationsOf(stack.last);
      for (var destination in neighbors) {
        if (pushed.notContains(destination)) {
          stack.add(destination);
          pushed.add(destination);
          visited.add(destination);
          continue outerLoop;
        }
      }
      stack.removeLast(); // pop
    }

    return visited;
  }

  bool hasCycle(Vertex<E> source) => _hasCycle(source, <Vertex<E>>[]);

  bool _hasCycle(Vertex<E> source, List<Vertex<E>> pushed) {
    pushed.add(source);
    final neighbors = destinationsOf(source);
    for (var destination in neighbors) {
      if (pushed.contains(destination)) return true;
      if (_hasCycle(destination, pushed)) return true;
    }
    pushed.remove(source);
    return false;
  }

  ///
  /// TODO: Understand Dijkstra
  ///
  Map<Vertex<E>, VertexComparable<E>?> shortestPathsOf(Vertex<E> source) {
    final queue = Heap<VertexComparable<E>>(isIncreasing: true);
    final visited = <Vertex<E>>{};
    final paths = <Vertex<E>, VertexComparable<E>?>{};
    for (var vertex in vertices) {
      paths[vertex] = null;
    }
    final v = VertexComparable(0, source.data);
    queue.insert(v);
    paths[source] = v;
    visited.add(source);

    while (!queue.isEmpty) {
      final current = queue.removeLast()!;
      final saveDistance = paths[current]!.value;
      if (current.value > saveDistance) continue;
      visited.add(current);

      final edges = edgesOf(current);
      for (var edge in edges) {
        final neighbor = edge.destination;
        if (visited.contains(neighbor)) continue;
        final totalDistance = current.value + edge.weight;
        final knownDistance = paths[neighbor]?.value ?? double.infinity;
        if (totalDistance < knownDistance) {
          paths[neighbor] = VertexComparable(totalDistance, current.data);
          queue.insert(VertexComparable(totalDistance, neighbor.data));
        }
      }
    }

    return paths;
  }

  List<Vertex<E>> shortestPathOf(
    Vertex<E> source,
    Vertex<E> destination, {
    Map<Vertex<E>, VertexComparable<E>?>? paths,
  }) {
    final allPaths = paths ?? shortestPathsOf(source);
    if (!allPaths.containsKey(destination)) return [];
    var current = destination;
    final path = <Vertex<E>>[current];
    while (current != source) {
      final previous = allPaths[current];
      if (previous == null) return [];
      path.add(previous);
      current = previous;
    }
    return path.reversed.toList();
  }
}

mixin GraphVertexComparable<E> on Graph<E> {
  int _index = 0;

  int _indexOf(Vertex<E> v) => (v as VertexComparable<E>).value as int;
}

class AdjacencyList<E> extends Graph<E> with GraphVertexComparable<E> {
  final Map<VertexComparable<E>, List<Edge<E>>> _connections = {};

  @override
  Iterable<Vertex<E>> get vertices => _connections.keys;

  @override
  Vertex<E> createVertex(E data) {
    final vertex = VertexComparable(_index, data);
    _index++;
    _connections[vertex] = [];
    return vertex;
  }

  @override
  void addEdge(
    Vertex<E> source,
    Vertex<E> destination, {
    EdgeType edgeType = EdgeType.undirected,
    double weight = double.infinity,
  }) {
    _connections[source]?.add(Edge(source, destination, weight));
    if (edgeType == EdgeType.undirected) {
      _connections[destination]?.add(Edge(destination, source, weight));
    }
  }

  @override
  List<Edge<E>> edgesOf(Vertex<E> source) => _connections[source] ?? [];

  @override
  double weight(
    Vertex<E> source,
    Vertex<E> destination,
  ) {
    final match = edgesOf(source).where((edge) {
      return edge.destination == destination;
    });
    if (match.isEmpty) return double.infinity;
    return match.first.weight;
  }

  @override
  String toString() => _connections
      .fold(
        StringBuffer(),
        (buffer, entry) =>
            buffer..writeln('${entry.key} --> ${entry.value.join(', ')}'),
      )
      .toString();
}

class AdjacencyMatrix<E> extends Graph<E> with GraphVertexComparable<E> {
  final List<Vertex<E>> _vertices = [];
  final List<List<double?>?> _weights = [];

  @override
  Iterable<Vertex<E>> get vertices => _vertices;

  @override
  Vertex<E> createVertex(E data) {
    final vertex = VertexComparable(_index, data);
    _index++;
    _vertices.add(vertex);
    for (var i = 0; i < _weights.length; i++) {
      _weights[i]?.add(null);
    }
    _weights.add(List<double?>.filled(_vertices.length, null)); // row
    return vertex;
  }

  @override
  void addEdge(
    Vertex<E> source,
    Vertex<E> destination, {
    EdgeType edgeType = EdgeType.undirected,
    double weight = double.infinity,
  }) {
    final si = _indexOf(source);
    final di = _indexOf(destination);

    _weights[si]?[di] = weight;
    if (edgeType == EdgeType.undirected) _weights[di]?[si] = weight;
  }

  @override
  List<Edge<E>> edgesOf(Vertex<E> source) {
    final si = _indexOf(source);
    final edges = <Edge<E>>[];
    for (var column = 0; column < _weights.length; column++) {
      final weight = _weights[si]?[column];
      if (weight != null) {
        edges.add(Edge(source, _vertices[column], weight));
      }
    }
    return edges;
  }

  @override
  double weight(Vertex<E> source, Vertex<E> destination) =>
      _weights[_indexOf(source)]?[_indexOf(destination)] ?? double.infinity;

  @override
  String toString() {
    final buffer = StringBuffer();
    for (final vertex in _vertices) {
      buffer.writeln('${_indexOf(vertex)}: ${vertex.data}');
    }
    for (int i = 0; i < _weights.length; i++) {
      for (int j = 0; j < _weights.length; j++) {
        buffer.write((_weights[i]?[j] ?? '.').toString().padRight(6));
      }
      buffer.writeln();
    }
    return buffer.toString();
  }
}
