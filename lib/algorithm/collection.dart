///
///
/// this file contains:
///
/// [NumExtension], [DoubleExtension], [IntExtension]
///
///
/// [IterableExtension]
/// [IterableIntExtension], [IterableDoubleExtension], [IterableOffsetExtension], [IterableTimerExtension]
/// [IterableIterableExtension], [IterableSetExtension]
///
///
/// [ListExtension]
/// [ListOffsetExtension], [ListComparableExtension]
/// [ListListExtension], [ListListComparableExtension], [ListSetExtension]
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

  double get clampPositive => clampDouble(this, 0.0, double.infinity);

  double get clampNegative => clampDouble(this, double.negativeInfinity, 0);

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
/// [isPositive]
/// [accumulate], [factorial]
/// [digit], [digitFirst]
///
/// static methods:
/// [accumulation]
/// [fibonacci]
/// [pascalTriangle]
/// [binomialCoefficient]
/// [partition], [partitionOf], [partitionGroups]
///
///
extension IntExtension on int {
  bool get isPositiveOrZero => !isNegative;

  bool get isPositive => !isNegative && this != 0;

  int get accumulate {
    assert(isPositiveOrZero, 'invalid accumulate integer: $this');
    int accelerator = 0;
    for (var i = 1; i <= this; i++) {
      accelerator += i;
    }
    return accelerator;
  }

  int get factorial {
    assert(isPositive, 'invalid factorial integer: $this');
    int accelerator = 1;
    for (var i = 1; i <= this; i++) {
      accelerator *= i;
    }
    return accelerator;
  }

  int digit({int carry = 10}) {
    int value = abs();
    int d = 0;
    for (var i = 1; i < value; i *= carry, d++) {}
    return d;
  }

  int digitFirst({int carry = 10}) {
    final value = math.pow(carry, digit(carry: carry) - 1).toInt();
    int i = 0;
    for (; value * i < this; i++) {}
    return i - 1;
  }

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
  ///
  /// [binomialCoefficient], [_binomialCoefficient]
  ///
  ///

  ///
  /// [binomialCoefficient]

  ///
  /// see the comment above [_binomialCoefficient] for implementation detail
  ///
  static int binomialCoefficient(int n, int k) {
    assert(
      n > 0 && k > 0 && k <= n + 1,
      throw ArgumentError('binomial coefficient for ($n, $k)'),
    );
    return k == 1 || k == n + 1
        ? 1
        : k == 2 || k == n
            ? n
            : _binomialCoefficient(n, k);
  }

  ///
  /// Let "row( [n] )" be list of binomial coefficient, for example:
  ///   row( 2 ) = [1, 2, 1]
  ///   row( 3 ) = [1, 3, 3, 1]
  ///
  /// Let "floor" represents all the essential values in a "row", for example, when ([n] = 10, [k] = 9),
  ///   row( 8 ) = [... 28,    8,    1]
  ///   row( 9 ) = [...  ?,   36,    9]
  ///   row( 10 ) = [...  ?,    ?,   45]
  /// Because '45' comes from '36+9', '36' comes from '18+8', '9' comes from '8+1',
  /// it's redundant to calculate '?', which are unnecessary values. solution for it required the values below:
  ///   floor( 2 ) = [1, 2, 1]
  ///   floor( 3 ) = [3, 3, 1]
  ///   floor( 4 ) = [6,  4,  1]
  ///   floor( 5 ) = [10,  5,  1]
  ///   floor( 6 ) = [15,  6,  1]
  ///   floor( 7 ) = [21,  7,  1]
  ///   floor( 8 ) = [28,  8,  1]
  ///   floor( 9 ) = [36,  9]
  ///   floor( 10 ) = [45]
  ///
  /// the description below are variables used in this function, describes how it works
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

  ///
  /// Generally, these methods return the possible partition of an integer [m],
  /// [partition]
  /// [partitionOf]
  /// [partitionGroups]
  ///
  /// and these private methods are the implementation of those methods
  /// [_partition]
  /// [_partitionSpace]
  /// [_partitionElementGenerator]
  /// [_partitionSearchOnFloor]
  ///
  /// see the comment under [partitionGroups], above [_partition] to understand the implement logic
  /// see also https://en.wikipedia.org/wiki/Partition_(number_theory) for academic definition
  ///

