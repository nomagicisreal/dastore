///
///
/// this file contains:
/// [Array2D], [Matrix]
/// [Vertex], [Node], [Edge]
/// [ListBool]
///
/// and more...
/// [EncryptingUtil], ...
/// [SearchingUtil], ...
/// [SequencingUtil], ...
/// [SortingUtil], ...
///
/// TODO: Minimum Spanning Trees
/// TODO: meta algorithm: https://www.blocktempo.com/interpretation-of-meta-algorithm/
/// TODO: Deepmind sorting https://www.nature.com/articles/s41586-023-06004-9
/// TODO: algorithm animation
///
///
///
/// [IterableEdgeExtension]
/// [SetVertexExtension]
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


final List<num> _sampleItems1 = [15, 22, 13, 27, 12, 10, 25, 20];
final List<num> _sampleItems2 = [11, 32, 9, 24, 17, 20, 21, 22];

class Array2D<T> {
  final List<List<T>> _data;

  int get rowCount => _data.length;

  int get columnCount => _data[0].length;

  List<List<T>> get data => _data;

  Array2D(this._data)
      : assert(() {
          final columnCount = _data.first.length;
          return _data.every((element) => element.length == columnCount);
        }());

  Array2D.from(int rowCount, int columnCount, Generator2D<T> generator)
      : _data = _dataOf(rowCount, columnCount, generator);

  Array2D.square(int size, Generator2D<T> generator)
      : _data = _dataOf(size, size, generator);

  static List<List<T>> _dataOf<T>(
    int rowCount,
    int columnCount,
    Generator2D<T> generator,
  ) =>
      List.generate(
        rowCount,
        (i) => List.generate(columnCount, (j) => generator(i, j)),
      );

  @override
  String toString() => _data.mapToStringJoin();

  String toStringPadLeft(int space) => _data.mapToStringJoin(
        (row) => row.map((e) => e.toString().padLeft(space)).toString(),
      );

  List<T> operator [](int i) => _data[i];

  bool isSizeEqual(Array2D<T> another) =>
      columnCount == another.columnCount && rowCount == another.rowCount;
}

///
/// [Matrix] index start with 1, not 0,
///
class Matrix extends Array2D<num> {
  Matrix(List<List<num>> data) : super(data);

  Matrix.from(int rowCount, int columnCount, Generator2D<num> generator)
      : super.from(rowCount, columnCount, generator);

  @override
  String toString() => _data.mapToStringJoin((e) => e.skip(1).toString());

  @override
  List<num> operator [](int i) => _data[i - 1];

  @override
  bool isSizeEqual(covariant Matrix another) => super.isSizeEqual(another);

  Matrix operator +(Matrix another) {
    assert(isSizeEqual(another));
    return Matrix.from(
      rowCount,
      columnCount,
      (i, j) => this[i][j] + another[i][j],
    );
  }

  Matrix operator -(Matrix another) {
    assert(isSizeEqual(another));
    return Matrix.from(
      rowCount,
      columnCount,
      (i, j) => this[i][j] - another[i][j],
    );
  }

  ///
  /// TODO: Strassen’s Matrix Multiplication
  ///
  Matrix operator *(Matrix another) {
    final kN = columnCount;
    assert(kN == another.rowCount);
    return Matrix.from(
      rowCount,
      another.columnCount,
      (i, j) {
        num sum = 0;
        for (var k = 1; k <= kN; k++) {
          sum += this[i][k] * another[k][j];
        }
        return sum;
      },
    );
  }

  ///
  /// TODO: Chained Matrix Multiplication
  ///
  static Matrix multiplicationOf(List<Matrix> matrices) {
    throw UnimplementedError();
  }
}

class Vertex<T> {
  final T value;

  const Vertex(this.value);

  @override
  bool operator ==(covariant Vertex<T> other) => value == other.value;

  @override
  int get hashCode => value.hashCode;
}

class Node<T> extends Vertex<T> {
  final Vertex<T> left;
  final Vertex<T> right;

  const Node(super.value, this.left, this.right);
}

class Edge<T> {
  final Vertex<T> source;
  final Vertex<T> destination;
  final double weight;

