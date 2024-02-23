///
///
/// this file contains:
///
/// [CubicOffset]
///
/// [SizeExtension], [OffsetExtension], [RectExtension]
/// [AlignmentExtension]
///
///
///
/// [IterableOffsetExtension]
/// [ListOffsetExtension]
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
///
/// [CubicOffset]
///
///
///

class CubicOffset {
  final Cubic x;
  final Cubic y;

  const CubicOffset(this.x, this.y);

  Offset get a => Offset(x.a, y.a);

  Offset get b => Offset(x.b, y.b);

  Offset get c => Offset(x.c, y.c);

  Offset get d => Offset(x.d, y.d);

  CubicOffset.fromPoints(List<Offset> offsets)
      : assert(offsets.length == 4),
        x = Cubic(offsets[0].dx, offsets[1].dx, offsets[2].dx, offsets[3].dx),
        y = Cubic(offsets[0].dy, offsets[1].dy, offsets[2].dy, offsets[3].dy);

  List<Offset> get points =>
      [Offset(x.a, y.a), Offset(x.b, y.b), Offset(x.c, y.c), Offset(x.d, y.d)];

  Offset operator [](int index) => switch (index) {
        0 => Offset(x.a, y.a),
        1 => Offset(x.b, y.b),
        2 => Offset(x.c, y.c),
        3 => Offset(x.d, y.d),
        _ => throw UnimplementedError(index.toString()),
      };

  CubicOffset operator *(double scale) => CubicOffset(
        Cubic(x.a * scale, x.b * scale, x.c * scale, x.d * scale),
        Cubic(y.a * scale, y.b * scale, y.c * scale, y.d * scale),
      );

  CubicOffset mapXY(Mapper<Cubic> mapper) => CubicOffset(mapper(x), mapper(y));

  CubicOffset mapX(Mapper<Cubic> mapper) => CubicOffset(mapper(x), y);

  CubicOffset mapY(Mapper<Cubic> mapper) => CubicOffset(x, mapper(y));

  static CubicOffset companionSizeAdjustCenter(
    CubicOffset cubicOffset,
    Size size,
  ) =>
      CubicOffset.fromPoints(
        cubicOffset.points.adjustCenterFor(size).toList(),
      );
}

///
///
///
/// size, offset, rect
///
///
extension SizeExtension on Size {
  double get diagonal => math.sqrt(width * width + height * height);

  Radius get toRadiusEllipse => Radius.elliptical(width, height);

  Size sizingHeight(double scale) => Size(width, height * scale);

  Size sizingWidth(double scale) => Size(width * scale, height);

  Size extrudingHeight(double value) => Size(width, height + value);

  Size extrudingWidth(double value) => Size(width + value, height);
}

extension OffsetExtension on Offset {
  ///
  ///
  /// instance methods
  ///
  ///
  String toStringAsFixed1() =>
      '(${dx.toStringAsFixed(1)}, ${dy.toStringAsFixed(1)})';

  double directionTo(Offset p) => (p - this).direction;

  double distanceTo(Offset p) => (p - this).distance;

  double distanceHalfTo(Offset p) => (p - this).distance / 2;

  Offset middleWith(Offset p) => (p + this) / 2;

  Offset rotate(double direction) =>
      Offset.fromDirection(this.direction + direction, distance);

  Offset direct(double direction, [double distance = 1]) =>
      this + Offset.fromDirection(direction, distance);

  double directionPerpendicular({bool isCounterclockwise = true}) =>
      direction + math.pi / 2 * (isCounterclockwise ? 1 : -1);

  Offset get toPerpendicularUnit =>
      Offset.fromDirection(directionPerpendicular());

  Offset get toPerpendicular =>
      Offset.fromDirection(directionPerpendicular(), distance);

  bool isAtBottomRightOf(Offset offset) => this > offset;

  bool isAtTopLeftOf(Offset offset) => this < offset;

  bool isAtBottomLeftOf(Offset offset) => dx < offset.dx && dy > offset.dy;

  bool isAtTopRightOf(Offset offset) => dx > offset.dx && dy < offset.dy;

  ///
  ///
  /// instance getters
  ///
  ///

  Size get toSize => Size(dx, dy);

  Offset get toReciprocal => Offset(1 / dx, 1 / dy);

  ///
  ///
  /// static methods:
  ///
  ///
  static Offset square(double value) => Offset(value, value);

  ///
  /// [parallelUnitOf]
  /// [parallelVectorOf]
  /// [parallelOffsetOf]
  /// [parallelOffsetUnitOf]
  /// [parallelOffsetUnitOnCenterOf]
  ///
  static Offset parallelUnitOf(Offset a, Offset b) {
    final offset = b - a;
    return offset / offset.distance;
  }

  static Offset parallelVectorOf(Offset a, Offset b, double t) => (b - a) * t;

