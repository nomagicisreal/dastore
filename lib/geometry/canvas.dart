///
///
/// this file contains:
///
/// [PathOperationExtension]
///
///
///
/// [FSizingPath]
/// [FSizingRect]
/// [FSizingOffset]
/// [FSizingPaintFromCanvas]
///
/// [FRectBuilder]
///
///
///
///
/// [FGeneratorOffset]
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

extension PathOperationExtension on PathOperation {
  SizingPath combine(SizingPath previous, SizingPath next) =>
          (size) => Path.combine(this, previous(size), next(size));

  SizingPath combineAll(Iterable<SizingPath> iterable) =>
      iterable.reduce((previous, next) => combine(previous, next));
}

///
/// instance methods
/// [difference], [intersect], [union], [xor], [reverseDifference]
///
///
/// static methods:
/// [of], [combineAll]
/// [lineTo], ..., [bezierQuadratic], [bezierCubic], ...
///
/// [rect], ...
/// [rRect], ...
/// [oval], ..., [circle]
/// [polygon], ...
/// [shapeBorder]
///
/// [pie], [pieOfLeftRight], ...
/// [finger], [crayon], [trapeziumSymmetry]
/// ...
///
///
extension FSizingPath on SizingPath {
  SizingPath difference(SizingPath another) =>
      PathOperation.difference.combine(this, another);

  SizingPath intersect(SizingPath another) =>
      PathOperation.intersect.combine(this, another);

  SizingPath union(SizingPath another) =>
      PathOperation.union.combine(this, another);

  SizingPath xor(SizingPath another) =>
      PathOperation.xor.combine(this, another);

  SizingPath reverseDifference(SizingPath another) =>
      PathOperation.reverseDifference.combine(this, another);

  static SizingPath of(Path value) => (_) => value;

  static SizingPath combineAll(
      PathOperation operation,
      Iterable<SizingPath> iterable,
      ) =>
      operation.combineAll(iterable);

  ///
  ///
  /// line
  ///
  ///
  static SizingPath lineTo(Offset point) => (_) => Path()..lineToPoint(point);

  static SizingPath connect(Offset a, Offset b) =>
          (size) => Path()..lineFromAToB(a, b);

  static SizingPath connectAll({
    Offset begin = Offset.zero,
    required Iterable<Offset> points,
    PathFillType pathFillType = PathFillType.nonZero,
  }) =>
          (size) => Path()
        ..lineFromAToAll(begin, points)
        ..fillType = pathFillType;

  static SizingPath lineToFromSize(SizingOffset point) =>
          (size) => Path()..lineToPoint(point(size));

  static SizingPath connectFromSize(
      SizingOffset a,
      SizingOffset b,
      ) =>
          (size) => Path()..lineFromAToB(a(size), b(size));

  static SizingPath connectAllFromSize({
    SizingOffset begin = FSizingOffset.zero,
    required SizingOffsetIterable points,
    PathFillType pathFillType = PathFillType.nonZero,
  }) =>
          (size) => Path()
        ..lineFromAToAll(begin(size), points(size))
        ..fillType = pathFillType;

  static SizingPath bezierQuadratic(
      Offset controlPoint,
      Offset end, {
        Offset begin = Offset.zero,
      }) =>
      begin == Offset.zero
          ? (size) => Path()..quadraticBezierToPoint(controlPoint, end)
          : (size) => Path()
        ..moveToPoint(begin)
        ..quadraticBezierToPoint(controlPoint, end);

  static SizingPath bezierCubic(
      Offset c1,
      Offset c2,
      Offset end, {
        Offset begin = Offset.zero,
      }) =>
      begin == Offset.zero
          ? (size) => Path()..cubicToPoint(c1, c2, end)
          : (size) => Path()
        ..moveToPoint(begin)
        ..cubicToPoint(c1, c2, end);

  ///
  /// rect
  ///
  static SizingPath get rectFullSize =>
          (size) => Path()..addRect(Offset.zero & size);

  static SizingPath rect(Rect rect) => (size) => Path()..addRect(rect);

  static SizingPath rectFromZeroToSize(Size size) =>
          (_) => Path()..addRect(Offset.zero & size);

  static SizingPath rectFromZeroToOffset(Offset offset) =>
          (size) => Path()..addRect(Rect.fromPoints(Offset.zero, offset));

  ///
  /// rRect
  ///
  static SizingPath rRect(RRect rRect) => (size) => Path()..addRRect(rRect);

  ///
  /// oval
  ///
  static SizingPath oval(Rect rect) => (size) => Path()..addOval(rect);

  static SizingPath ovalFromCenterSize(Offset center, Size size) =>
      oval(RectExtension.fromCenterSize(center, size));

  static SizingPath circle(Offset center, double radius) =>
      oval(RectExtension.fromCircle(center, radius));

