///
///
/// this file contains:
///
/// [FRadian], [FRadianCoordinate]
///
///
/// [FPredicator], [FPredicatorNum], [FPredicatorCombiner], [FPredicatorTernaryCombiner]
/// [FComparatorList]
/// [FMapper], [FMapperDouble], [FMapperBoxConstraints]
/// [FGenerator], [FGeneratorRadius], [FGeneratorOffset], [FGenerator2D]
/// [FTranslator]
/// [FReducerNum]
///
///
///
///
/// [FTextFormFieldValidator]
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

extension FRadian on double {
  static double modulus1Round(double radian) => radian % KRadian.angle_360;

  static double angleOf(double radian) => radian / KRadian.angle_1;

  static double radianOf(double angle) => angle * KRadian.angle_1;

  static double complementaryOf(double radian) {
    assert(radian.rangeIn(0, KRadian.angle_90));
    return radianOf(90 - angleOf(radian));
  }

  static double supplementaryOf(double radian) {
    assert(radian.rangeIn(0, KRadian.angle_180));
    return radianOf(180 - angleOf(radian));
  }

  static double restrictWithinAngle180_180N(double radian) {
    final r = radian % 360;
    return r >= KRadian.angle_180 ? r - KRadian.angle_360 : r;
  }

  ///
  /// if
  ///
  static bool ifWithinAngle90_90N(double radian) =>
      radian.abs() < KRadian.angle_90;

  static bool ifOverAngle90_90N(double radian) =>
      radian.abs() > KRadian.angle_90;

  static bool ifWithinAngle0_180(double radian) =>
      radian > 0 && radian < KRadian.angle_180;

  static bool ifWithinAngle0_180N(double radian) =>
      radian > -KRadian.angle_180 && radian < 0;

  static bool ifOnRight(double radian) =>
      ifWithinAngle90_90N(modulus1Round(radian));

  static bool ifOnLeft(double radian) =>
      ifOverAngle90_90N(modulus1Round(radian));

  static bool ifOnTop(
    double radian, {
    bool isInMathDiscussion = false,
  }) {
    final r = modulus1Round(radian);
    return isInMathDiscussion ? ifWithinAngle0_180(r) : ifWithinAngle0_180N(r);
  }

  static bool ifOnBottom(
    double radian, {
    bool isInMathDiscussion = false,
  }) {
    final r = modulus1Round(radian);
    return isInMathDiscussion ? ifWithinAngle0_180N(r) : ifWithinAngle0_180(r);
  }
}

extension FRadianCoordinate on Coordinate {
  static Coordinate complementaryOf(Coordinate radian) => Coordinate(
        FRadian.complementaryOf(radian.dx),
        FRadian.complementaryOf(radian.dy),
        FRadian.complementaryOf(radian.dz),
      );

  static Coordinate supplementaryOf(Coordinate radian) => Coordinate(
        FRadian.supplementaryOf(radian.dx),
        FRadian.supplementaryOf(radian.dy),
        FRadian.supplementaryOf(radian.dz),
      );

  static Coordinate restrictInAngle180Of(Coordinate radian) => Coordinate(
        FRadian.restrictWithinAngle180_180N(radian.dx),
        FRadian.restrictWithinAngle180_180N(radian.dy),
        FRadian.restrictWithinAngle180_180N(radian.dz),
      );
}

///
///
///
///
///
/// predicator
///
///
///
///
///

extension FPredicator on Predicator {
  static Predicator<DateTime> isSameDayWith(DateTime? day) =>
      (currentDay) => DateTimeExtension.isSameDay(currentDay, day);
}

extension FPredicatorNum on Predicator<num> {
  static bool isALess(num a, num b) => a < b;

  static bool isALarger(num a, num b) => a > b;

  static bool isEntryKeyLess<T>(MapEntry<num, T> a, MapEntry<num, T> b) =>
      a.key < b.key;

  static bool isEntryKeyLarger<T>(MapEntry<num, T> a, MapEntry<num, T> b) =>
      a.key > b.key;
}

extension FPredicatorCombiner on Combiner {
  static bool alwaysTrue<T>(T a, T? b) => true;

  static bool alwaysFalse<T>(T a, T? b) => false;

  static bool equal(bool a, bool? b) => a == b;

  static bool unequal(bool a, bool? b) => a != b;

  static bool intEqual(int a, int? b) => a == b;

  static bool intBigger(int a, int? b) => b != null && a > b;

