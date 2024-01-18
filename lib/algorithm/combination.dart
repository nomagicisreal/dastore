///
///
/// this file contains:
/// [Combination]
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

class Combination {
  final int m;
  final int n;

  const Combination(this.m, this.n) : assert(m >= 0 && n <= m);

  int get c => IntExtension.binomialCoefficient(m, n + 1);

  Iterable<Iterable<int>> get groups {
    final m = this.m;
    final n = this.n;
    assert(n.rangeIn(0, m));
    if (n == m) return [IterableExtension.fill(n, 1)];
    if (n == 1) return [IterableExtension.fill(1, m)];
    if (n == 2) {
      return IterableExtension.generateFrom(m ~/ 2, (i) => [i, m - i]);
    }

    final max = m - n + 1;
    final finalRow = [...IterableExtension.fill(n - 1, 1), max];
    if (n == m - 1) return [finalRow];

    final initialFirst = m ~/ n;
    int addition = m % n;
    final firstRow = <int>[
      ...Iterable.generate(n - addition, (index) => initialFirst),
      ...Iterable.generate(addition, (index) => initialFirst + 1),
    ];

    if (n == m - 2) return [firstRow, finalRow];

    ///
    /// ------------------------7
    /// n = 7, p = 2, q = 3
    /// 3 + 4
    /// 2 + 5
    /// 1 + 6
    ///
    /// n = 7, p = 3, q = 4
    /// 2 + 2 + 3
    /// 1 + 3 + 3
    /// 1 + 2 + 4
    /// 1 + 1 + 5
    ///
    /// n = 7, p = 4, q = 3
    /// 1 + 2 + 2 + 2
    /// 1 + 1 + 2 + 3
    /// 1 + 1 + 1 + 4
    ///
    /// n = 7, p = 5, q = 2
    /// 1 + 1 + 1 + 2 + 2
    /// 1 + 1 + 1 + 1 + 3
    ///
    /// n = 7, p = 6, q = 1
    /// 1 + 1 + 1 + 1 + 1 + 2
    ///
    /// ------------------------8
    /// n = 8, p = 2, q = 4
    /// 4 + 4
    /// 3 + 5
    /// 2 + 6
    /// 1 + 7
    ///
    /// n = 8, p = 3, q = 5
    /// 2 + 3 + 3
    /// 2 + 2 + 4
    /// 1 + 3 + 4
    /// 1 + 2 + 5
    /// 1 + 1 + 6
    ///
    /// n = 8, p = 4, q = 5
    /// 2 + 2 + 2 + 2
    /// 1 + 2 + 2 + 3
    /// 1 + 1 + 3 + 3
    /// 1 + 1 + 2 + 4
    /// 1 + 1 + 1 + 5
    ///
    /// n = 8, p = 5, q = 3
    /// 1 + 1 + 2 + 2 + 2
    /// 1 + 1 + 1 + 2 + 3
    /// 1 + 1 + 1 + 1 + 4
    ///
    ///

    ///
    /// use the logic of value distribution?
    /// n = 8, p = 5, q = 3
    /// 4 + 1 + 1 + 1 + 1
    /// 3 + 2 + 1 + 1 + 1
    /// 2 + 2 + 2 + 1 + 1
    ///
    /// n = 8, p = 2, q = 4
    /// 7 + 1
    /// 6 + 2
    /// 5 + 3
    /// 4 + 4
    ///
    /// 1. distribute remain on first element
    /// 2. distribute remain-1 on first element and distribute 1 to trailing
    ///   the firs element of trailing cannot larger than previous element
    /// 3. distribute remain-2 on first element and distribute 2 to trailing
    /// ...
    /// 4. distribute 0 on first element (do nothing)

    throw UnimplementedError();

    // assert(list.length == m ~/ n);
    // assert(list.every((v) => v.length == n && v.summary == m));
    // return list;
  }

  @override
  String toString() => 'Combination(\n'
      '$m, $n, $c\n'
      '$groups\n'
      ')';
}