  ///
  /// [partition] return the possible partition in [n] group for an integer [m],
  /// and each group must not be empty.
  ///
  /// for example, when [m] = 7, [n] = 4, this function returns 3 because there are 3 possible partition:
  /// [4, 1, 1, 1]
  /// [3, 2, 1, 1]
  /// [2, 2, 2, 1]
  ///
  static int partition(int m, int n) {
    assert(
      m.isPositiveOrZero && n <= m,
      'it is impossible to partition $m into $n group',
    );
    return _partition(m, n, space: _partitionSpace<int>(m, n: n));
  }

  ///
  /// [partitionOf] return the possible partitions for an integer [m],
  /// and each group must not be empty.
  ///
  /// for example, when [m] = 5, this function return 7 because there are 7 possible partition for 5:
  /// (5)
  /// (4, 1)
  /// (3, 2)
  /// (3, 1, 1)
  /// (2, 2, 1)
  /// (2, 1, 1, 1)
  /// (1, 1, 1, 1, 1)
  ///
  static int partitionOf(int m) {
    assert(m.isPositiveOrZero, 'it is impossible to partition $m');
    final pSpace = _partitionSpace<int>(m);
    return Iterable.generate(
      m,
      (i) => _partition<int>(m, i + 1, space: pSpace),
    ).reduce((p1, p2) => p1 + p2);
  }

  ///
  /// [partitionGroups] return entire groups of possible partition,
  /// and each group must not be empty.
  ///
  /// for example, when [m] = 8, [n] = 4, this function returns [
  ///   [5, 1, 1, 1],
  ///   [4, 2, 1, 1],
  ///   [3, 3, 1, 1],
  ///   [3, 2, 2, 1],
  ///   [2, 2, 2, 2],
  /// ]
  ///
  static List<List<int>> partitionGroups(int m, int n) {
    assert(
      m.isPositiveOrZero && n <= m,
      'it is impossible to partition $m into $n group',
    );
    final groups = _partition(
      m,
      n,
      space: _partitionSpace<List<List<int>>>(m, n: n),
    );
    assert(groups.every((element) => element.length == n), 'runtime error');
    return groups;
  }

  ///
  /// The "row" concept in here helps to calculate values in more efficient way. definition:
  ///   row( 2 ) = [1, 1, 1]
  ///   row( 3 ) = [1, 1, 1, 1]
  /// because there is only 1 way to partition integer 2 into 0 group, 1 group or 2 group,
  /// and there is also only 1 way to partition integer 3 into 0 group, 1 group, 2 group, 3 group.
  /// based on "row" concept, the return value or the answer is equivalent to row([m])([n]).
  ///
  /// To find out the answer, we have to repeat a step:
  /// calculating row( i )( j ) by summarizing row( i-j )( 1 ) to row( i-j )( min(i-j, j) ),
  /// and in the first step, i = [m], j = [n].
  ///   - Take i = 10, j = 7 for example,
  ///     it means that there are 10 same elements have to be partitioned into 7 group.
  ///     Because each group must have 1 element at least,
  ///     we have to consider how many possible partition in 7 group actually for 3 (i-j) element.
  ///     That is, it's possible that 3 elements partitioned into 1 group, 2 group, 3 group. (1 to i-j),
  ///     so the summarize of row(3)(1) to row(3)(3) is the answer.
  ///
  ///   - Take i = 20, j = 7 for example,
  ///     it means that there are 20 same elements have to be partitioned into 7 group.
  ///     Because we have to consider how many possible partition in 7 group actually for 13 (i-j) element.
  ///     it's possible that 13 elements partitioned into 1 group, 2 group, ... 7 group. (1 to j)
  ///
  /// Let "floor" correspond to "row" and contains all the essential values of corresponding row.
  /// Let "target floor" represents "floor( [m]-[n] )". In convenient of discussion,
  /// all the index blow starts by 1, because [n] = 0 not in the consideration of this function.
  ///
  /// Take ([m] = 10, [n] = 4) for example, the description below shows how to use the "floors",
  ///   row(10)(4) = floor(6)(1) + ... + floor(6)(4)
  ///     floor(6)(1) = 1
  ///     floor(6)(2) = floor(4)(1) + ... + floor(4)(2)
  ///     floor(6)(3) = floor(3)(1) + ... + floor(3)(3)
  ///     floor(6)(4) = floor(2)(1) + ... + floor(2)(2)
  ///       floor(4)(1) + floor(4)(2) = floor(4)(1) + floor(2)(1) + floor(2)(2) = 1 + 1 + 1 = 3
  ///       floor(3)(1) + floor(3)(2) + floor(3)(3) = 1 + 1 + 1 = 3
  ///       floor(2)(1) + floor(2)(2) = 1 + 1 = 2
  ///   row(10)(4) = floor(6)(1) + ... + floor(6)(5) = 1 + 3 + 3 + 2 = 9 #
  /// during the calculation, the required floors are:
  ///   floor( 2 ) = [1, 1]
  ///   floor( 3 ) = [1, 1, 1]
  ///   floor( 4 ) = [1, 2]
  ///   floor( 6 ) = [1, 3, 3, 2] (this floor is target floor)
  /// with those "floor", we can get the answer of ([m] = 10, [n] = 4).
  ///
  /// [_partition] implementation is based on the discussion above
  /// [_partitionSpace] for [space] helps to prevent invoking [elementOf] in [_partition] redundantly.
  /// [_partitionElementGenerator] is the generator to find row element
  /// [_partitionSearchOnFloor] is a way to find out where a row element comes from
  ///
  ///