  static Offset parallelOffsetOf(Offset a, Offset b, double t) =>
      a + parallelVectorOf(a, b, t);

  static Offset parallelOffsetUnitOf(Offset a, Offset b, double t) =>
      a + parallelUnitOf(a, b) * t;

  static Offset parallelOffsetUnitOnCenterOf(Offset a, Offset b, double t) =>
      a.middleWith(b) + parallelUnitOf(a, b) * t;

  ///
  /// [perpendicularUnitOf]
  /// [perpendicularVectorOf]
  /// [perpendicularOffsetOf]
  /// [perpendicularOffsetUnitOf]
  /// [perpendicularOffsetUnitFromCenterOf]
  ///
  static Offset perpendicularUnitOf(Offset a, Offset b) =>
      (b - a).toPerpendicularUnit;

  static Offset perpendicularVectorOf(Offset a, Offset b, double t) =>
      (b - a).toPerpendicular * t;

  static Offset perpendicularOffsetOf(Offset a, Offset b, double t) =>
      a + perpendicularVectorOf(a, b, t);

  static Offset perpendicularOffsetUnitOf(Offset a, Offset b, double t) =>
      a + perpendicularUnitOf(a, b) * t;

  static Offset perpendicularOffsetUnitFromCenterOf(
    Offset a,
    Offset b,
    double t,
  ) =>
      a.middleWith(b) + perpendicularUnitOf(a, b) * t;
}

extension RectExtension on Rect {
  static Rect fromZeroTo(Size size) => Offset.zero & size;

  static Rect fromLTSize(double left, double top, Size size) =>
      Rect.fromLTWH(left, top, size.width, size.height);

  static Rect fromOffsetSize(Offset zero, Size size) =>
      Rect.fromLTWH(zero.dx, zero.dy, size.width, size.height);

  static Rect fromCenterSize(Offset center, Size size) =>
      Rect.fromCenter(center: center, width: size.width, height: size.height);

  static Rect fromCircle(Offset center, double radius) =>
      Rect.fromCircle(center: center, radius: radius);

  double get distanceDiagonal => size.diagonal;

  Offset offsetFromDirection(Direction direction) => switch (direction) {
        Direction2D() => () {
            final direction2DIn8 = switch (direction) {
              Direction2DIn4() => direction.toDirection8,
              Direction2DIn8() => direction,
            };
            return switch (direction2DIn8) {
              Direction2DIn8.top => topCenter,
              Direction2DIn8.left => centerLeft,
              Direction2DIn8.right => centerRight,
              Direction2DIn8.bottom => bottomCenter,
              Direction2DIn8.topLeft => topLeft,
              Direction2DIn8.topRight => topRight,
              Direction2DIn8.bottomLeft => bottomLeft,
              Direction2DIn8.bottomRight => bottomRight,
            };
          }(),
        Direction3D() => throw UnimplementedError(),
      };
}

///
///
///
/// alignment
///
///
///

///
/// [flipped]
/// [radianRangeForSide], [radianBoundaryForSide]
/// [radianRangeForSideStepOf]
/// [directionOfSideSpace]
///
/// [deviateBuilder]
///
/// [parseRect]
/// [transformFromDirection]
///
///
extension AlignmentExtension on Alignment {
  Alignment get flipped => Alignment(-x, -y);

  static Alignment fromDirection(Direction2D direction) => switch (direction) {
        Direction2DIn4() => fromDirection(direction.toDirection8),
        Direction2DIn8() => switch (direction) {
            Direction2DIn8.top => Alignment.topCenter,
            Direction2DIn8.left => Alignment.centerLeft,
            Direction2DIn8.right => Alignment.centerRight,
            Direction2DIn8.bottom => Alignment.bottomCenter,
            Direction2DIn8.topLeft => Alignment.topLeft,
            Direction2DIn8.topRight => Alignment.topRight,
            Direction2DIn8.bottomLeft => Alignment.bottomLeft,
            Direction2DIn8.bottomRight => Alignment.bottomRight,
          }
      };

  double get radianRangeForSide {
    final boundary = radianBoundaryForSide;
    return boundary.$2 - boundary.$1;
  }

  (double, double) get radianBoundaryForSide => switch (this) {
        Alignment.center => (0, Radian.angle_360),
        Alignment.centerLeft => (-Radian.angle_90, Radian.angle_90),
        Alignment.centerRight => (Radian.angle_90, Radian.angle_270),
        Alignment.topCenter => (0, Radian.angle_180),
        Alignment.topLeft => (0, Radian.angle_90),
        Alignment.topRight => (Radian.angle_90, Radian.angle_180),
        Alignment.bottomCenter => (Radian.angle_180, Radian.angle_360),
        Alignment.bottomLeft => (Radian.angle_270, Radian.angle_360),
        Alignment.bottomRight => (Radian.angle_180, Radian.angle_270),
        _ => throw UnimplementedError(),
      };