  Iterable<Vertex<T>> get corners => [source, destination];

  const Edge(this.source, this.destination, this.weight);

  bool has(Vertex<T> vertex) => source == vertex || destination == vertex;

  bool notHas(Vertex<T> vertex) => !has(vertex);

  bool hasCornerIn(Set<Vertex<T>> vertices) => vertices.any((v) => has(v));

  bool hasCornerNotIn(Set<Vertex<T>> vertices) =>
      vertices.any((v) => notHas(v));

  bool noCornerIn(Set<Vertex<T>> vertices) => !hasCornerIn(vertices);

  bool isIn(Set<Vertex<T>> vertices) => !hasCornerNotIn(vertices);

  bool isBridgeIn(Set<Vertex<T>> vertices) {
    final list = vertices.toList();
    final hasCornerIn = has(list.removeFirst());
    return list.any((v) => has(v) != hasCornerIn);
  }

  Vertex<T> opposite(Vertex<T> a) => a == source ? destination : source;

  bool operator <(covariant Edge<T> another) => weight < another.weight;

  bool operator >(covariant Edge<T> another) => weight > another.weight;
}

///
/// [true, true] != [true, true]
/// const [true, true] == const [true, true]
///
/// [ListBool] is defined to make List<bool> equal to another List<bool> with same elements
///
final class ListBool {
  final List<bool> _value;

  const ListBool(this._value);

  @override
  bool operator ==(covariant ListBool other) {
    final vThis = _value;
    final vOther = other._value;
    final l = vThis.length;
    if (l == vOther.length) {
      int i = 0;
      for (; i < l; i++) {
        if (vThis[i] != vOther[i]) break;
      }
      if (i == l) return true;
    }
    return false;
  }

  @override
  int get hashCode => _value.hashCode;
}

///
///
///
///
///
/// Encrypting
/// [EncryptingUtil]
/// [EncryptingStreamUtil]
///
/// [HuffManCode]
///
///
///
///

class EncryptingUtil {
  const EncryptingUtil._();
}

class EncryptingStreamUtil {
  const EncryptingStreamUtil._();
}

class HuffManCode<S> {
  final Map<ListBool, S> _byteSymbol;
  final Map<S, ListBool> _symbolByte;

  HuffManCode._(this._byteSymbol, this._symbolByte);

  // factory HuffManCode(Iterable<S> symbols) {
  //   final probability = symbols.probability;
  //
  //   final entries = probability.entries.toList(); // TODO: HuffmanCode probability to Map<S, int>
  //   SortingUtil.quickSort(probability.values.toList());
  //   probability.entries.indexed;
  //   // instead of 0 and 1, using 1 and 2
  //
  //   // return HuffManCode._({});
  // }

  S? operator [](ListBool byte) => _byteSymbol[byte];

  ListBool? operator &(S symbol) => _symbolByte[symbol];
}

///
///
///
///
///
/// Searching
///
/// [SearchingUtil]
/// [SearchingStreamUtil]
///
///
///
///
///
///

///
/// see also [binarySearch]
///
class SearchingUtil {
  const SearchingUtil._();
}

///
/// [sequential]
/// [binary]
///
class SearchingStreamUtil {
  static Stream<List<T>> sequential<T>(
    List<T> list,
    T value, {
    Duration delay = KDuration.milli100,
  }) async* {
    final length = list.length;

    yield list;
    for (var i = 0; i < length; i++) {
      await Future.delayed(delay);
      final current = list.first;
      if (current == value) {
        yield [current];
        break;
      } else {
        yield list..removeFirst();
      }
    }
  }

  static Stream<List<num>> binary(
    List<num> list,
    num value, {
    Duration delay = KDuration.milli100,
  }) async* {
    int low = 0;
    int high = list.length - 1;
    List<num> remains = list;

    yield remains;
    while (remains.length > 1) {
      await Future.delayed(delay);

      final mid = (low + high) ~/ 2;
      final current = list[mid];

      if (value == current) {
        remains = [value];
      } else {
        if (value < current) {
          high = mid - 1;
        } else {
          low = mid + 1;
        }
        remains = list.sublist(low, high + 1);
      }

      yield remains;
    }
  }
}