  ///
  ///
  static P _partition<P>(
    int m,
    int n, {
    required List<List<P>> space,
  }) =>
      switch (space) {
        List<List<int>>() => () {
            final partitionSpace = space as List<List<int>>;
            late final Reducer<int> elementOf;

            int instancesOf(int i, int j) {
              int sum = 1;
              _partitionSearchOnFloor<int>(
                i,
                j,
                space: partitionSpace,
                elementOf: elementOf,
                predicate: (p) => p == 1,
                consume: (p) => sum += p,
                trailing: (_) => sum++,
              );
              return sum;
            }

            elementOf = _partitionElementGenerator(
              atFirst: FGenerator.fill2D(1),
              atLast: FGenerator.fill2D(1),
              atLastPrevious: FGenerator.fill2D(1),
              instancesOf: instancesOf,
            );

            return elementOf(m, n);
          }(),
        List<List<Iterable<List<int>>>>() => () {
            final partitionSpace = space as List<List<Iterable<List<int>>>>;
            late final Generator2D<Iterable<List<int>>> elementOf;

            print('($m, $n)');

            List<int> firstOf(int n) => [n];
            List<int> lastOf(int n) => List.filled(n, 1, growable: true);
            List<int> lastPreviousOf(int n) => [2, ...List.filled(n - 2, 1)];

            Iterable<List<int>> instancesOf(int i, int j) {
              final instances = [firstOf(i)];
              _partitionSearchOnFloor<Iterable<List<int>>>(
                i,
                j,
                space: partitionSpace,
                elementOf: elementOf,
                predicate: (p) => p.isEmpty,
                consume: (p) => instances.addAll(p),
                trailing: (current) => instances.add(
                  (current == i ? lastOf(i) : lastPreviousOf(i)),
                ),
              );
              return instances;
            }

            elementOf = _partitionElementGenerator(
              atFirst: (i, j) => [firstOf(i)],
              atLast: (i, j) => [lastOf(j)],
              atLastPrevious: (i, j) => [lastPreviousOf(j)],
              instancesOf: (i, j) {
                final instances = instancesOf(i, j);
                final result = <List<int>>[];
                for (var instance in instances) {
                  result.add([
                    ...instance.map((element) => element + 1),
                    ...Iterable.generate(j - instance.length, (_) => 1),
                  ]);
                }
                return result;
              },
            );

            return elementOf(m, n);
          }(),
        _ => throw UnimplementedError(),
      } as P;

  ///
  /// [_partitionSpace] specify how much space a [_partition] needs.
  /// with predicator, it can prevent calculation for the same value in [_partitionSearchOnFloor].
  /// the values inside [List]<[List]<[P]>> will update during the loop if:
  ///   [P] == [int] && element is 1
  ///   [P] == [int] && element is empty
  ///
  /// the return space row must start from row(4) to row(i), correspond to list[0] to list[i-4]
  /// the return space column must start from row(i)(2) to row(i)(j), correspond to list[i][0] to list[i][j-2]
  ///
  /// instead of [List.filled], using [List.generate] prevents shared instance for list
  ///
  static List<List<P>> _partitionSpace<P>(int m, {int? n}) {
    final spaceRow = math.max(0, m - 3 - (n ?? 0));
    final Generator<P> generator = P == int
        ? (_) => 1 as P
        : (P == List<List<int>>)
            ? (_) => <List<int>>[] as P
            : throw UnimplementedError(
                'generic type must be int or Iterable<List<int>>, current: $P',
              );
    return List.generate(
      spaceRow,
      n == null
          ? (f) => List.generate(math.min(f + 1, spaceRow - f), generator)
          : (f) => List.generate(math.min(f + 1, n), generator),
    );
  }