  ///
  /// polygon
  ///
  /// [polygon], [polygonFromSize]
  /// [polygonCubic], [polygonCubicFromSize]
  ///
  /// 1. see [RegularPolygon.cornersOf] to create corners of regular polygon
  /// 2. [polygonCubic.cornersCubic] should be the cubic points related to polygon corners in clockwise or counterclockwise sequence
  /// every element list of [cornersCubic] will be treated as [beginPoint, controlPointA, controlPointB, endPoint]
  /// see [RRegularPolygon.cubicPoints] and its subclasses for creating [cornersCubic]
  ///
  ///
  static SizingPath polygon(List<Offset> corners) =>
          (size) => Path()..addPolygon(corners, false);

  static SizingPath polygonFromSize(SizingOffsetList corners) =>
          (size) => Path()..addPolygon(corners(size), false);

  static SizingPath _polygonCubic(
      Iterable<Iterable<Offset>> points,
      double scale, {
        Companion<Iterable<Offset>, Size>? adjust,
      }) {
    final scaling = IterableOffsetExtension.scalingMapper(scale);

    Path from(Iterable<Iterable<Offset>> offsets) => offsets
        .map((points) => scaling(points).toList(growable: false))
        .foldWithIndex(
      Path(),
          (path, points, index) => path
        ..moveOrLineToPoint(points[0], index == 0)
        ..cubicToPointsList(points.sublist(1)),
    )..close();

    return adjust == null
        ? (size) => from(points)
        : (size) => from(points.map((points) => adjust(points, size)));
  }

  static SizingPath polygonCubic(
      Iterable<List<Offset>> cornersCubic, {
        double scale = 1,
      }) =>
      _polygonCubic(cornersCubic, scale);

  static SizingPath polygonCubicFromSize(
      Iterable<List<Offset>> cornersCubic, {
        double scale = 1,
        Companion<Iterable<Offset>, Size> adjust =
            IterableOffsetExtension.adjustCenterCompanion,
      }) =>
      _polygonCubic(cornersCubic, scale, adjust: adjust);

  ///
  /// shape border
  ///
  static SizingPath _shapeBorderOuter(
      ShapeBorder shape,
      SizingRect sizingRect,
      TextDirection? textDirection,
      ) =>
          (size) => shape.getOuterPath(
        sizingRect(size),
        textDirection: textDirection,
      );

  static SizingPath _shapeBorderInner(
      ShapeBorder shape,
      SizingRect sizingRect,
      TextDirection? textDirection,
      ) =>
          (size) => shape.getInnerPath(
        sizingRect(size),
        textDirection: textDirection,
      );

  static SizingPath shapeBorder(
      ShapeBorder shape, {
        TextDirection? textDirection,
        bool outerPath = true,
        SizingRect sizingRect = FSizingRect.full,
      }) =>
      outerPath
          ? _shapeBorderOuter(shape, sizingRect, textDirection)
          : _shapeBorderInner(shape, sizingRect, textDirection);

  ///
  /// [pie]
  /// [pieFromCenterDirectionRadius]
  /// [pieFromSize]
  /// [pieOfLeftRight]
  ///
  static SizingPath pie(
      Offset arcStart,
      Offset arcEnd, {
        bool clockwise = true,
      }) {
    final radius = arcEnd.distanceHalfTo(arcStart).toCircularRadius;
    return (size) => Path()
      ..arcFromStartToEnd(arcStart, arcEnd,
          radius: radius, clockwise: clockwise)
      ..close();
  }

  static SizingPath pieFromSize({
    required SizingOffset arcStart,
    required SizingOffset arcEnd,
    bool clockwise = true,
  }) =>
          (size) {
        final start = arcStart(size);
        final end = arcEnd(size);
        return Path()
          ..moveToPoint(start)
          ..arcToPoint(
            end,
            radius: end.distanceHalfTo(start).toCircularRadius,
            clockwise: clockwise,
          )
          ..close();
      };

  static SizingPath pieOfLeftRight(bool isRight) => isRight
      ? FSizingPath.pieFromSize(
    arcStart: (size) => Offset.zero,
    arcEnd: (size) => size.bottomLeft(Offset.zero),
    clockwise: true,
  )
      : FSizingPath.pieFromSize(
    arcStart: (size) => size.topRight(Offset.zero),
    arcEnd: (size) => size.bottomRight(Offset.zero),
    clockwise: false,
  );

  static SizingPath pieFromCenterDirectionRadius(
      Offset arcCenter,
      double dStart,
      double dEnd,
      double r, {
        bool clockwise = true,
      }) {
    final arcStart = arcCenter.direct(dStart, r);
    final arcEnd = arcCenter.direct(dEnd, r);
    return (size) => Path()
      ..moveToPoint(arcStart)
      ..arcToPoint(arcEnd, radius: r.toCircularRadius, clockwise: clockwise)
      ..close();
  }