///
///
///
///
/// Sequencing
///
/// [SequencingUtil]
/// [SequencingStreamUtil]
///
///
///
///

///
/// [fibonacci]
/// [pascalTriangle]
/// [binomialCoefficient], [binomialCoefficientWithCheck]
/// [floydShortest]
///
///
class SequencingUtil {
  const SequencingUtil._();

  static int fibonacci(int k) {
    assert(k > 0);
    int a = 0;
    int b = 1;

    for (var i = 2; i <= k; i++) {
      final next = a + b;
      a = b;
      b = next;
    }
    return b;
  }

  ///
  /// 1,
  /// 1, 1
  /// 1, 2, 1
  /// 1, 3, 3, 1
  /// 1, 4, 6, 4, 1
  /// 1, 5, 10, 10, 5, 1
  /// 1, 6, 15, 20, 15, 6, 1 ...,
  ///
  /// when [rowStart] == 2, return array be like:
  ///   row0: [1, 2, 1, 0, ....]
  ///   row1: [1, 3, 3, 1, ....]
  ///   row2: [1, 4, 6, 4, ....] ...
  /// when [rowStart] == 3, return array be like:
  ///   row0: [1, 3, 3, 1, ....]
  ///   row1: [1, 4, 6, 4, ....]
  ///   row2: [1, 5, 10, 10, ....] ...
  /// ...
  ///
  /// belows are the process of [pascalTriangle]
  /// 1. initializing array parameters ([rowEnd], columnEnd generator according to row)
  /// 2. creating temporary array, for example,
  ///   row0: [1, 2, 1, 0, 0, 0]
  ///   row1: [1, 3, 3, 1, 0, 0]
  ///   row2: [1, 4, 0, 4, 1, 0]
  ///   row3: [1, 5, 0, 0, 5, 1] ...
  /// 2. replacing 'middle 0' with the correct value. for example,
  ///   row0: [1, 2, 1, 0, 0, 0]
  ///   row1: [1, 3, 3, 1, 0, 0]
  ///   row2: [1, 4, 6, 4, 1, 0]
  ///   row3: [1, 5, 10, 10, 5, 1] ...
  ///
  static Array2D<int> pascalTriangle(
    int n,
    int k, {
    int rowStart = 0,
    bool isColumnEndAtK = true,
  }) {
    assert(
      n > 0 && k > 0 && k <= n + 1 && rowStart < 4,
      throw ArgumentError('($n, $k)'),
    );

    final rowEnd = n + 1 - rowStart;
    final columnEndOf =
        isColumnEndAtK ? (i) => i + rowStart < k ? i + 1 : k : (i) => i + 1;

    final array = Array2D<int>.from(
      rowEnd,
      k,
      (i, j) => j == 0 || j == i + rowStart
          ? 1
          : j == 1 || j == i + rowStart - 1
              ? i + rowStart
              : 0,
    );

    for (int i = 4 - rowStart; i < rowEnd; i++) {
      final bound = columnEndOf(i);
      for (int j = 2; j < bound; j++) {
        array[i][j] = array[i - 1][j - 1] + array[i - 1][j];
      }
    }
    return array;
  }

