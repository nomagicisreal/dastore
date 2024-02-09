///
///
/// this file contains:
///
/// [Operator]
///
///
/// [Combination]
///
///
///
///
/// [KLaTexString], [KLatexStringEquation], [KLatexStringMatrix1N], [KLatexStringMatrix2N], [FLaTexString]
///
/// [KRadian]
///
/// [VRandom]
///
///
///
///
/// [NullableExtension]
/// [StringExtension], [MatchExtension]
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
// ignore_for_file: constant_identifier_names, non_constant_identifier_names

enum Operator {
  plus,
  minus,
  multiply,
  divide,
  modulus,
  ;

  @override
  String toString() => switch (this) {
    Operator.plus => '+',
    Operator.minus => '-',
    Operator.multiply => '*',
    Operator.divide => '/',
    Operator.modulus => '%',
  };

  String get latex => switch (this) {
    Operator.plus => r'+',
    Operator.minus => r'-',
    Operator.multiply => r'\times',
    Operator.divide => r'\div',
    Operator.modulus => throw UnimplementedError(),
  };

  ///
  /// latex operation
  ///
  String latexOperationOf(String a, String b) => "$a $latex $b";

  String latexOperationOfDouble(double a, double b, {int fix = 0}) =>
      "${a.toStringAsFixed(fix)} "
          "$latex "
          "${b.toStringAsFixed(fix)}";

  ///
  /// operate value
  ///
  double operateDouble(double a, double b) => switch (this) {
    Operator.plus => a + b,
    Operator.minus => a - b,
    Operator.multiply => a * b,
    Operator.divide => a / b,
    Operator.modulus => a % b,
  };

  static double operateDoubleAll(
      double value,
      Iterable<MapEntry<Operator, double>> operations,
      ) =>
      operations.fold(
        value,
            (a, operation) => switch (operation.key) {
          Operator.plus => a + operation.value,
          Operator.minus => a - operation.value,
          Operator.multiply => a * operation.value,
          Operator.divide => a / operation.value,
          Operator.modulus => a % operation.value,
        },
      );

  Duration operateDuration(Duration a, Duration b) => switch (this) {
    Operator.plus => a + b,
    Operator.minus => a - b,
    _ => throw UnimplementedError(),
  };

  DurationFR operateDurationFR(DurationFR a, DurationFR b) => switch (this) {
    Operator.plus =>
        DurationFR(a.forward + b.forward, a.reverse + b.reverse),
    Operator.minus =>
        DurationFR(a.forward - b.forward, a.reverse - b.reverse),
    _ => throw UnimplementedError(),
  };

  T operationOf<T>(T a, T b) => switch (a) {
    double _ => operateDouble(a, b as double),
    Duration _ => operateDuration(a, b as Duration),
    DurationFR _ => operateDurationFR(a, b as DurationFR),
    _ => throw UnimplementedError(),
  } as T;

  ///
  /// mapper
  ///

  double Function(double value) doubleCompanion(double b) => switch (this) {
    Operator.plus => (a) => a + b,
    Operator.minus => (a) => a - b,
    Operator.multiply => (a) => a * b,
    Operator.divide => (a) => a / b,
    Operator.modulus => (a) => a % b,
  };
}


///
///
///
/// [Combination]
///
///
///

//
class Combination {
  final int m;
  final int n;

  const Combination(this.m, this.n) : assert(m >= 0 && n <= m);

  int get c => IntExtension.binomialCoefficient(m, n + 1);

  int get p => IntExtension.partition(m, n);

  List<List<int>> get pGroups =>
      IntExtension.partitionGroups(m, n)..sortAccordingly();

  @override
  String toString() => 'Combination(\n'
      '($m, $n), c: $c\n'
      'p: $p------${pGroups.fold('', (a, b) => '$a \n $b')}\n'
      ')';
}


///
///
///
///
/// latex string
///
///
///
///

extension KLaTexString on String {
  static const quadraticRoots = r"{-b \pm \sqrt{b^2-4ac} \over 2a}";
  static const sn = r"S_n";
  static const x1_ = r"x_1 + x_2 + ... + x_n";
  static const x1_3 = r"x_1 + x_2 + x_3";
  static const x1_4 = r"x_1 + x_2 + x_3 + x_4";
  static const x1_5 = r"x_1 + x_2 + x_3 + x_4 + x_5";
  static const ax1_ = r"a_1x_1 + a_2x_2 + ... + a_nx_n";
  static const ax1_3 = r"a_1x_1 + a_2x_2 + a_3x_3";
  static const ax1_4 = r"a_1x_1 + a_2x_2 + a_3x_3 + a_4x_4";
  static const ax1_5 = r"a_1x_1 + a_2x_2 + a_3x_3 + a_4x_4 + a_5x_5";
}

extension KLatexStringEquation on String {
  static const quadraticRootsOfX = r"x = " + KLaTexString.quadraticRoots;
  static const yLinearABX = r"y = a + bx";
  static const yLinearMXK = r"y = mx + k";
}

extension KLatexStringMatrix1N on String {
  static const y1_ = r"""\begin{bmatrix}
  y_1\\
  y_2\\
  ...\\
  y_n\\
  \end{bmatrix}""";
}

extension KLatexStringMatrix2N on String {
  static const const1_x1_ = r"""\begin{bmatrix}
  1&x_1\\
  1&x_2\\
  ...&...\\
  1&x_n\\
  \end{bmatrix}""";
}

