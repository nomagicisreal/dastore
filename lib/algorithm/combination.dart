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

  int get p => IntExtension.partition(m, n);

  List<List<int>> get pGroups => IntExtension.partitionGroups(m, n)
    ..sort(FComparatorList.accordinglyUntil(n - 1));

  @override
  String toString() => 'Combination(\n'
      '($m, $n), c: $c\n'
      'p: $p------${pGroups.fold('', (a, b) => '$a \n $b')}\n'
      ')';
}