  ///
  /// [binomialCoefficient] calculate only necessary values, for example,
  ///   row( 8 ) = (... 28,    8,    1)
  ///   row( 9 ) = (...  ?,   36,    9)
  ///   row( 10 ) = (...  ?,    ?,   45)
  /// '45' comes from '36+9', '36' comes from '18+8', '9' comes from '8+1'. It's redundant to calculate '?'.
  /// If "floor" indicates essential values in "row", solution for '45'(n = 10, k = 9) requires:
  ///   floor( 2 ) = [1, 2, 1]
  ///   floor( 3 ) = [3, 3, 1]
  ///   floor( 4 ) = [6,  4,  1]
  ///   floor( 5 ) = [10,  5,  1]
  ///   floor( 6 ) = [15,  6,  1]
  ///   floor( 7 ) = [21,  7,  1]
  ///   floor( 8 ) = [28,  8,  1]
  ///   floor( 9 ) = [36,  9]
  ///   floor( 10 ) = [45] #
  /// in short, [binomialCoefficient] find last "floor" in an efficient and dynamic-programing way.
  ///
  /// the description below describes what meaning of the variables used in [binomialCoefficient]
  /// - [fEnd] is the last floor that floor[k] is 1.
  ///   take the sample above for example, because
  ///     floor( 10 ) = [45],
  ///     floor( 9 ) = [36,  9],
  ///     floor( 8 ) = [28,  8,  1] (floor(8)[9] == 1),
  ///     [fEnd] == 8 #.
  ///   if takes more example, it will turn out that [fEnd] = k - 1 #
  ///
  /// - [fBegin] is the first floor floor.length == "max length during acceleration" == floor([fEnd]).length,
  ///   take the sample above for example, n = 10, k = 9, [fEnd] = 8, because
  ///     floor( 8 ).length == 3
  ///     ...
  ///     floor( 2 ).length == 3 (floor( 2 ) is the first floor that floor.length == floor(8).length)
  ///     [fBegin] = 2 #
  ///   if takes more example, it will turn out that [fBegin] = n - [fEnd] #
  ///
  static int binomialCoefficient(int n, int k) {
    assert(n > 2 && k > 0 && k <= n + 1, throw ArgumentError('($n, $k)'));

    final currentFloor = <int>[1, 2, 1];
    final fEnd = k - 1;
    final fBegin = n - fEnd;
    List<int> floorOf(int f) {
      final length = currentFloor.length;
      return <int>[
        if (f <= fBegin) 1,
        for (var j = 1; j < length; j++) currentFloor[j - 1] + currentFloor[j],
        if (f <= fEnd) 1,
      ];
    }

    for (var f = 3; f < n; f++) {
      final floor = floorOf(f);
      currentFloor
        ..clear()
        ..addAll(floor);
    }
    return floorOf(n).first;
  }

  ///
  /// sometimes, invoking [binomialCoefficientWithCheck] is more efficient than [binomialCoefficient]
  ///
  static int binomialCoefficientWithCheck(int n, int k) {
    assert(n > 0 && k > 0 && k <= n + 1, throw ArgumentError('($n, $k)'));
    return k == 1 || k == n + 1
        ? 1
        : k == 2 || k == n
            ? n
            : binomialCoefficient(n, k);
  }

  ///
  /// TODO: Floyd Algorithm (All-Source-Shortest Path)
  /// TODO: Dijkstra Algorithm (Single-Source-Shortest Path)
  ///
  static Array2D<num> floydShortest(Array2D<num> rawPath) {
    final raw = rawPath.data;
    final size = raw.length;
    assert(size == raw[0].length);
    for (var i = 0; i < raw.length; i++) {
      assert(raw[i][i] == 0);
    }

    final shortest = Array2D.square(size, (i, j) => double.infinity);
    // for (var k = 0; k < size; k++) {
    //   for (var i = 0; i < size; i++) {
    //     for (var j = 0; j < size; j++) {
    //       shortest[i][j] = min(shortest[i][j], shortest[i][k] + shortest[k][j]);
    //     }
    //   }
    // }

    ///
    /// 1. D(0)[a][b]
    /// 2. D(1)[a][b]
    /// 3. D(2)[a][b]
    /// ...
    /// n-1. D(n-1)[a][b]
    ///
    /// everytime finding shortest path P, it's necessary to update the path using P
    ///

    throw UnimplementedError();
  }

  ///
  /// TODO: Traveling Salesperson Problem for shortest
  ///
  static Array2D<num> travelingShortest(Array2D<num> rawPath) {
    final raw = rawPath.data;
    final size = raw.length;
    assert(size == raw[0].length);
    for (var i = 0; i < raw.length; i++) {
      assert(raw[i][i] == 0);
    }

    throw UnimplementedError();
  }

