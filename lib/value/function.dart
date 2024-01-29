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
/// [FExtruding2D]
/// [FWidgetParentBuilder]
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
        FRadian.restrict180AbsForAngle(radian.dx),
        FRadian.restrict180AbsForAngle(radian.dy),
        FRadian.restrict180AbsForAngle(radian.dz),
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

  static Offset offset(Offset v) => v;

  static Iterable<Offset> ofOffsetIterable(Iterable<Offset> v) => v;

  static Coordinate ofCoordinate(Coordinate v) => v;

  static Size ofSize(Size v) => v;

  static Curve ofCurve(Curve v) => v;

  static Curve ofCurveFlipped(Curve v) => v.flipped;

  static BoxConstraints ofBoxConstraints(BoxConstraints v) => v;

  static BoxConstraints boxConstraintsLoosen(BoxConstraints constraints) =>
      constraints.loosen();
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
  /// sin, cos
  ///
  static Mapper<double> sinFromFactor(double timeFactor, double factor) =>
      (value) => math.sin(timeFactor * value) * factor;

  // return "times of period" of (0 ~ 1 ~ 0 ~ -1 ~ 0)
  static Mapper<double> sinFromPeriod(double times) {
    assert(times.isFinite);
    final tween = Tween(begin: 0.0, end: KRadian.angle_360 * times);
    return (value) => math.sin(tween.transform(value));
  }

  static Mapper<double> cosFromFactor(double timeFactor, double factor) =>
          (value) => math.cos(timeFactor * value) * factor;

  // return "times of period" of (1 ~ 0 ~ -1 ~ 0 ~ 1)
  static Mapper<double> cosFromPeriod(double times) {
    assert(times.isFinite);
    final tween = Tween(begin: 0.0, end: KRadian.angle_360 * times);
    return (value) => math.cos(tween.transform(value));
  }
}

extension FMapperCubic on Cubic {
  static Cubic aCdB(Cubic cubic) => Cubic(cubic.a, cubic.c, cubic.d, cubic.b);

  static Cubic bCdA(Cubic cubic) => Cubic(cubic.b, cubic.c, cubic.d, cubic.a);
}

extension FMapperMapCubicOffset on Mapper<Map<Offset, CubicOffset>> {
  static Map<Offset, CubicOffset> aCdB(Map<Offset, CubicOffset> points) =>
      points.map(
        (current, cubics) => MapEntry(
          current,
          cubics.mapXY(FMapperCubic.aCdB),
        ),
      );

  static Mapper<Map<Offset, CubicOffset>> of(Mapper<Cubic> mapper) =>
      (corners) => corners.map(
            (p, cubics) => MapEntry(p, cubics.mapXY(mapper)),
          );
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

  static Generator<Radius> radiusFillCircular(double radius) =>
      (_) => Radius.circular(radius);

  static Generator2D<T> fill2D<T>(T value) => (i, j) => value;
}

extension FGeneratorOffset on Generator<Offset> {
  static Generator<Offset> withValue(
    double value,
    GeneratorTranslator<double, Offset> generator,
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

///
///
///
/// others
///
///
///

///
/// static methods:
/// [directOnSize], [directOnWidth], [directByDimension]
/// [fromRectDirection]
///
/// instance methods:
/// [translateOnSize], [translateOnWidth], [translateOfDimension]
///
///
extension FExtruding2D on Extruding2D {
  static Translator<double, Rect> directOnSize({
    required Rect rect,
    required Direction2D direction,
    required double width,
    required double height,
    bool timesOrPlus = true,
  }) =>
      fromRectDirection(rect, direction).translateOnSize(
        width,
        height,
        timesOrPlus: timesOrPlus,
      );

  static Translator<double, Rect> directOnWidth({
    required Rect rect,
    required Direction2D direction,
    required double width,
  }) =>
      fromRectDirection(rect, direction).translateOnWidth(width);

  static Translator<double, Rect> directByDimension({
    required Rect rect,
    required Direction2D direction,
    required double dimension,
    bool timesOrPlus = true,
  }) =>
      fromRectDirection(rect, direction).translateOfDimension(
        dimension,
        timesOrPlus: timesOrPlus,
      );

  static Extruding2D fromRectDirection(Rect rect, Direction2D direction) =>
      switch (direction) {
        Direction2DIn4.top || Direction2DIn8.top => () {
            final origin = rect.topCenter;
            return (width, length) => Rect.fromPoints(
                  origin + Offset(width / 2, 0),
                  origin + Offset(-width / 2, -length),
                );
          }(),
        Direction2DIn4.left || Direction2DIn8.left => () {
            final origin = rect.centerLeft;
            return (width, length) => Rect.fromPoints(
                  origin + Offset(0, width / 2),
                  origin + Offset(-length, -width / 2),
                );
          }(),
        Direction2DIn4.right || Direction2DIn8.right => () {
            final origin = rect.centerRight;
            return (width, length) => Rect.fromPoints(
                  origin + Offset(0, width / 2),
                  origin + Offset(length, -width / 2),
                );
          }(),
        Direction2DIn4.bottom || Direction2DIn8.bottom => () {
            final origin = rect.bottomCenter;
            return (width, length) => Rect.fromPoints(
                  origin + Offset(width / 2, 0),
                  origin + Offset(-width / 2, length),
                );
          }(),
        Direction2DIn8.topLeft => () {
            final origin = rect.topLeft;
            return (width, length) => Rect.fromPoints(
                  origin,
                  origin + Offset(-length, -length) * DoubleExtension.sqrt1_2,
                );
          }(),
        Direction2DIn8.topRight => () {
            final origin = rect.topRight;
            return (width, length) => Rect.fromPoints(
                  origin,
                  origin + Offset(length, -length) * DoubleExtension.sqrt1_2,
                );
          }(),
        Direction2DIn8.bottomLeft => () {
            final origin = rect.bottomLeft;
            return (width, length) => Rect.fromPoints(
                  origin,
                  origin + Offset(-length, length) * DoubleExtension.sqrt1_2,
                );
          }(),
        Direction2DIn8.bottomRight => () {
            final origin = rect.bottomRight;
            return (width, length) => Rect.fromPoints(
                  origin,
                  origin + Offset(length, length) * DoubleExtension.sqrt1_2,
                );
          }(),
      };

  ///
  /// when [timesOrPlus] == true, its means that extruding value will be multiplied on [height]
  /// when [timesOrPlus] == false, its means that extruding value will be added on [height]
  ///
  Translator<double, Rect> translateOnSize(
    double width,
    double height, {
    bool timesOrPlus = true,
  }) {
    final calculating = timesOrPlus ? (v) => height * v : (v) => height + v;
    return (value) => this(width, calculating(value));
  }

  Translator<double, Rect> translateOnWidth(double width) =>
      translateOnSize(width, 0, timesOrPlus: false);

  Translator<double, Rect> translateOfDimension(
    double dimension, {
    bool timesOrPlus = true,
  }) =>
      translateOnSize(dimension, dimension, timesOrPlus: timesOrPlus);
}

extension FWidgetParentBuilder on WidgetParentBuilder {
  WidgetBuilder builderFrom(Iterable<WidgetBuilder> children) =>
      (context) => this(context, [...children.map((build) => build(context))]);
}

extension FTextFormFieldValidator on TextFormFieldValidator {
  static FormFieldValidator<String> validateNullOrEmpty(
    String validationFailedMessage,
  ) =>
      (value) =>
          value == null || value.isEmpty ? validationFailedMessage : null;
}
