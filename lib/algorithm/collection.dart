///
///
/// this file contains:
///
/// [NumExtension], [DoubleExtension], [IntExtension]
///
///
/// [IterableExtension]
/// [IterableIntExtension], [IterableOffsetExtension], [IterableTimerExtension]
/// [IterableIterableExtension], [IterableSetExtension]
///
///
/// [ListExtension]
/// [ListOffsetExtension]
/// [ListListExtension], [ListSetExtension]
///
///
/// [MapEntryExtension]
/// [MapEntryIterableExtension]
/// [MapExtension]
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
part of dastore;

///
///
/// [square]
/// [rangeIn]
/// [isLowerOrEqualTo], [isHigherOrEqualTo]
/// [isLowerOneOrEqualTo], [isHigherOneOrEqualTo]
///
///
extension NumExtension on num {
  num get square => math.pow(this, 2);

  bool rangeIn(num min, num max) => this >= min && this <= max;

  bool isLowerOrEqualTo(num value) => this == value || this < value;

  bool isHigherOrEqualTo(num value) => this == value || this > value;

  bool isLowerOneOrEqualTo(num value) => this == value || this + 1 == value;

  bool isHigherOneOrEqualTo(num value) => this == value || this == value + 1;
}

///
///
/// [sqrt2], ...
/// [toCircularRadius]
/// [isNearlyInt]
///
/// [proximateInfinityOf], [proximateNegativeInfinityOf]
/// [infinity2_31], ...
/// [filterInfinity]
///
///
extension DoubleExtension on double {
  static const double sqrt2 = math.sqrt2;
  static const double sqrt3 = 1.7320508075688772;
  static const double sqrt5 = 2.23606797749979;
  static const double sqrt6 = 2.44948974278317;
  static const double sqrt7 = 2.6457513110645907;
  static const double sqrt8 = 2.8284271247461903;
  static const double sqrt10 = 3.1622776601683795;
  static const double sqrt1_2 = math.sqrt1_2;
  static const double sqrt1_3 = 0.5773502691896257;
  static const double sqrt1_5 = 0.4472135954999579;
  static const double sqrt1_6 = 0.408248290463863;
  static const double sqrt1_7 = 0.3779644730092272;
  static const double sqrt1_8 = 0.3535533905932738;
  static const double sqrt1_10 = 0.31622776601683794;

  Radius get toCircularRadius => Radius.circular(this);

  bool get isNearlyInt => (ceil() - this) <= 0.01;

  ///
  /// infinity usages
  ///
  static double proximateInfinityOf(double precision) =>
      1.0 / math.pow(0.1, precision);

  static double proximateNegativeInfinityOf(double precision) =>
      -1.0 / math.pow(0.1, precision);

  static final double infinity2_31 = proximateInfinityOf(2.31);
  static final double infinity3_2 = proximateInfinityOf(3.2);

  double filterInfinity(double precision) => switch (this) {
        double.infinity => proximateInfinityOf(precision),
        double.negativeInfinity => proximateNegativeInfinityOf(precision),
        _ => this,
      };
}

///
/// instance methods, getters:
/// [digit], [digitFirst]
/// [accumulate], [factorial]
///
/// static methods:
/// [accumulation]
/// [fibonacci]
/// [pascalTriangle]
/// [binomialCoefficient]
///
///
extension IntExtension on int {
  int digit({int carry = 10}) {
    int value = abs();
    int d = 0;
    for (var i = 1; i < value; i *= carry, d++) {}
    return d;
  }

  int digitFirst({int carry = 10}) {
    final value = math.pow(carry, digit(carry: carry) - 1).toInt();
    int i = 0;
    for (; value * i < this; i ++) {}
    return i - 1;
  }

  int get accumulate {
    assert(!isNegative && this != 0, 'invalid accumulate integer: $this');
    int accelerator = 1;
    for (var i = 1; i <= this; i++) {
      accelerator += i;
    }
    return accelerator;
  }