  ///
  ///
  static Generator2D<T> _partitionElementGenerator<T>({
    required Generator2D<T> atFirst,
    required Generator2D<T> atLast,
    required Generator2D<T> atLastPrevious,
    required Generator2D<T> instancesOf,
  }) =>
      (i, j) {
        if (j == 1) return atFirst(i, j);
        if (j == i) return atLast(i, j);
        if (j == i - 1) return atLastPrevious(i, j);
        return instancesOf(i - j, j);
      };

  ///
  ///
  static void _partitionSearchOnFloor<P>(
    int i,
    int j, {
    required List<List<P>> space,
    required Generator2D<P> elementOf,
    required Predicator<P> predicate,
    required void Function(P instance) consume,
    required void Function(int current) trailing,
  }) {
    final min = math.min(i, j);
    final bound = min == i
        ? math.max(1, min - 2)
        : min == i - 1
            ? min - 1
            : min;
    for (var k = 2; k <= bound; k++) {
      P p = space[i - 4][k - 2];
      if (predicate(p)) p = space[i - 4][k - 2] = elementOf(i, k);
      consume(p);
    }
    for (var current = bound + 1; current <= min; current++) {
      trailing(current);
    }
  }
}

///
/// static methods:
/// [fill], [generateFrom]
///
/// instance getter and methods
/// [notContains]
/// [search]
/// [iteratingAllWith]
///
/// [anyInside], [anyIsEqual], [anyIsDifferent], [anyWithIndex],
/// [anyElementWith], [anyElementIsEqualWith], [anyElementIsDifferentWith]
/// [everyIsEqual], [everyIsDifferent], [everyWithIndex],
/// [everyElementsWith], [everyElementsAreEqualWith], [everyElementsAreDifferentWith]
///
/// [foldWithIndex], [foldWith]
/// [reduceWithIndex], [reduceWith], [reduceTo], [reduceToNum], [reduceToString], [reduceTogether]
/// [expandWithIndex], [expandWith], [flat], [mapToList]
///
/// [chunk]
/// [groupBy]
/// [lengthFlatted]
/// [combine]
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

  bool notContains(I element) => !contains(element);

  I? search(I value) {
    try {
      return firstWhere((element) => element == value);
    } catch (_) {
      return null;
    }
  }

  void iteratingAllWith<S>(Iterable<S> another, Absorber<I, S> absorber) {
    assert(length == another.length, 'length must be equal');
    final iterator = this.iterator;
    final iteratorAnother = another.iterator;
    while (iterator.moveNext() && iteratorAnother.moveNext()) {
      absorber(iterator.current, iteratorAnother.current);
    }
  }

  ///
  /// any
  ///
  bool anyInside(Comparator<I> compare, {int expect = 0}) {
    final iterator = this.iterator..moveNext();
    final List<I> list = [iterator.current];
    while (iterator.moveNext()) {
      final current = iterator.current;
      if (list.any((e) => compare(e, current) == expect)) return true;
      list.add(current);
    }
    return false;
  }

  bool get anyIsEqual => anyInside((a, b) => a == b ? 0 : -1, expect: 0);

  bool get anyIsDifferent => anyInside((a, b) => a != b ? 0 : -1, expect: 0);

  bool anyWithIndex(Checker<I> checker, {int start = 0}) {
    int index = start - 1;
    return any((element) => checker(++index, element));
  }

  bool anyElementWith<P>(
    Iterable<P> another,
    Differentiator<I, P> differentiate, {
    int expect = 0,
  }) {
    assert(length == another.length);
    final i1 = iterator;
    final i2 = another.iterator;
    while (i1.moveNext() && i2.moveNext()) {
      if (differentiate(i1.current, i2.current) == expect) {
        return true;
      }
    }
    return false;
  }

  bool anyElementIsEqualWith(Iterable<I> another) => anyElementWith(
        another,
        (v1, v2) => v1 == v2 ? 0 : -1,
        expect: 0,
      );

  bool anyElementIsDifferentWith(Iterable<I> another) => anyElementWith(
        another,
        (v1, v2) => v1 != v2 ? 0 : -1,
        expect: 0,
      );

  ///
  /// every
  ///
  bool get everyIsEqual => !anyIsDifferent;

  bool get everyIsDifferent => !anyIsEqual;

  bool everyWithIndex(Checker<I> checker, {int start = 0}) {
    int index = start - 1;
    return every((element) => checker(++index, element));
  }

  bool everyElementsWith<P>(
    Iterable<P> another,
    Differentiator<I, P> differentiate, {
    int expect = 0,
  }) {
    assert(length == another.length);
    final i1 = iterator;
    final i2 = another.iterator;
    while (i1.moveNext() && i2.moveNext()) {
      if (differentiate(i1.current, i2.current) != expect) {
        return false;
      }
    }
    return true;
  }

  bool everyElementsAreEqualWith(Iterable<I> another) =>
      !anyElementIsDifferentWith(another);

  bool everyElementsAreDifferentWith(Iterable<I> another) =>
      !anyElementIsEqualWith(another);

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
    iteratingAllWith(
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

  N reduceToNum<N extends num>({
    required Reducer<N> reducer,
    required Translator<I, N> translator,
  }) =>
      reduceTo(reducer, translator);

  String reduceToString([String separator = '\n']) =>
      fold('', (s1, s2) => '$s1$separator$s2');

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

  Map<S, List<I>> groupBy<S>(Translator<I, S> translator) {
    final map = <S, List<I>>{};
    for (var item in this) {
      map.update(
        translator(item),
        (value) => value..add(item),
        ifAbsent: () => [item],
      );
    }
    return map;
  }

  int lengthFlatted<S>() => reduceToNum(
        reducer: (v1, v2) => v1 + v2,
        translator: (element) => switch (element) {
          S() => 1,
          Iterable<S>() => element.length,
          Iterable<Iterable<dynamic>>() => element.lengthFlatted(),
          _ => throw UnimplementedError('unknown type: $element for $S'),
        },
      );

  Iterable<MapEntry<I, V>> combine<V>(Iterable<V> values) =>
      foldWith<List<MapEntry<I, V>>, V>(
        values,
        [],
        (list, key, value) => list..add(MapEntry(key, value)),
      );
}