  ///
  /// TODO: Pairwise Sequence Alignment
  ///
  /// take sequence (X, Y) for example,
  /// X -> A A C A G T T A C C
  /// Y -> T A A G G T C A
  /// - alignment 1:
  ///   _ A A C A G T T A C C
  ///   T A A _ G G T _ _ C A
  /// - alignment 2
  ///   A A C A G T T A C C
  ///   T A _ A G G T _ C A
  /// the gap indicates the insertion or deletion, if mismatch penalty = m, deletion penalty = d,
  ///   penalty of alignment 1 = 2m + 4d
  ///   penalty of alignment 2 = 3m + 2d
  /// [pairwiseSequenceAlignment] is a method to find the best alignment with minimum penalty sum
  ///
  ///
  static MapEntry<String, String> pairwiseSequenceAlignment(
    String x,
    String y, {
    int penaltyMatch = 0,
    int penaltyMismatch = 1,
    int penaltyDeletion = 2,
  }) {
    ///
    ///
    /// define S(k) = S[k...last]
    /// opt(S1[i], S2[j]) = min(
    ///   opt(S1[i+1], S2[j+1]) + m,
    ///   opt(S1[i+1], S2[j]) + d,
    ///   opt(S1[i], S2[j+1]) + d,
    /// );
    ///

    throw UnimplementedError();
  }
}

///
///
/// [fibonacci]
/// [binomialCoefficient]
///
///
class SequencingStreamUtil {
  const SequencingStreamUtil._();

  static Stream<int> fibonacci(
    int k, {
    Duration delay = KDuration.milli100,
  }) async* {
    assert(k > 0);
    final list = [0, 1];
    yield 1;

    for (var i = 2; i <= k; i++) {
      await Future.delayed(delay);
      final a = list[i - 2];
      final b = list[i - 1];
      final c = a + b;
      list.add(c);
      yield c;
    }
  }

  static Stream<List<int>> binomialCoefficient(
    int n,
    int k, {
    Duration delay = KDuration.milli100,
  }) async* {
    assert(n > 2 && k > 0 && k <= n + 1, throw ArgumentError('($n, $k)'));

    final currentFloor = <int>[1, 2, 1];
    final fEnd = k - 1;
    final fBegin = n - fEnd;
    List<int> floorOf(int i) {
      final length = currentFloor.length;
      return <int>[
        if (i <= fBegin) 1,
        for (var j = 1; j < length; j++) currentFloor[j - 1] + currentFloor[j],
        if (i <= fEnd) 1,
      ];
    }

    yield currentFloor;
    for (var i = 3; i < n; i++) {
      await Future.delayed(delay);
      final floor = floorOf(i);
      yield currentFloor
        ..clear()
        ..addAll(floor);
    }
    await Future.delayed(delay);
    yield floorOf(n);
  }

  static Stream<Array2D<num>> floydShortestCubic(
    Array2D<num> rawPaths, {
    Duration delay = KDuration.milli100,
  }) async* {
    final raw = rawPaths.data;
    final size = raw.length;
    assert(size == raw[0].length);
    for (var i = 0; i < raw.length; i++) {
      assert(raw[i][i] == 0);
    }

    final shortest = Array2D.square(size, (i, j) => double.infinity);

    yield shortest;
    for (var k = 0; k < size; k++) {
      for (var i = 0; i < size; i++) {
        for (var j = 0; j < size; j++) {
          await Future.delayed(delay);
          shortest[i][j] =
              math.min(shortest[i][j], shortest[i][k] + shortest[k][j]);
          yield shortest;
        }
      }
    }
  }
}

///
///
///
///
/// Sorting
///
///
///
///
/// [SortingUtil]
/// [SortingStreamUtil]
///
///

///
/// [_merge], [mergeSort]
/// [_partition], [quickSort]
///
class SortingUtil {
  const SortingUtil._();

  ///
  /// before calling [_merge],
  /// the elements of [listA] and [listB] should be sorted in order of [compare]
  ///
  static List<num> _merge(
    List<num> listA,
    List<num> listB, [
    bool Function(num a, num b) compare = FPredicatorNum.isALess, // increase
  ]) {
    final result = <num>[];
    final lengthA = listA.length;
    final lengthB = listB.length;
    int i = 0;
    int j = 0;
    while (i < lengthA && j < lengthB) {
      final a = listA[i];
      final b = listB[j];
      if (compare(a, b)) {
        result.add(a);
        i++;
      } else {
        result.add(b);
        j++;
      }
    }
    return result..addAll(i < lengthA ? listA.sublist(i) : listB.sublist(j));
  }