  static bool intSmaller(int a, int? b) => b != null && a < b;
}

extension FPredicatorTernaryCombiner on Combiner {
  static bool? alwaysTrue<T>(T a, T? b) => true;

  static bool? alwaysFalse<T>(T a, T? b) => false;

  static bool? alwaysNull<T>(T a, T? b) => null;

  static bool? intEqualOrSmallerOrBigger(int? a, int? b) =>
      b == null || a == null
          ? null
          : switch (a - b) {
              0 => true,
              < 0 => false,
              _ => null,
            };
}

///
///
///
/// comparator
///
///
///
extension FComparatorList<C extends Comparable> on Comparator<List<C>> {
  static Comparator<List<C>> accordinglyUntil<C extends Comparable>(
      int index, [
        Comparator<C>? comparator,
      ]) {
    final compare = comparator ?? (C a, C b) => a.compareTo(b);
    return (a, b) {
      int comparing(int i) {
        final value = compare(b[i], a[i]);
        return value == 0 && i < index ? comparing(i + 1) : value;
      }

      return comparing(0);
    };
  }
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

  static Offset offset(Offset v) => v;

  static Iterable<Offset> ofOffsetIterable(Iterable<Offset> v) => v;

  static Coordinate ofCoordinate(Coordinate v) => v;

  static Size ofSize(Size v) => v;

  static Curve ofCurve(Curve v) => v;

  static Curve ofCurveFlipped(Curve v) => v.flipped;
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
  /// sin
  ///
  static Mapper<double> sinFromFactor(double timeFactor, double factor) =>
      (value) => math.sin(timeFactor * value) * factor;

  // return "times of period" of (0 ~ 1 ~ 0 ~ -1 ~ 0)
  static Mapper<double> sinFromPeriod(double times) {
    final tween = Tween(
      begin: 0.0,
      end: switch (times) {
        double.infinity || double.negativeInfinity => throw UnimplementedError(
            'instead of times infinity, pls use [Ani] to repeat animation',
          ),
        _ => KRadian.angle_360 * times,
      },
    );
    return (value) => math.sin(tween.transform(value));
  }
}

extension FMapperBoxConstraints on BoxConstraints {
  static BoxConstraints loosen(BoxConstraints constraints) =>
      constraints.loosen();
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
}

extension FGeneratorRadius on List<Radius> {
  static List<Radius> circular(int n, double radius) =>
      List.generate(n, (index) => Radius.circular(radius));
}

extension FGeneratorOffset on Generator<Offset> {
  static Generator<Offset> withValue(
    double value,
    Offset Function(int index, double value) generator,
  ) =>
      (index) => generator(index, value);

  static Generator<Offset> leftRightLeftRight(
    double dX,
    double dY, {
    required Offset topLeft,
    required Offset Function(int line, double dX, double dY) left,
    required Offset Function(int line, double dX, double dY) right,
  }) =>
      (i) {
        final indexLine = i ~/ 2;
        return topLeft +
            (i % 2 == 0 ? left(indexLine, dX, dY) : right(indexLine, dX, dY));
      };

  static Generator<Offset> grouping2({
    required double dX,
    required double dY,
    required int modulusX,
    required int modulusY,
    required double constantX,
    required double constantY,
    required double group2ConstantX,
    required double group2ConstantY,
    required int group2ThresholdX,
    required int group2ThresholdY,
  }) =>
      (index) => Offset(
            constantX +
                (index % modulusX) * dX +
                (index > group2ThresholdX ? group2ConstantX : 0),
            constantY +
                (index % modulusY) * dY +
                (index > group2ThresholdY ? group2ConstantY : 0),
          );

  static Generator<Offset> topBottomStyle1(double group2ConstantY) => grouping2(
        dX: 78,
        dY: 12,
        modulusX: 6,
        modulusY: 24,
        constantX: -25,
        constantY: -60,
        group2ConstantX: 0,
        group2ConstantY: group2ConstantY,
        group2ThresholdX: 0,
        group2ThresholdY: 11,
      );
}

extension FGenerator2D<T> on Generator2D<T> {
  static Generator2D<T> of<T>(T value) => (i, j) => value;
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

///
///
///
/// others
///
///
///

extension FTextFormFieldValidator on TextFormFieldValidator {
  static FormFieldValidator<String> validateNullOrEmpty(
    String validationFailedMessage,
  ) =>
      (value) =>
          value == null || value.isEmpty ? validationFailedMessage : null;
}
