///
///
/// this file contains:
///
/// [FRadian], [FRadianCoordinate]
///
///
/// [FPredicator], [FPredicatorCombiner]
/// [FMapper], [FMapperDouble], [FMapperCubic], [FMapperMapCubicOffset]
/// [FGenerator], [FGeneratorOffset]
/// [FTranslator]
/// [FReducerNum]
/// [FCompanion]
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
///
///
///
///
///
///
part of dastore;

///
///
/// the radian of dart and math are different, see also the comment above [Coordinate.fromDirection]
///
///

///
/// [radianFromAngle], [radianFromRound], ...
/// [complementaryOf], [supplementaryOf], ...
///
/// [ifWithinAngle90_90N], [ifOverAngle90_90N], ...
/// [ifInQuadrant1], [ifInQuadrant2], [ifInQuadrant3], [ifInQuadrant4]
/// [ifOnRight], [ifOnLeft], [ifOnTop], [ifOnBottom]
///
///
extension FRadian on double {
  static double radianFromAngle(double angle) => angle * KRadian.angle_1;

  static double radianFromRound(double round) => round * KRadian.angle_360;

  static double angleOf(double radian) => radian / KRadian.angle_1;

  static double roundOf(double radian) => radian / KRadian.angle_360;

  static double modulus90AngleOf(double radian) => radian % KRadian.angle_90;

  static double modulus180AngleOf(double radian) => radian % KRadian.angle_180;

  static double modulus360AngleOf(double radian) => radian % KRadian.angle_360;

  ///
  /// [complementaryOf], [supplementaryOf], [restrict180AbsForAngle]
  ///
  static double complementaryOf(double radian) {
    assert(radian.rangeIn(0, KRadian.angle_90));
    return radianFromAngle(90 - angleOf(radian));
  }

  static double supplementaryOf(double radian) {
    assert(radian.rangeIn(0, KRadian.angle_180));
    return radianFromAngle(180 - angleOf(radian));
  }

  static double restrict180AbsForAngle(double angle) {
    final r = angle % 360;
    return r >= KRadian.angle_180 ? r - KRadian.angle_360 : r;
  }

  ///
  /// [ifWithinAngle90_90N], [ifOverAngle90_90N], [ifWithinAngle0_180], [ifWithinAngle0_180N]
  ///
  static bool ifWithinAngle90_90N(double radian) =>
      radian.abs() < KRadian.angle_90;

  static bool ifOverAngle90_90N(double radian) =>
      radian.abs() > KRadian.angle_90;

  static bool ifWithinAngle0_180(double radian) =>
      radian > 0 && radian < KRadian.angle_180;

  static bool ifWithinAngle0_180N(double radian) =>
      radian > -KRadian.angle_180 && radian < 0;

  ///
  /// [ifInQuadrant1], [ifInQuadrant2], [ifInQuadrant3], [ifInQuadrant4]
  ///
  static bool ifInQuadrant1(double radian, {bool isInMathDiscussion = false}) {
    final r = modulus360AngleOf(radian);
    return isInMathDiscussion
        ? r.within(0, KRadian.angle_90) ||
            r.within(-KRadian.angle_360, -KRadian.angle_270)
        : r.within(KRadian.angle_270, KRadian.angle_360) ||
            r.within(-KRadian.angle_90, 0);
  }

  static bool ifInQuadrant2(double radian, {bool isInMathDiscussion = false}) {
    final r = modulus360AngleOf(radian);
    return isInMathDiscussion
        ? r.within(KRadian.angle_90, KRadian.angle_180) ||
            r.within(-KRadian.angle_270, -KRadian.angle_180)
        : r.within(KRadian.angle_180, KRadian.angle_270) ||
            r.within(-KRadian.angle_180, -KRadian.angle_90);
  }

  static bool ifInQuadrant3(double radian, {bool isInMathDiscussion = false}) {
    final r = modulus360AngleOf(radian);
    return isInMathDiscussion
        ? r.within(KRadian.angle_180, KRadian.angle_270) ||
            r.within(-KRadian.angle_180, -KRadian.angle_90)
        : r.within(KRadian.angle_90, KRadian.angle_180) ||
            r.within(-KRadian.angle_270, -KRadian.angle_180);
  }

  static bool ifInQuadrant4(double radian, {bool isInMathDiscussion = false}) {
    final r = modulus360AngleOf(radian);
    return isInMathDiscussion
        ? r.within(KRadian.angle_270, KRadian.angle_360) ||
            r.within(-KRadian.angle_90, 0)
        : r.within(0, KRadian.angle_90) ||
            r.within(-KRadian.angle_360, -KRadian.angle_270);
  }

  ///
  /// [ifOnRight], [ifOnLeft], [ifOnTop], [ifOnBottom]
  /// 'right' and 'left' are the same no matter in dart or in math
  ///
  static bool ifOnRight(double radian) =>
      ifWithinAngle90_90N(modulus360AngleOf(radian));

  static bool ifOnLeft(double radian) =>
      ifOverAngle90_90N(modulus360AngleOf(radian));

  static bool ifOnTop(double radian, {bool isInMathDiscussion = false}) {
    final r = modulus360AngleOf(radian);
    return isInMathDiscussion ? ifWithinAngle0_180(r) : ifWithinAngle0_180N(r);
  }