  static List<num> mergeSort(
    List<num> list, [
    bool isIncreasing = true,
  ]) {
    final predicator =
        isIncreasing ? FPredicatorNum.isALess : FPredicatorNum.isALarger;
    final length = list.length;

    // regarding current list as the mix of 2 elements sublist,
    // sorting for each sublist
    final max = length.isEven ? length : length - 1;
    for (var start = 0; start < max; start += 2) {
      final a = list[start];
      final b = list[start + 1];
      if (!predicator(a, b)) {
        list[start] = b;
        list[start + 1] = a;
      }
    }
    int sorted = 2;

    // regarding current list as the mix of sorted sublists,
    // merging sublists into bigger ones (2 elements -> 4 elements -> 8 elements -> ... -> n elements)
    while (sorted * 2 <= length) {
      final target = sorted * 2;
      final remain = length % target;
      final max = remain > sorted ? length : length - remain;
      for (var start = 0; start < max; start += target) {
        final interval = start + sorted;
        final end = start + target < length ? start + target : length;
        list.replaceRange(
          start,
          end,
          SortingUtil._merge(
            list.sublist(start, interval),
            list.sublist(interval, end),
            predicator,
          ),
        );
      }
      sorted *= 2;
    }
    return list;
  }

  ///
  /// partition by the the pivot item (list[high])
  ///
  static int _partition<T>(
    List<T> list,
    int low,
    int high,
    bool Function(T a, T b) compare,
  ) {
    final pivot = list[high];
    int i = low;
    int j = low;

    // find the first item index that 'compare(item, pivot) == false'
    for (; j < high; j++) {
      if (compare(list[j], pivot)) {
        i++;
      } else {
        break;
      }
    }

    // ensuring items that less/large than pivot in front of list,
    // exchanging with the item that 'compare(item, pivot) == false'
    for (; j < high; j++) {
      final current = list[j];
      if (compare(current, pivot)) {
        list[j] = list[i];
        list[i] = current;
        i++;
      }
    }
    list[high] = list[i];
    list[i] = pivot;

    return i;
  }

  static List<T> quickSort<T>(
    List<T> list, {
    bool isIncreasing = true,
  }) {
    final compare = switch (list) {
      List<num>() =>
        isIncreasing ? FPredicatorNum.isALess : FPredicatorNum.isALarger,
      List<MapEntry<num, dynamic>>() => isIncreasing
          ? FPredicatorNum.isEntryKeyLess
          : FPredicatorNum.isEntryKeyLarger,
      _ => throw UnimplementedError(),
    } as bool Function(T a, T b);

    void sorting(int low, int high) {
      if (low < high) {
        final pivotPosition = _partition(list, low, high, compare);
        sorting(low, pivotPosition - 1);
        sorting(pivotPosition + 1, high);
      }
    }

    if (list.length > 1) {
      sorting(0, list.length - 1);
    }

    return list;
  }

  ///
  /// TODO: Optimal Binary Search Tree
  ///
  static Node<T> optimalBinaryNode<T>(Node<T> node) {
    throw UnimplementedError();
  }
}

///
///
/// [exchangeSort]
/// [insertionSort]
/// [mergeSort]
/// [quickSort]
///
///
class SortingStreamUtil {
  const SortingStreamUtil._();

  static Stream<List<num>> exchangeSort(
    List<num> list, {
    bool isIncreasing = true,
    Duration delay = KDuration.milli100,
  }) async* {
    yield list;

    final length = list.length;
    final shouldExchange =
        isIncreasing ? FPredicatorNum.isALarger : FPredicatorNum.isALess;
    for (var i = 0; i < length; i++) {
      for (var j = i; j < length; j++) {
        await Future.delayed(delay);
        final a = list[i];
        final b = list[j];
        if (shouldExchange(a, b)) {
          list[i] = b;
          list[j] = a;
        }
        yield list;
      }
    }
  }