extension FLaTexString on String {
  static String equationOf(Iterable<String> values) => values.reduce(
        (a, b) => "$a = $b",
  );
}

///
/// positive radian means clockwise for [Transform] widget and [Offset.direction],
/// but means counterclockwise for math discussion
/// see also [Direction]
///
extension KRadian on double {
  static const angle_450 = math.pi * 5 / 2;
  static const angle_420 = math.pi * 7 / 3;
  static const angle_390 = math.pi * 13 / 6;
  static const angle_360 = math.pi * 2;
  static const angle_315 = math.pi * 7 / 4;
  static const angle_270 = math.pi * 3 / 2;
  static const angle_240 = math.pi * 4 / 3;
  static const angle_225 = math.pi * 5 / 4;
  static const angle_180 = math.pi;
  static const angle_150 = math.pi * 5 / 6;
  static const angle_135 = math.pi * 3 / 4;
  static const angle_120 = math.pi * 2 / 3;
  static const angle_90 = math.pi / 2;
  static const angle_85 = math.pi * 17 / 36;
  static const angle_80 = math.pi * 4 / 9;
  static const angle_75 = math.pi * 5 / 12;
  static const angle_70 = math.pi * 7 / 18;
  static const angle_60 = math.pi / 3;
  static const angle_50 = math.pi * 5 / 18;
  static const angle_45 = math.pi / 4;
  static const angle_40 = math.pi * 2 / 9;
  static const angle_30 = math.pi / 6;
  static const angle_20 = math.pi / 9;
  static const angle_15 = math.pi / 12;
  static const angle_10 = math.pi / 18;
  static const angle_5 = math.pi / 36;
  static const angle_1 = math.pi / 180;
  static const angle_01 = angle_1 / 10;
  static const angle_001 = angle_1 / 100;
}


///
///
///
///
/// [binary]
/// [int2], [int3], ...
/// [double02], [double03], ...
///
///
///
extension VRandom on math.Random {
  static bool get binary => math.Random().nextBool();

  static int get int2 => math.Random().nextInt(2);

  static int get int3 => math.Random().nextInt(3);

  static int get int4 => math.Random().nextInt(4);

  static int get int5 => math.Random().nextInt(5);

  static int get int6 => math.Random().nextInt(6);

  static int get int7 => math.Random().nextInt(7);

  static int get int8 => math.Random().nextInt(8);

  static int get int9 => math.Random().nextInt(9);

  static int get int10 => math.Random().nextInt(10);

  static int get int20 => math.Random().nextInt(20);

  static int get int30 => math.Random().nextInt(30);

  static int get int40 => math.Random().nextInt(40);

  static int get int50 => math.Random().nextInt(50);

  static int get int100 => math.Random().nextInt(100);

  static double get double02 => math.Random().nextInt(2) * 0.1;

  static double get double03 => math.Random().nextInt(3) * 0.1;

  static double get double04 => math.Random().nextInt(4) * 0.1;

  static double get double05 => math.Random().nextInt(5) * 0.1;

  static double get double06 => math.Random().nextInt(6) * 0.1;

  static double get double07 => math.Random().nextInt(7) * 0.1;

  static double get double08 => math.Random().nextInt(8) * 0.1;

  static double get double09 => math.Random().nextInt(9) * 0.1;

  static double get double002 => math.Random().nextInt(2) * 0.01;

  static double get double003 => math.Random().nextInt(3) * 0.01;

  static double get double004 => math.Random().nextInt(4) * 0.01;

  static double get double005 => math.Random().nextInt(5) * 0.01;

  static double get double006 => math.Random().nextInt(6) * 0.01;

  static double get double007 => math.Random().nextInt(7) * 0.01;

  static double get double008 => math.Random().nextInt(8) * 0.01;

  static double get double009 => math.Random().nextInt(9) * 0.01;
}

///
///
///
///
///
/// extension
///
///
///
///
///
///

extension NullableExtension<T> on T? {
  S? nullOr<S>(S value) => this == null ? null : value;

  S? nullOrTranslate<S>(Translator<T, S> value) =>
      this == null ? null : value(this as T);

  S translateOr<S>(
    Translator<T, S> translate, {
    required Supplier<S> ifAbsent,
  }) {
    final value = this;
    return value == null ? ifAbsent() : translate(value);
  }
}

///
///
/// match, string
///
///

extension StringExtension on String {
  String get lowercaseFirstChar => replaceFirstMapped(
      RegExp(r'[A-Z]'), (match) => match.group0.toLowerCase());

  MapEntry<String, String> get splitByFirstSpace {
    late final String key;
    final value = replaceFirstMapped(RegExp(r'\w '), (match) {
      key = match.group0.trim();
      return '';
    });
    return MapEntry(key, value);
  }

  ///
  /// camel, underscore usage
  ///

  String get fromUnderscoreToCamelBody => splitMapJoin(RegExp(r'_[a-z]'),
      onMatch: (match) => match.group0[1].toUpperCase());

  String get fromCamelToUnderscore =>
      lowercaseFirstChar.splitMapJoin(RegExp(r'[a-z][A-Z]'), onMatch: (match) {
        final s = match.group0;
        return '${s[0]}_${s[1].toLowerCase()}';
      });
}

extension MatchExtension on Match {
  String get group0 => group(0)!;
}