extension IterableIntExtension on Iterable<int> {
  int get sum => reduce((value, element) => value + element);
}

extension IterableDoubleExtension on Iterable<double> {
  double get sum => reduce((value, element) => value + element);
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
/// [everyElementsLengthAreEqualWith]
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

  bool everyElementsLengthAreEqualWith<P>(Iterable<Iterable<P>> another) =>
      length == another.length &&
      everyElementsWith(
        another,
        (v1, v2) => v1.length == v2.length ? 0 : -1,
        expect: 0,
      );

  S foldWith2D<S, P>(
    Iterable<Iterable<P>> another,
    S initialValue,
    Fusionor<S, I, P, S> fusionor,
  ) {
    assert(everyElementsLengthAreEqualWith(another));
    return foldWith(
      another,
      initialValue,
      (value, e, eAnother) => value = e.foldWith(eAnother, value, fusionor),
    );
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
/// [add2], [addIfNotNull], [addFirstAndRemoveFirst]...
/// [getOrDefault],...
/// [update], [updateWithMapper], ...
/// [removeFirst], [removeWhereAndGet]
/// [fillUntil]
/// [copy], [copyFillUntil], ...
/// [reversedExceptFirst]
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
    int length,
    Generator<T> generator, {
    int start = 1,
    bool growable = true,
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

  void addAllIfEmpty(Supplier<Iterable<T>> supplier) =>
      isEmpty ? addAll(supplier()) : null;

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

  void fillUntil(int length, T value) {
    for (var i = this.length; i < length; i++) {
      add(value);
    }
  }

  ///
  /// copy
  /// [copy]
  /// [copyFillUntil]
  /// [reversedExceptFirst]
  ///
  ///
  List<T> get copy => List.of(this);

  List<T> copyFillUntil(int length, T value) => [
        ...this,
        ...List.filled(length - this.length, value),
      ];

  List<T> get reversedExceptFirst {
    final length = this.length - 1;
    final result = <T>[first];
    for (var i = length; i > 0; i--) {
      result.add(this[i]);
    }
    return result;
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

///
/// [sortMerge]
/// [sortPivot]
///
extension ListComparableExtension<C extends Comparable> on List<C> {
  ///
  /// [sortMerge] aka merge sort:
  ///   1. regarding current list as the mix of 2 elements sublist, sorting for each sublist
  ///   2. regarding current list as the mix of sorted sublists, merging sublists into bigger ones
  ///     (2 elements -> 4 elements -> 8 elements -> ... -> n elements)
  ///
  /// when [isIncreasing] = true,
  /// it's means that when 'list item a' > 'list item b', element a should switch with b.
  /// see [_sortMerge] for full implementation.
  ///
  void sortMerge([bool isIncreasing = true]) {
    final increasing = isIncreasing ? 1 : -1;
    final length = this.length;

    final max = length.isEven ? length : length - 1;
    for (var start = 0; start < max; start += 2) {
      final a = this[start];
      final b = this[start + 1];
      if (a.compareTo(b) == increasing) {
        this[start] = b;
        this[start + 1] = a;
      }
    }
    int sorted = 2;

    while (sorted * 2 <= length) {
      final target = sorted * 2;
      final fixed = length - length % target;
      int start = 0;

      for (; start < fixed; start += target) {
        final i = start + sorted;
        final end = start + target;
        replaceRange(
          start,
          end,
          _sortMerge(sublist(start, i), sublist(i, end), isIncreasing),
        );
      }
      if (fixed > 0) {
        replaceRange(
          0,
          length,
          _sortMerge(sublist(0, fixed), sublist(fixed, length), isIncreasing),
        );
      }
      sorted *= 2;
    }
  }

  ///
  /// before calling [_sortMerge], [listA] and [listB] must be sorted.
  /// when [isIncreasing] = true,
  /// it's means that when 'listA item a' < 'listB item b', result should add a before add b.
  ///
  static List<C> _sortMerge<C extends Comparable>(
    List<C> listA,
    List<C> listB, [
    bool isIncrease = true,
  ]) {
    final increase = isIncrease ? -1 : 1;
    final result = <C>[];
    final lengthA = listA.length;
    final lengthB = listB.length;
    int i = 0;
    int j = 0;
    while (i < lengthA && j < lengthB) {
      final a = listA[i];
      final b = listB[j];
      if (a.compareTo(b) == increase) {
        result.add(a);
        i++;
      } else {
        result.add(b);
        j++;
      }
    }
    return result..addAll(i < lengthA ? listA.sublist(i) : listB.sublist(j));
  }

  ///
  /// [sortPivot] separate list by the pivot item,
  /// continue updating pivot item, sorting elements by comparing to pivot item.
  /// see [_sortPivot] for full implementation
  ///
  void sortPivot([bool isIncreasing = true]) {
    void sorting(int low, int high) {
      if (low < high) {
        final iPivot = _sortPivot(low, high, isIncreasing);
        sorting(low, iPivot - 1);
        sorting(iPivot + 1, high);
      }
    }

    if (length > 1) sorting(0, length - 1);
  }

  ///
  /// [_sortPivot] partition list by the the pivot item list[high], and return new pivot position.
  ///
  /// when [isIncreasing] = true,
  /// it meas that the pivot point should search for how much item that is less than itself,
  /// ensuring the items that less/large than pivot are in front of list,
  /// preparing to switch the larger after the position of 'how much item' that pivot had found less than itself
  ///
  int _sortPivot(int low, int high, [bool isIncreasing = true]) {
    final increasing = isIncreasing ? 1 : -1;
    final pivot = this[high];
    int i = low;
    int j = low;

    for (; j < high; j++) {
      if (pivot.compareTo(this[j]) == increasing) {
        i++;
      } else {
        break;
      }
    }

    for (; j < high; j++) {
      final current = this[j];
      if (pivot.compareTo(current) == increasing) {
        this[j] = this[i];
        this[i] = current;
        i++;
      }
    }

    this[high] = this[i];
    this[i] = pivot;

    return i;
  }
}

extension ListListExtension<T> on List<List<T>> {
  int get lengthFirst => first.length;

  bool get isArray2D {
    final columnCount = this.lengthFirst;
    return every((element) => element.length == columnCount);
  }
}

extension ListListComparableExtension<C extends Comparable> on List<List<C>> {
  void orderByElementFirst([Comparator<C>? comparator]) => sort(
        comparator != null
            ? (a, b) => comparator.call(a.first, b.first)
            : (a, b) => b.first.compareTo(a.first),
      );
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

  N reduceToNum<N extends num>({
    required Reducer<N> reducer,
    required Translator<MapEntry<K, V>, N> translator,
  }) =>
      entries.reduceToNum(reducer: reducer, translator: translator);
}