  static Stream<List<num>> insertionSort(
    List<num> list, {
    bool isIncreasing = true,
    Duration delay = KDuration.milli100,
  }) async* {
    yield list;

    final length = list.length;
    final shouldInsert =
        isIncreasing ? FPredicatorNum.isALess : FPredicatorNum.isALarger;
    for (var i = 1; i < length; i++) {
      final current = list[i];
      for (var j = i - 1; j >= 0; j--) {
        await Future.delayed(delay);
        final previous = list[j];
        if (shouldInsert(current, previous)) {
          list[j] = current;
          list[j + 1] = previous;
        }
        yield list;
      }
    }
  }

  static Stream<List<num>> mergeSort(
    List<num> list, {
    Duration delay = KDuration.milli100,
    bool Function(num a, num b) compare = FPredicatorNum.isALess, // increase
  }) async* {
    final length = list.length;
    yield list;

    // sorting
    await Future.delayed(delay);
    final max = length.isEven ? length : length - 1;
    for (var start = 0; start < max; start += 2) {
      final a = list[start];
      final b = list[start + 1];
      if (!compare(a, b)) {
        list[start] = b;
        list[start + 1] = a;
      }
    }
    int sorted = 2;
    yield list;

    // merging
    while (sorted * 2 <= length) {
      await Future.delayed(delay);

      final target = sorted * 2;
      final remain = length % target;
      final max = remain > sorted ? length : length - remain;
      for (var start = 0; start < max; start += target) {
        final interval = start + sorted;
        final end = start + target < length ? start + target : length;
        list.replaceRange(
          start,
          end,
          SortingUtil._merge(
            list.sublist(start, interval),
            list.sublist(interval, end),
            compare,
          ),
        );
      }
      sorted *= 2;

      yield list;
    }
  }

  static Stream<List<num>> quickSort(
    List<num> list, {
    Duration delay = KDuration.milli100,
    bool Function(num a, num b) compare = FPredicatorNum.isALess, // increase
  }) async* {
    Stream<List<num>> sorting(int low, int high) async* {
      if (low < high) {
        final pivotPosition = SortingUtil._partition(list, low, high, compare);
        yield list;

        await Future.delayed(delay);
        yield* sorting(low, pivotPosition - 1);

        await Future.delayed(delay);
        yield* sorting(pivotPosition + 1, high);
      }
    }

    if (list.length > 1) {
      yield* sorting(0, list.length - 1);
    } else {
      yield list;
    }
  }
}


///
///
///
///
/// extensions
///
///
///
///
///

extension IterableEdgeExtension<T> on Iterable<Edge<T>> {
  bool anyConnect(Vertex<T> vertex) => any((edge) => edge.has(vertex));

  Iterable<Edge<T>> whereConnect(Vertex<T> v) => where((e) => e.has(v));
}


extension SetVertexExtension<T> on Set<Vertex<T>> {
  bool isEveryContainedBy(Iterable<Edge<T>> edges) {
    for (var v in this) {
      if (!edges.anyConnect(v)) return false;
    }
    return true;
  }

  ///
  /// TODO: Minimum Spanning Tree - Prim
  ///
  Set<Edge<T>> prim(Set<Edge<T>> edgesSet) {
    assert(isEveryContainedBy(edgesSet));

    final edges = edgesSet.toList();
    final vertices = toList();
    final spanning = {vertices.removeFirst()};
    final result = <Edge<T>>{};

    while (vertices.isNotEmpty) {
      final contained = edges
        ..removeWhereAndGet((edge) => edge.hasCornerIn(spanning));

      // 1. filter edges (find all shortest path to different vertex)
      // 2. add all different-shortest edges to the spanning set
    }

    throw UnimplementedError();
  }

  ///
  /// TODO: Minimum Spanning Tree - Kruskal
  ///
  Set<Edge<T>> kruskal(Set<Edge<T>> edgesSet) {
    assert(isEveryContainedBy(edgesSet));

    final edges = SortingUtil.quickSort(edgesSet.toList());
    final sets = fold(<Set<Vertex<T>>>[], (list, v) => list..add({v}));
    final result = <Edge<T>>{edges.removeFirst()};

    for (var edge in edges) {
      if (sets.any(edge.isIn)) continue;
      sets.mergeWhereAndRemoveAllAndAdd((set) => edge.hasCornerIn(set));
      result.add(edge);
      if (sets.length == 1) break;
    }
    return result;
  }
}