  double radianRangeForSideStepOf(int count) =>
      radianRangeForSide / (this == Alignment.center ? count : count - 1);

  Generator<double> directionOfSideSpace(bool isClockwise, int count) {
    final boundary = radianBoundaryForSide;
    final origin = isClockwise ? boundary.$1 : boundary.$2;
    final step = radianRangeForSideStepOf(count);

    return isClockwise
        ? (index) => origin + step * index
        : (index) => origin - step * index;
  }

  Mapper<Widget> get deviateBuilder {
    Row rowOf(List<Widget> children) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        );

    final rowBuilder = switch (x) {
      0 => (child) => rowOf([child]),
      1 => (child) => rowOf([child, WSizedBox.expand]),
      -1 => (child) => rowOf([WSizedBox.expand, child]),
      _ => throw UnimplementedError(),
    };

    Column columnOf(List<Widget> children) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        );

    final columnBuilder = switch (y) {
      0 => (child) => columnOf([child]),
      1 => (child) => columnOf([rowBuilder(child), WSizedBox.expand]),
      -1 => (child) => columnOf([WSizedBox.expand, rowBuilder(child)]),
      _ => throw UnimplementedError(),
    };

    return (child) => columnBuilder(child);
  }

  Offset parseRect(Rect rect) => switch (this) {
        Alignment.topLeft => rect.topLeft,
        Alignment.topCenter => rect.topCenter,
        Alignment.topRight => rect.topRight,
        Alignment.centerLeft => rect.centerLeft,
        Alignment.center => rect.center,
        Alignment.centerRight => rect.centerRight,
        Alignment.bottomLeft => rect.bottomLeft,
        Alignment.bottomCenter => rect.bottomCenter,
        Alignment.bottomRight => rect.bottomRight,
        _ => throw UnimplementedError(),
      };

  static Transform transformFromDirection(
    Direction3DIn6 direction, {
    Coordinate initialRadian = Coordinate.zero,
    double zDeep = 100,
    required Widget child,
  }) {
    Matrix4 instance() => Matrix4.identity();
    return initialRadian == Coordinate.zero
        ? switch (direction) {
            Direction3DIn6.front => Transform(
                transform: instance(),
                alignment: Alignment.center,
                child: child,
              ),
            Direction3DIn6.back => Transform(
                transform: instance()..translate(Vector3(0, 0, -zDeep)),
                alignment: Alignment.center,
                child: child,
              ),
            Direction3DIn6.left => Transform(
                alignment: Alignment.centerLeft,
                transform: instance()..rotateY(Radian.angle_90),
                child: child,
              ),
            Direction3DIn6.right => Transform(
                alignment: Alignment.centerRight,
                transform: instance()..rotateY(-Radian.angle_90),
                child: child,
              ),
            Direction3DIn6.top => Transform(
                alignment: Alignment.topCenter,
                transform: instance()..rotateX(-Radian.angle_90),
                child: child,
              ),
            Direction3DIn6.bottom => Transform(
                alignment: Alignment.bottomCenter,
                transform: instance()..rotateX(Radian.angle_90),
                child: child,
              ),
          }
        : throw UnimplementedError();
  }
}

///
///
///
/// [IterableOffsetExtension]
///
///
///

///
/// instance methods:
/// [scaling]
/// [adjustCenterFor]
///
/// static methods:
/// [mapperScaling]
/// [companionAdjustCenter]
/// [fillRadiusCircular]
/// [generatorWithValue], [generatorLeftRightLeftRight], [generatorGrouping2], [generatorTopBottomStyle1]
///
///
extension IterableOffsetExtension on Iterable<Offset> {
  Iterable<Offset> scaling(double value) => map((o) => o * value);

  Iterable<Offset> adjustCenterFor(Size size, {Offset origin = Offset.zero}) {
    final center = size.center(origin);
    return map((p) => p + center);
  }

  static Mapper<Iterable<Offset>> mapperScaling(double scale) => scale == 1
      ? FMapperMaterial.keepOffsetIterable
      : (points) => points.scaling(scale);

  ///
  /// companion
  ///
  static Iterable<Offset> companionAdjustCenter(
    Iterable<Offset> points,
    Size size,
  ) =>
      points.adjustCenterFor(size);

  ///
  /// fill
  ///
  static Generator<Radius> fillRadiusCircular(double radius) =>
      (_) => Radius.circular(radius);

  ///
  /// generator
  ///
  static Generator<Offset> generatorWithValue(
    double value,
    GeneratorTranslator<double, Offset> generator,
  ) =>
      (index) => generator(index, value);

  static Generator<Offset> generatorLeftRightLeftRight(
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

  static Generator<Offset> generatorGrouping2({
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

  static Generator<Offset> generatorTopBottomStyle1(double group2ConstantY) =>
      generatorGrouping2(
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
/// [ListOffsetExtension]
///
///
///

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