  static bool ifOnBottom(
    double radian, {
    bool isInMathDiscussion = false,
  }) {
    final r = modulus360AngleOf(radian);
    return isInMathDiscussion ? ifWithinAngle0_180N(r) : ifWithinAngle0_180(r);
  }
}

///
///
/// listener
///
///
extension FListener on Listener {
  static void none() {}

  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}

///
///
/// predicator
///
///
extension FPredicator on Predicator {
  static Predicator<DateTime> isSameDayWith(DateTime? day) =>
      (currentDay) => DateTimeExtension.isSameDay(currentDay, day);
}

extension FPredicatorCombiner on PredicateCombiner<num> {
  // bool
  static bool boolEqual(bool a, bool b) => a == b;

  static bool boolUnequal(bool a, bool b) => a != b;

  // num
  static bool numEqual(num a, num b) => a == b;

  static bool numIsALess(num a, num b) => a < b;

  static bool numIsALarger(num a, num b) => a > b;

  // int
  static bool intEqual(int a, int b) => a == b;

  static bool intIsALess(int a, int b) => a < b;

  static bool intIsALarger(int a, int b) => a > b;

  // double
  static bool doubleEqual(double a, double b) => a == b;

  static bool doubleIsALess(double a, double b) => a < b;

  static bool doubleIsALarger(double a, double b) => a > b;

  // entry key
  static bool entryIsNumKeyLess<T>(MapEntry<num, T> a, MapEntry<num, T> b) =>
      a.key < b.key;

  static bool entryIsNumKeyLarger<T>(MapEntry<num, T> a, MapEntry<num, T> b) =>
      a.key > b.key;

  // always
  static bool alwaysTrue<T>(T a, T b) => true;

  static bool alwaysFalse<T>(T a, T b) => false;

  static bool? ternaryAlwaysTrue<T>(T a, T b) => true;

  static bool? ternaryAlwaysFalse<T>(T a, T b) => false;

  static bool? ternaryAlwaysNull<T>(T a, T b) => null;

  // ternary equal, less, larger
  static bool? ternaryIntEqualOrLessOrLarger(int a, int b) => switch (a - b) {
        0 => true,
        < 0 => false,
        _ => null,
      };
}

///
///
///
///
///
/// mapper
///
///
///
///
///

extension FMapper on Mapper {
  static T keep<T>(T value) => value;

  static Translator<double, T> lerpOf<T>(
    T begin,
    T end,
    Translator<double, T> transform,
  ) =>
      (value) {
        if (value == 0) return begin;
        if (value == 1) return end;
        return transform(value);
      };
}

extension FMapperDouble on Mapper<double> {
  static double of(double v) => v;

  static double zero(double value) => 0;

  static double keep(double value) => value;

  ///
  /// operate
  ///
  static Mapper<double> plus(double value) => (v) => v + value;

  static Mapper<double> minus(double value) => (v) => v - value;

  static Mapper<double> multiply(double value) => (v) => v * value;

  static Mapper<double> divide(double value) => (v) => v / value;

  static Mapper<double> operate(Operator operator, double value) =>
      operator.doubleCompanion(value);

  ///
  /// [fromTimesFactor], [fromPeriod]
  ///
  static Mapper<double> fromTimesFactor(
    double times,
    double factor, [
    Mapper<double> transform = math.sin,
  ]) {
    assert(times.isFinite && factor.isFinite);
    return (value) => transform(times * value) * factor;
  }

  // sin period: (0 ~ 1 ~ 0 ~ -1 ~ 0)
  // cos period: (1 ~ 0 ~ -1 ~ 0 ~ 1)
  static Mapper<double> fromPeriod(
    double period, [
    Mapper<double> transform = math.sin,
  ]) {
    assert(transform == math.sin || transform == math.cos);
    final times = KRadian.angle_360 * period;
    return FMapper.lerpOf(0, 1, (value) => transform(times * value));
  }
}

///
///
///
///
///
///
///
/// generator
///
///
///
///
///
///
///
extension FGenerator on Generator {
  static Generator<T> fill<T>(T value) => (i) => value;

  static double toDouble(int index) => index.toDouble();

  static Generator2D<T> fill2D<T>(T value) => (i, j) => value;
}

///
///
///
///
///
///
///
///
/// translator
///
///
///
///
///
///
///
///
extension FTranslator on Translator {
  static Translator<int, bool> oddOrEvenCheckerAs(int value) =>
      value.isOdd ? (v) => v.isOdd : (v) => v.isEven;

  static Translator<int, bool> oddOrEvenCheckerOpposite(int value) =>
      value.isOdd ? (v) => v.isEven : (v) => v.isOdd;
}

///
/// [doubleMax], [doubleMin]
/// [doubleAdding]
///
/// [intMax], [intMin]
/// [intAdding]
///
extension FReducerNum<N extends num> on Reducer<N> {
  static const Reducer<double> doubleMax = math.max<double>;
  static const Reducer<double> doubleMin = math.min<double>;
  static const Reducer<double> doubleAdding = _doubleAdding;
  static const Reducer<int> intMax = math.max<int>;
  static const Reducer<int> intMin = math.min<int>;
  static const Reducer<int> intAdding = _intAdding;

  static double _doubleAdding(double v1, double v2) => v1 + v2;

  static int _intAdding(int v1, int v2) => v1 + v2;
}

extension FCompanion on Companion {
  static T keep<T, S>(T origin, S another) => origin;
}