  ///
  /// finger
  ///
  ///  ( )
  /// (   )  <---- [tip]
  /// |   |
  /// |   |
  /// |   |
  /// -----  <----[root]
  ///
  static SizingPath finger({
    required Offset rootA,
    required double width,
    required double length,
    required double direction,
    bool clockwise = true,
  }) {
    final tipA = rootA.direct(direction, length);
    final rootB = rootA.direct(
      direction + KRadian.angle_90 * (clockwise ? 1 : -1),
      width,
    );
    final tipB = rootB.direct(direction, length);
    final radius = (width / 2).toCircularRadius;
    return (size) => Path()
      ..moveToPoint(rootA)
      ..lineToPoint(tipA)
      ..arcToPoint(tipB, radius: radius, clockwise: clockwise)
      ..lineToPoint(rootB)
      ..close();
  }

  /// crayon
  ///
  /// -----
  /// |   |
  /// |   |   <----[bodyLength]
  /// |   |
  /// \   /
  ///  ---   <---- [tipWidth]
  ///
  static SizingPath crayon({
    required SizingDouble tipWidth,
    required SizingDouble bodyLength,
  }) =>
          (size) {
        final width = size.width;
        final height = size.height;
        final flatLength = tipWidth(size);
        final penBody = bodyLength(size);

        return Path()
          ..lineTo(width, 0.0)
          ..lineTo(width, penBody)
          ..lineTo((width + flatLength) / 2, height)
          ..lineTo((width - flatLength) / 2, height)
          ..lineTo(0.0, penBody)
          ..lineTo(0.0, 0.0)
          ..close();
      };

  static SizingPath trapeziumSymmetry({
    required SizingOffset topLeftMargin,
    required Mapper<Size> body,
    required SizingDouble bodyShortest,
    Direction2DIn4 shortestSide = Direction2DIn4.top,
  }) =>
          (size) {
        // final origin = topLeftMargin(size);
        // final bodySize = body(size);
        throw UnimplementedError();
      };
}

extension FSizingRect on SizingRect {
  static Rect full(Size size) => Offset.zero & size;

  static SizingRect fullFrom(Offset origin) => (size) => origin & size;
}

extension FSizingOffset on SizingOffset {
  static SizingOffset of(Offset value) => (_) => value;

  static Offset zero(Size size) => Offset.zero;

  static Offset topLeft(Size size) => size.topLeft(Offset.zero);

  static Offset topCenter(Size size) => size.topCenter(Offset.zero);

  static Offset topRight(Size size) => size.topRight(Offset.zero);

  static Offset centerLeft(Size size) => size.centerLeft(Offset.zero);

  static Offset center(Size size) => size.center(Offset.zero);

  static Offset centerRight(Size size) => size.centerRight(Offset.zero);

  static Offset bottomLeft(Size size) => size.bottomLeft(Offset.zero);

  static Offset bottomCenter(Size size) => size.bottomCenter(Offset.zero);

  static Offset bottomRight(Size size) => size.bottomRight(Offset.zero);
}

extension FSizingPaintFromCanvas on SizingPaintFromCanvas {
  static SizingPaintFromCanvas of(Paint paint) => (_, __) => paint;

  static Paint whiteFill(Canvas canvas, Size size) => VPaintFill.white;

  static Paint redFill(Canvas canvas, Size size) => VPaintFill.red;
}

extension FRectBuilder on RectBuilder {
  static RectBuilder get zero => (context) => Rect.zero;

  ///
  /// rect
  ///
  static RectBuilder get rectZeroToFull =>
          (context) => Offset.zero & context.mediaSize;

  static RectBuilder rectZeroToSize(Sizing sizing) =>
          (context) => Offset.zero & sizing(context.mediaSize);

  static RectBuilder rectOffsetToSize(
      SizingOffset positioning,
      Sizing sizing,
      ) =>
          (context) {
        final size = context.mediaSize;
        return positioning(size) & sizing(size);
      };

  ///
  /// circle
  ///
  static RectBuilder get circleZeroToFull => (context) =>
      RectExtension.fromCircle(Offset.zero, context.mediaSize.diagonal);

  static RectBuilder circleZeroToRadius(SizingDouble sizing) =>
          (context) => RectExtension.fromCircle(
        Offset.zero,
        sizing(context.mediaSize),
      );

  static RectBuilder circleOffsetToSize(
      SizingOffset positioning,
      SizingDouble sizing,
      ) =>
          (context) {
        final size = context.mediaSize;
        return RectExtension.fromCircle(positioning(size), sizing(size));
      };

  ///
  /// oval
  ///
  static RectBuilder get ovalZeroToFull =>
          (context) => RectExtension.fromCenterSize(Offset.zero, context.mediaSize);

  static RectBuilder ovalZeroToSize(Sizing sizing) =>
          (context) => RectExtension.fromCenterSize(
        Offset.zero,
        sizing(context.mediaSize),
      );

  static RectBuilder ovalOffsetToSize(
      SizingOffset positioning,
      Sizing sizing,
      ) =>
          (context) {
        final size = context.mediaSize;
        return RectExtension.fromCenterSize(positioning(size), sizing(size));
      };
}



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