  int get factorial {
    assert(!isNegative && this != 0, 'invalid factorial integer: $this');
    int accelerator = 1;
    for (var i = 1; i <= this; i++) {
      accelerator *= i;
    }
    return accelerator;
  }

  Combination combinationIn(int n) => Combination(this, n);

  ///
  /// [1, 3, 6, 10, 15, ...]
  ///
  static List<int> accumulation(int end, {int start = 0}) {
    final list = <int>[];
    for (int i = start; i <= end; i++) {
      list.add(i.accumulate);
    }
    return list;
  }

  ///
  /// [fibonacci] calculate the sequence be like: 1, 1, 2, 3, 5, 8, 13, ...
  /// when [k] == 1, return 1
  /// when [k] == 2, return 1
  /// when [k] == 3, return 2
  /// ...
  ///
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
  /// [pascalTriangle] calculate the 2D array like
  /// 1,
  /// 1, 1
  /// 1, 2, 1
  /// 1, 3, 3, 1
  /// 1, 4, 6, 4, 1
  /// 1, 5, 10, 10, 5, 1
  /// 1, 6, 15, 20, 15, 6, 1 ...,
  /// and this function do
  /// 1. create temporary [Array2D], for example,
  ///   row0: [1, 2, 1, 0, 0, 0]
  ///   row1: [1, 3, 3, 1, 0, 0]
  ///   row2: [1, 4, 0, 4, 1, 0]
  ///   row3: [1, 5, 0, 0, 5, 1] ...
  /// 2. replace 'middle 0' with the correct value. for example,
  ///   row0: [1, 2, 1, 0, 0, 0]
  ///   row1: [1, 3, 3, 1, 0, 0]
  ///   row2: [1, 4, 6, 4, 1, 0]
  ///   row3: [1, 5, 10, 10, 5, 1] ...
  /// 3. return [Array2D]
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
  static List<List<int>> pascalTriangle(
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

    final array = ListExtension.generate2D<int>(
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
  /// the "row" concept in [binomialCoefficient] are similar to [pascalTriangle],
  /// but this function calculate values in more efficient way, only calculate only necessary values in "row"s.
  /// in this function, the row( 2 ) means [1, 2, 1], row( 3 ) means [1, 3, 3, 1]
  ///
  /// when ([n] = 10, [k] = 9), take 8, 9, 10 rows for example,
  ///   row( 8 ) = [... 28,    8,    1]
  ///   row( 9 ) = [...  ?,   36,    9]
  ///   row( 10 ) = [...  ?,    ?,   45]
  /// Because '45' comes from '36+9', '36' comes from '18+8', '9' comes from '8+1',
  /// it's redundant to calculate '?', which are unnecessary values. Let "floor" indicates essential values in a "row",
  /// solution for (n = 10, k = 9) in this function only calculate for values below:
  ///   floor( 2 ) = [1, 2, 1]
  ///   floor( 3 ) = [3, 3, 1]
  ///   floor( 4 ) = [6,  4,  1]
  ///   floor( 5 ) = [10,  5,  1]
  ///   floor( 6 ) = [15,  6,  1]
  ///   floor( 7 ) = [21,  7,  1]
  ///   floor( 8 ) = [28,  8,  1]
  ///   floor( 9 ) = [36,  9]
  ///   floor( 10 ) = [45]
  /// see the comment above [_binomialCoefficient] for implementation detail.
  ///
  static int binomialCoefficient(int n, int k) {
    assert(n > 0 && k > 0 && k <= n + 1, throw ArgumentError('($n, $k)'));
    return k == 1 || k == n + 1
        ? 1
        : k == 2 || k == n
            ? n
            : _binomialCoefficient(n, k);
  }

  ///
  /// the description below are variables used in [_binomialCoefficient], describes how it works
  /// [fEnd] --- the last floor that corresponding row([fEnd])[k] is 1.
  ///   take the sample above ([n] == 10, [k] == 9) for example,
  ///     floor(10) = [45],
  ///     floor(9) = [36,  9],
  ///     floor(8) = [28,  8,  1]
  ///     floor(8) is the last floor that row(8)[9] == 1,
  ///     [fEnd] == 8 #.
  ///   if takes more example, it turns out that [fEnd] = k - 1 #
  ///
  /// [fBegin] --- the first floor that "floor.length" == floor([fEnd]).length,
  ///   take the sample above ([n] = 10, [k] = 9) for example,
  ///     floor([fEnd]) == floor(8)
  ///     3 == floor(8).length == floor(7).length == floor(6).length == ... == floor(2).length
  ///     floor(2) is the first floor that floor.length == floor(8).length
  ///     [fBegin] = 2 #
  ///   if takes more example, it will turn out that [fBegin] = n - [fEnd] #
  ///
  static int _binomialCoefficient(int n, int k) {
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
}

///
/// static methods:
/// [fill], [generateFrom]
///
/// instance methods
/// [hasElement]
/// [notContains]
/// [search]
/// [iteratingWith]
/// [everyCompare], [everyIsEqual], [anyNotEqual]
/// [foldWithIndex], [foldWith]
/// [reduceWithIndex], [reduceWith], [reduceTo], [reduceToNum], [reduceTogether]
/// [expandWithIndex], [expandWith], [flat], [mapToList]
/// [chunk]
///
///
extension IterableExtension<I> on Iterable<I> {
  static Iterable<I> generateFrom<I>(
    int count, [
    Generator<I>? generator,
    int start = 1,
  ]) {
    if (generator == null && I != int) throw UnimplementedError();
    return Iterable.generate(
      count,
      generator == null ? (i) => start + i as I : (i) => generator(start + i),
    );
  }

  static Iterable<I> fill<I>(int count, I value) =>
      Iterable.generate(count, FGenerator.fill(value));

  bool get hasElement => !isEmpty;

  bool notContains(I element) => !contains(element);

  I? search(I value) {
    try {
      return firstWhere((element) => element == value);
    } catch (_) {
      return null;
    }
  }

  void iteratingWith<S>(Iterable<S> another, Absorber<I, S> absorber) {
    assert(length == another.length, 'length must be equal');
    final iterator = this.iterator;
    final iteratorAnother = another.iterator;
    while (iterator.moveNext() && iteratorAnother.moveNext()) {
      absorber(iterator.current, iteratorAnother.current);
    }
  }

  bool everyCompare(
    Iterable<I> another,
    Comparator<I> comparator, {
    int expect = 0,
  }) {
    assert(length == another.length);
    final i1 = iterator;
    final i2 = another.iterator;
    while (i1.moveNext() && i2.moveNext()) {
      if (comparator(i1.current, i2.current) != expect) {
        return false;
      }
    }
    return true;
  }

  bool everyIsEqual(Iterable<I> another) => everyCompare(
        another,
        (v1, v2) => v1 == v2 ? 0 : -1,
        expect: 0,
      );

  bool anyNotEqual(Iterable<I> another) => !everyIsEqual(another);

  ///
  /// fold
  ///
  S foldWithIndex<S>(
    S initialValue,
    GeneratorFolder<S, I, S> folder, {
    int start = 0,
  }) {
    int index = start - 1;
    return fold(
      initialValue,
      (value, element) => folder(++index, value, element),
    );
  }

  S foldWith<S, P>(
    Iterable<P> another,
    S initialValue,
    Fusionor<S, I, P, S> fusionor,
  ) {
    var value = initialValue;
    iteratingWith(
      another,
      (e, eAnother) => value = fusionor(value, e, eAnother),
    );
    return value;
  }

  ///
  /// reduce
  ///
  I reduceWithIndex(
    GeneratorReducer<I> reducing, {
    int start = 0,
  }) {
    int index = start - 1;
    return reduce((value, element) => reducing(++index, value, element));
  }

  I reduceWith<S>(
    Iterable<S> another,
    Fusionor<S, I, I, I> fusionor, {
    int start = 0,
  }) {
    assert(isNotEmpty && another.isNotEmpty);
    final iterator = another.iterator;
    return reduce((v1, v2) {
      iterator.moveNext();
      return fusionor(iterator.current, v1, v2);
    });
  }

  S reduceTo<S>(
    Reducer<S> reducer,
    Translator<I, S> translator,
  ) {
    assert(isNotEmpty);
    final iterator = this.iterator..moveNext();
    S val = translator(iterator.current);
    while (iterator.moveNext()) {
      val = reducer(val, translator(iterator.current));
    }
    return val;
  }

  N reduceToNum<N extends num>(
    Translator<I, N> translator, {
    Reducer<N>? reducer,
  }) =>
      reduceTo(reducer ?? math.max<N>, translator);

  S reduceTogether<S>(
    Iterable<S> another,
    Fusionor<S, S, S, S> reducer,
    Translator<I, S> translator,
  ) {
    assert(another.isNotEmpty);
    final iterator = another.iterator;
    return reduceTo(
      (v1, v2) {
        iterator.moveNext();
        return reducer(iterator.current, v1, v2);
      },
      translator,
    );
  }

  ///
  /// expand
  ///
  Iterable<S> expandWithIndex<S>(Mixer<I, int, Iterable<S>> mix) {
    int index = 0;
    return expand((element) => mix(element, index++));
  }

  Iterable<S> expandWith<S, Q>(List<Q> another, Mixer<I, Q, Iterable<S>> mix) {
    int index = 0;
    return expand((element) => mix(element, another[index++]));
  }

  Iterable<S> flat<S>() => fold<List<S>>(
        [],
        (list, element) => switch (element) {
          S() => list..add(element),
          Iterable<S>() => list..addAll(element),
          Iterable<Iterable<dynamic>>() => list..addAll(element.flat()),
          _ => throw UnimplementedError('$element is not iterable or $S'),
        },
      );

  List<T> mapToList<T>(
    Translator<I, T> translator, {
    bool growable = false,
  }) =>
      map(translator).toList(growable: growable);

  ///
  /// list = [2, 3, 4, 6, 10, 3, 9];
  /// list.chunk([2, 1, 3, 1]); // [[2, 3], [4], [6, 10, 3], [9]]
  ///
  List<List<I>> chunk(Iterable<int> lengthOfEachChunk) {
    assert(lengthOfEachChunk.reduce((a, b) => a + b) == length);
    final list = toList(growable: false);
    final splitList = <List<I>>[];

    int start = 0;
    int end;
    for (var i in lengthOfEachChunk) {
      end = i + start;
      splitList.add(list.sublist(start, end));
      start = end;
    }
    return splitList;
  }
}

extension IterableIntExtension on Iterable<num> {
  num get summary => reduce((value, element) => value + element);
}

extension IterableOffsetExtension on Iterable<Offset> {
  Iterable<Offset> scaling(double value) => map((o) => o * value);

  Iterable<Offset> adjustCenterFor(
    Size size, {
    Offset origin = Offset.zero,
  }) {
    final center = size.center(origin);
    return map((p) => p + center);
  }

  static Mapper<Iterable<Offset>> scalingMapper(double scale) =>
      scale == 1 ? FMapper.ofOffsetIterable : (points) => points.scaling(scale);

  static Iterable<Offset> adjustCenterCompanion(
    Iterable<Offset> points,
    Size size,
  ) =>
      points.adjustCenterFor(size);
}

extension IterableTimerExtension on Iterable<Timer> {
  void cancelAll() {
    for (var t in this) {
      t.cancel();
    }
  }
}

///
/// [lengths]
/// [toStringPadLeft], [mapToStringJoin]
/// [everyLengthIsEqual], [isSizeEqual]
/// [foldWith2D]
///
extension IterableIterableExtension<I> on Iterable<Iterable<I>> {
  int get lengths => fold(0, (value, element) => value + element.length);

  String toStringPadLeft(int space) => mapToStringJoin(
        (row) => row.map((e) => e.toString().padLeft(space)).toString(),
      );

  String mapToStringJoin([
    Translator<Iterable<I>, String>? mapper,
    String separator = "\n",
  ]) =>
      map(mapper ?? (e) => e.toString()).join(separator);

  bool everyLengthIsEqual<S>(Iterable<Iterable<S>> another) {
    assert(length == another.length, 'length must be equal');
    final i1 = iterator;
    final i2 = another.iterator;
    while (i1.moveNext() && i2.moveNext()) {
      if (i1.current.length != i2.current.length) return false;
    }
    return true;
  }

  bool isSizeEqual(Iterable<Iterable<I>> another) =>
      length == another.length &&
      everyCompare(
        another,
        (v1, v2) => v1.length == v2.length ? 0 : -1,
        expect: 0,
      );

  S foldWith2D<S, P>(
    Iterable<Iterable<P>> another,
    S initialValue,
    Fusionor<S, I, P, S> fusionor,
  ) {
    assert(everyLengthIsEqual(another));
    var value = initialValue;
    iteratingWith(
      another,
      (e, eAnother) => value = e.foldWith(eAnother, value, fusionor),
    );
    return value;
  }
}

extension IterableSetExtension<I> on Iterable<Set<I>> {
  Set<I> mergeAll() => reduce((a, b) => a..addAll(b));
}

///
///
/// static methods:
/// [generateFrom]
/// [generate2D], [generate2DSquare]
/// [fill2D], [fill2DSquare]
/// [linking]
///
/// instance methods:
/// [swap]
/// [add2], [addIfNotNull]
/// [addFirstAndRemoveFirst], [addFirstAndRemoveFirstAndGet]
/// [getOrDefault],
/// [update], [updateWithMapper]
/// [updateAll], [updateAllWithMapper]
/// [removeFirst], [removeWhereAndGet]
///
/// [rearrangeAs]
/// [intersectionWith]
/// [differenceWith], [differenceIndexWith]
/// [combine]
///
///
extension ListExtension<T> on List<T> {
  ///
  /// static methods
  ///
  static List<T> generateFrom<T>(
    int length, {
    int start = 1,
    bool growable = true,
    required Generator<T> generator,
  }) =>
      List.generate(
        length,
        (index) => generator(index + start),
        growable: growable,
      );

  static List<List<T>> generate2D<T>(
    int rowCount,
    int columnCount,
    Generator2D<T> generator,
  ) =>
      List.generate(
        rowCount,
        (i) => List.generate(columnCount, (j) => generator(i, j)),
      );

  static List<List<T>> generate2DSquare<T>(int d, Generator2D<T> generator) =>
      generate2D(d, d, generator);

  static List<List<T>> fill2D<T>(int rowCount, int columnCount, T value) =>
      generate2D(rowCount, columnCount, (i, j) => value);

  static List<List<T>> fill2DSquare<T>(int size, T value) =>
      fill2D(size, size, value);

  static List<R> linking<R, S, I>({
    required int totalStep,
    required Generator<S> step,
    required Generator<I> interval,
    required Sequencer<R, S, I> sequencer,
  }) {
    final steps = List.generate(totalStep, step);
    final lengthIntervals = totalStep - 1;
    final intervals = List.generate(lengthIntervals, interval);

    final result = <R>[];

    S previous = steps.first;
    for (var i = 0; i < lengthIntervals; i++) {
      final next = steps[i + 1];
      result.add(sequencer(previous, next, intervals[i])(i));
      previous = next;
    }
    return result;
  }

  ///
  ///
  ///
  /// instance methods
  ///
  ///
  ///

  void swap(int indexA, int indexB) {
    final temp = this[indexA];
    this[indexA] = this[indexB];
    this[indexB] = temp;
  }

  void add2(T e1, T e2) => this
    ..add(e1)
    ..add(e2);

  void addIfNotNull(T? element) => element == null ? null : add(element);

  void addFirstAndRemoveFirst() => this
    ..add(first)
    ..removeFirst();

  T addFirstAndRemoveFirstAndGet() => (this
        ..add(first)
        ..removeFirst())
      .last;

  T getOrDefault(int position, T defaultValue) =>
      position < length ? this[position] : defaultValue;

  void update(int index, T value) => this[index] = value;

  void updateWithMapper(int index, Mapper<T> mapper) =>
      this[index] = mapper(this[index]);

  void updateAll(T value) {
    final length = this.length;
    for (var i = 0; i < length; i++) {
      this[i] = value;
    }
  }

  void updateAllWithMapper(Mapper<T> mapper) {
    final length = this.length;
    for (var i = 0; i < length; i++) {
      this[i] = mapper(this[i]);
    }
  }

  T removeFirst() => removeAt(0);

  Iterable<T> removeWhereAndGet(Predicator<T> predicator) {
    final length = this.length;
    final list = <T>[];
    for (var i = 0; i < length; i++) {
      if (predicator(this[i])) {
        list.add(removeAt(i));
      }
    }
    return list;
  }

  ///
  ///
  /// overall operations
  /// [rearrangeAs]
  /// [split], [splitTwo]
  ///

  ///
  /// list = [2, 3, 4, 6];
  /// list.rearrangeAs([2, 1, 0, 3]); // [4, 3, 2, 6]
  ///
  List<T> rearrangeAs(Set<int> newIndex) {
    final length = this.length;
    assert(newIndex.every((element) => element < length && element > -1));

    final list = <T>[];
    for (var index = 0; index < length; index++) {
      list.add(this[newIndex.firstWhere((i) => i == index)]);
    }
    return list;
  }

  ///
  /// list = [2, 3, 4, 6, 10, 3, 9];
  /// list.split(2); // [[2, 3], [4, 6], [10, 3], [9]]
  ///
  List<List<T>> split(int count, [int? end]) {
    final length = end ?? this.length;
    assert(count <= length);

    final list = <List<T>>[];
    for (var i = 0; i < length; i += count) {
      list.add(sublist(i, i + count < length ? i + count : length));
    }
    return list;
  }

  ///
  /// list = [2, 3, 4, 6, 10, 3, 9];
  /// list.splitTwo(2); // [[2, 3], [4, 6, 10, 3, 9]]
  ///
  (List<T>, List<T>) splitTwo(int position, [int? end]) {
    final length = this.length;
    assert(position <= length);

    return (sublist(0, position), sublist(position, end ?? length));
  }

  ///
  ///
  /// set operations, see also [Set.intersection], [Set.difference],
  ///
  /// [intersectionWith]
  /// [differenceWith], [differenceIndexWith]
  ///
  Map<int, T> intersectionWith(List<T> others) {
    final maxLength = math.min(length, others.length);
    final intersection = <int, T>{};

    for (var index = 0; index < maxLength; index++) {
      final current = this[index];
      if (current == others[index]) {
        intersection.putIfAbsent(index, () => current);
      }
    }

    return intersection;
  }

  Map<int, T> differenceWith(List<T> others) =>
      differenceIndexWith(others).fold(
        <int, T>{},
        (difference, i) => difference..putIfAbsent(i, () => this[i]),
      );

  List<int> differenceIndexWith(List<T> others) {
    final difference = <int>[];
    void put(int index) => difference.add(index);

    final differentiationLength = math.min(length, others.length);
    for (var index = 0; index < differentiationLength; index++) {
      final current = this[index];
      if (current != others[index]) put(index);
    }

    if (length > others.length) {
      for (var index = others.length; index < length; index++) {
        put(index);
      }
    }

    return difference;
  }

  Iterable<MapEntry<T, V>> combine<V>(
    List<V> values, {
    bool joinInValuesLength = true,
  }) sync* {
    final length = joinInValuesLength ? values.length : this.length;
    for (var i = 0; i < length; i++) {
      yield MapEntry(this[i], values[i]);
    }
  }
}

extension ListOffsetExtension on List<Offset> {
  List<Offset> symmetryInsert(
    double dPerpendicular,
    double dParallel,
  ) {
    final length = this.length;
    assert(length % 2 == 0);
    final insertionIndex = length ~/ 2;

    final begin = this[insertionIndex - 1];
    final end = this[insertionIndex];

    final unitParallel = OffsetExtension.parallelUnitOf(begin, end);
    final point =
        begin.middleWith(end) + unitParallel.toPerpendicular * dPerpendicular;

    return this
      ..insertAll(insertionIndex, [
        point - unitParallel * dParallel,
        point + unitParallel * dParallel,
      ]);
  }
}

extension ListListExtension<T> on List<List<T>> {
  int get lengthFirst => first.length;

  bool get isArray2D {
    final columnCount = this.lengthFirst;
    return every((element) => element.length == columnCount);
  }
}

extension ListSetExtension<I> on List<Set<I>> {
  void forEachAddAll(List<Set<I>>? another) {
    if (another != null) {
      for (var i = 0; i < length; i++) {
        this[i].addAll(another[i]);
      }
    }
  }

  void mergeAndRemoveThat(int i, int j) {
    this[i].addAll(this[j]);
    removeAt(j);
  }

  void mergeAndRemoveThis(int i, int j) {
    this[j].addAll(this[i]);
    removeAt(i);
  }

  void mergeWhereAndRemoveAllAndAdd(Predicator<Set<I>> predicator) =>
      add(removeWhereAndGet(predicator).mergeAll());
}

///
///
///
///
///
/// map entry, map
///
///
///
///
///
///

extension MapEntryExtension<K, V> on MapEntry<K, V> {
  MapEntry<V, K> get reversed => MapEntry(value, key);

  String join([String separator = '']) => '$key$separator$value';
}

extension MapEntryIterableExtension<K, V> on Iterable<MapEntry<K, V>> {
  Map<K, V> get toMap => Map.fromEntries(this);
}

///
///
/// [notContainsKey]
/// [containsKeys]
/// [updateAll]
/// [join]
/// [fold], [foldWithIndex], [foldKeys], [foldValues]
/// [reduceKeys], [reduceValues], [reduceTo], [reduceToNum]
///
///
extension MapExtension<K, V> on Map<K, V> {
  bool notContainsKey(K key) => !containsKey(key);

  bool containsKeys(Iterable<K> keys) {
    for (var key in keys) {
      if (notContainsKey(key)) {
        return false;
      }
    }
    return true;
  }

  void updateAll(Iterable<K>? keys, Mapper<V> value) {
    if (keys != null) {
      for (var k in keys) {
        update(k, value);
      }
    }
  }

  String join([String entrySeparator = '', String separator = '']) =>
      entries.map((entry) => entry.join(entrySeparator)).join(separator);

  T fold<T>(
    T initialValue,
    Companion<T, MapEntry<K, V>> foldMap,
  ) =>
      entries.fold<T>(
        initialValue,
        (previousValue, element) => foldMap(previousValue, element),
      );

  T foldWithIndex<T>(
    T initialValue,
    Fusionor<T, MapEntry<K, V>, int, T> fusionor,
  ) {
    int index = -1;
    return entries.fold<T>(
      initialValue,
      (previousValue, element) => fusionor(previousValue, element, ++index),
    );
  }

  S foldKeys<S>(S initialValue, Companion<S, K> companion) =>
      keys.fold(initialValue, companion);

  S foldValues<S>(S initialValue, Companion<S, V> companion) =>
      values.fold(initialValue, companion);

  K reduceKeys(Reducer<K> reducing) => keys.reduce(reducing);

  V reduceValues(Reducer<V> reducing) => values.reduce(reducing);

  S reduceTo<S>(Translator<MapEntry<K, V>, S> translator, Reducer<S> reducer) =>
      entries.reduceTo(reducer, translator);

  N reduceToNum<N extends num>(
    Translator<MapEntry<K, V>, N> translator, {
    Reducer<N>? reducer,
  }) =>
      entries.reduceToNum(translator, reducer: reducer);
}
