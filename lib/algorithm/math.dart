///
///
/// this file contains:
///
/// [Operator]
///
/// [Direction]
///   [Direction2D]
///     [Direction2DIn4]
///     [Direction2DIn8]
///   [Direction3D]
///     [Direction3DIn6]
///     [Direction3DIn14]
///     [Direction3DIn22]
///
///
/// [Coordinate]
/// [CoordinateRadian]
///
/// [Vector3D]
///
/// [CubicOffset]
///
/// [Curving]
///
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
part of dastore;
// ignore_for_file: constant_identifier_names

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
    Iterable<(Operator, double)> operations,
  ) =>
      operations.fold(
        value,
        (a, opertion) => switch (opertion.$1) {
          Operator.plus => a + opertion.$2,
          Operator.minus => a - opertion.$2,
          Operator.multiply => a * opertion.$2,
          Operator.divide => a / opertion.$2,
          Operator.modulus => a % opertion.$2,
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
/// [Direction], ...
///
/// [Direction3DIn6] and "dart direction" ([Transform], [Matrix4], [Offset] direction) are different.
/// The radian discussion here, follows these rules:
/// - "positive radian" is counterclockwise, going through 0 ~ 2π.
/// - [Direction3DIn6] is user perspective. ([Direction3DIn6.back] is user side, [Direction3DIn6.front] is screen side)
///
/// For example, [Offset.fromDirection] radian 0 ~ 2π going through:
/// [Direction3DIn6.right], [Direction3DIn6.bottom], [Direction3DIn6.left], [Direction3DIn6.top], [Direction3DIn6.right] in sequence;
/// the axis of [Offset.fromDirection] is [Direction3DIn6.front] -> [Direction3DIn6.back],
/// which is not counterclockwise in user perspective ([Direction3DIn6.back] -> [Direction3DIn6.front]).
///
/// See Also:
///   * [KRadian]
///   * [Coordinate.transferToTransformOf], [Coordinate.fromDirection]
///
///
///

///
///
sealed class Direction<D> {
  D get flipped;

  Offset get toOffset;

  Coordinate get toCoordinate;

  static const radian2D_right = 0;
  static const radian2D_bottomRight = KRadian.angle_45;
  static const radian2D_bottom = KRadian.angle_90;
  static const radian2D_bottomLeft = KRadian.angle_135;
  static const radian2D_left = KRadian.angle_180;
  static const radian2D_topLeft = KRadian.angle_225;
  static const radian2D_top = KRadian.angle_270;
  static const radian2D_topRight = KRadian.angle_315;

  static const offset_top = Offset(0, -1);
  static const offset_left = Offset(-1, 0);
  static const offset_right = Offset(1, 0);
  static const offset_bottom = Offset(0, 1);
  static const offset_center = Offset.zero;
  static const offset_topLeft = Offset(-math.sqrt1_2, -math.sqrt1_2);
  static const offset_topRight = Offset(math.sqrt1_2, -math.sqrt1_2);
  static const offset_bottomLeft = Offset(-math.sqrt1_2, math.sqrt1_2);
  static const offset_bottomRight = Offset(math.sqrt1_2, math.sqrt1_2);

  static const coordinate_center = Coordinate.zero;
  static const coordinate_left = Coordinate.ofX(-1);
  static const coordinate_top = Coordinate.ofY(-1);
  static const coordinate_right = Coordinate.ofX(1);
  static const coordinate_bottom = Coordinate.ofY(1);
  static const coordinate_front = Coordinate.ofZ(1);
  static const coordinate_back = Coordinate.ofZ(-1);

  static const coordinate_topLeft = Coordinate.ofXY(-math.sqrt1_2);
  static const coordinate_bottomRight = Coordinate.ofXY(math.sqrt1_2);
  static const coordinate_frontRight = Coordinate.ofXZ(math.sqrt1_2);
  static const coordinate_frontBottom = Coordinate.ofYZ(math.sqrt1_2);
  static const coordinate_backLeft = Coordinate.ofXZ(-math.sqrt1_2);
  static const coordinate_backTop = Coordinate.ofYZ(-math.sqrt1_2);
  static const coordinate_topRight = Coordinate(math.sqrt1_2, -math.sqrt1_2, 0);
  static const coordinate_frontTop = Coordinate(0, -math.sqrt1_2, math.sqrt1_2);
  static const coordinate_bottomLeft =
      Coordinate(-math.sqrt1_2, math.sqrt1_2, 0);
  static const coordinate_frontLeft =
      Coordinate(-math.sqrt1_2, 0, math.sqrt1_2);
  static const coordinate_backRight =
      Coordinate(math.sqrt1_2, 0, -math.sqrt1_2);
  static const coordinate_backBottom =
      Coordinate(0, math.sqrt1_2, -math.sqrt1_2);

  static const coordinate_frontTopLeft = Coordinate(-DoubleExtension.sqrt1_3,
      -DoubleExtension.sqrt1_3, DoubleExtension.sqrt1_3);
  static const coordinate_frontTopRight = Coordinate(DoubleExtension.sqrt1_3,
      -DoubleExtension.sqrt1_3, DoubleExtension.sqrt1_3);
  static const coordinate_frontBottomLeft = Coordinate(-DoubleExtension.sqrt1_3,
      DoubleExtension.sqrt1_3, DoubleExtension.sqrt1_3);
  static const coordinate_frontBottomRight = Coordinate(DoubleExtension.sqrt1_3,
      DoubleExtension.sqrt1_3, DoubleExtension.sqrt1_3);
  static const coordinate_backTopLeft = Coordinate(-DoubleExtension.sqrt1_3,
      -DoubleExtension.sqrt1_3, -DoubleExtension.sqrt1_3);
  static const coordinate_backTopRight = Coordinate(DoubleExtension.sqrt1_3,
      -DoubleExtension.sqrt1_3, -DoubleExtension.sqrt1_3);
  static const coordinate_backBottomLeft = Coordinate(-DoubleExtension.sqrt1_3,
      DoubleExtension.sqrt1_3, -DoubleExtension.sqrt1_3);
  static const coordinate_backBottomRight = Coordinate(DoubleExtension.sqrt1_3,
      DoubleExtension.sqrt1_3, -DoubleExtension.sqrt1_3);
}

sealed class Direction2D<D extends Direction2D<D>> implements Direction<D> {
  Alignment get toAlignment;

  Offset di(Rect rect);
}

enum Direction2DIn4 implements Direction2D<Direction2DIn4> {
  left,
  right,
  top,
  bottom;

  @override
  Direction2DIn4 get flipped => switch (this) {
        Direction2DIn4.left => Direction2DIn4.right,
        Direction2DIn4.right => Direction2DIn4.left,
        Direction2DIn4.top => Direction2DIn4.top,
        Direction2DIn4.bottom => Direction2DIn4.bottom,
      };

  Direction2DIn8 get toDirection8 => switch (this) {
        Direction2DIn4.left => Direction2DIn8.left,
        Direction2DIn4.top => Direction2DIn8.top,
        Direction2DIn4.right => Direction2DIn8.right,
        Direction2DIn4.bottom => Direction2DIn8.bottom,
      };

  @override
  Offset get toOffset => toDirection8.toOffset;

  @override
  Coordinate get toCoordinate => toDirection8.toCoordinate;

  @override
  Alignment get toAlignment => toDirection8.toAlignment;

  @override
  Offset di(Rect rect) => toDirection8.di(rect);
}

enum Direction2DIn8 implements Direction2D<Direction2DIn8> {
  top,
  left,
  right,
  bottom,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight;

  @override
  Direction2DIn8 get flipped => switch (this) {
        top => Direction2DIn8.bottom,
        left => Direction2DIn8.right,
        right => Direction2DIn8.left,
        bottom => Direction2DIn8.top,
        topLeft => Direction2DIn8.bottomRight,
        topRight => Direction2DIn8.bottomLeft,
        bottomLeft => Direction2DIn8.topRight,
        bottomRight => Direction2DIn8.topLeft,
      };

  @override
  Offset get toOffset => switch (this) {
        top => Direction.offset_top,
        left => Direction.offset_left,
        right => Direction.offset_right,
        bottom => Direction.offset_bottom,
        topLeft => Direction.offset_topLeft,
        topRight => Direction.offset_topRight,
        bottomLeft => Direction.offset_bottomLeft,
        bottomRight => Direction.offset_bottomRight,
      };

  @override
  Coordinate get toCoordinate => switch (this) {
        top => Direction.coordinate_top,
        left => Direction.coordinate_left,
        right => Direction.coordinate_right,
        bottom => Direction.coordinate_bottom,
        topLeft => Direction.coordinate_topLeft,
        topRight => Direction.coordinate_topRight,
        bottomLeft => Direction.coordinate_bottomLeft,
        bottomRight => Direction.coordinate_bottomRight,
      };

  @override
  Alignment get toAlignment => switch (this) {
        top => Alignment.topCenter,
        left => Alignment.centerLeft,
        right => Alignment.centerRight,
        bottom => Alignment.bottomCenter,
        topLeft => Alignment.topLeft,
        topRight => Alignment.topRight,
        bottomLeft => Alignment.bottomLeft,
        bottomRight => Alignment.bottomRight,
      };

  @override
  Offset di(Rect rect) => switch (this) {
        Direction2DIn8.top => rect.topCenter,
        Direction2DIn8.left => rect.centerLeft,
        Direction2DIn8.right => rect.centerRight,
        Direction2DIn8.bottom => rect.bottomCenter,
        Direction2DIn8.topLeft => rect.topLeft,
        Direction2DIn8.topRight => rect.topRight,
        Direction2DIn8.bottomLeft => rect.bottomLeft,
        Direction2DIn8.bottomRight => rect.bottomRight,
      };

  bool get isDiagonal => switch (this) {
        Direction2DIn8.left ||
        Direction2DIn8.top ||
        Direction2DIn8.right ||
        Direction2DIn8.bottom =>
          false,
        Direction2DIn8.topLeft ||
        Direction2DIn8.topRight ||
        Direction2DIn8.bottomLeft ||
        Direction2DIn8.bottomRight =>
          true,
      };

  double get scaleOnGrid => isDiagonal ? DoubleExtension.sqrt2 : 1;
}

sealed class Direction3D<D extends Direction3D<D>> implements Direction<D> {}

///
///
///
/// [Direction3DIn6], [Direction3DIn14], [Direction3DIn22]
///
///
///

///
///
enum Direction3DIn6 implements Direction3D<Direction3DIn6> {
  left,
  top,
  right,
  bottom,
  front,
  back;

  @override
  Direction3DIn6 get flipped => switch (this) {
        Direction3DIn6.left => Direction3DIn6.right,
        Direction3DIn6.top => Direction3DIn6.bottom,
        Direction3DIn6.right => Direction3DIn6.left,
        Direction3DIn6.bottom => Direction3DIn6.top,
        Direction3DIn6.front => Direction3DIn6.back,
        Direction3DIn6.back => Direction3DIn6.front,
      };

  @override
  Offset get toOffset => switch (this) {
        Direction3DIn6.left => Direction.offset_left,
        Direction3DIn6.top => Direction.offset_top,
        Direction3DIn6.right => Direction.offset_right,
        Direction3DIn6.bottom => Direction.offset_bottom,
        _ => throw UnimplementedError(),
      };

  @override
  Coordinate get toCoordinate => switch (this) {
        Direction3DIn6.left => Direction.coordinate_left,
        Direction3DIn6.top => Direction.coordinate_top,
        Direction3DIn6.right => Direction.coordinate_right,
        Direction3DIn6.bottom => Direction.coordinate_bottom,
        Direction3DIn6.front => Direction.coordinate_front,
        Direction3DIn6.back => Direction.coordinate_back,
      };

  ///
  /// The angle value belows are "[Matrix4] radian". see [Coordinate.fromDirection] for my "math radian".
  ///
  /// [front] can be seen within {angleY(-90 ~ 90), angleX(-90 ~ 90)}
  /// [left] can be seen within {angleY(0 ~ -180), angleZ(-90 ~ 90)}
  /// [top] can be seen within {angleX(0 ~ 180), angleZ(-90 ~ 90)}
  /// [back] can be seen while [front] not be seen.
  /// [right] can be seen while [left] not be seen.
  /// [bottom] can be seen while [top] not be seen.
  ///
  ///
  static List<Direction3DIn6> parseRotation(Coordinate radian) {
    // ?
    final r = FRadianCoordinate.restrictInAngle180Of(radian);

    final rX = r.dx;
    final rY = r.dy;
    final rZ = r.dz;

    return <Direction3DIn6>[
      FRadian.ifWithinAngle90_90N(rY) && FRadian.ifWithinAngle90_90N(rX)
          ? Direction3DIn6.front
          : Direction3DIn6.back,
      FRadian.ifWithinAngle0_180N(rY) && FRadian.ifWithinAngle90_90N(rZ)
          ? Direction3DIn6.left
          : Direction3DIn6.right,
      FRadian.ifWithinAngle0_180(rX) && FRadian.ifWithinAngle90_90N(rZ)
          ? Direction3DIn6.top
          : Direction3DIn6.bottom,
    ];
  }

  Widget buildTransform({
    Coordinate initialRadian = Coordinate.zero,
    double zDeep = 100,
    required Widget child,
  }) {
    Matrix4 instance() => Matrix4.identity();
    return initialRadian == Coordinate.zero
        ? switch (this) {
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
                transform: instance()..rotateY(KRadian.angle_90),
                child: child,
              ),
            Direction3DIn6.right => Transform(
                alignment: Alignment.centerRight,
                transform: instance()..rotateY(-KRadian.angle_90),
                child: child,
              ),
            Direction3DIn6.top => Transform(
                alignment: Alignment.topCenter,
                transform: instance()..rotateX(-KRadian.angle_90),
                child: child,
              ),
            Direction3DIn6.bottom => Transform(
                alignment: Alignment.bottomCenter,
                transform: instance()..rotateX(KRadian.angle_90),
                child: child,
              ),
          }
        : throw UnimplementedError();
  }
}

enum Direction3DIn14 implements Direction3D<Direction3DIn14> {
  left,
  top,
  right,
  bottom,
  front,
  frontLeft,
  frontTop,
  frontRight,
  frontBottom,
  back,
  backLeft,
  backTop,
  backRight,
  backBottom;

  @override
  Direction3DIn14 get flipped => switch (this) {
        Direction3DIn14.left => Direction3DIn14.right,
        Direction3DIn14.top => Direction3DIn14.bottom,
        Direction3DIn14.right => Direction3DIn14.left,
        Direction3DIn14.bottom => Direction3DIn14.top,
        Direction3DIn14.front => Direction3DIn14.front,
        Direction3DIn14.frontLeft => Direction3DIn14.frontLeft,
        Direction3DIn14.frontTop => Direction3DIn14.frontTop,
        Direction3DIn14.frontRight => Direction3DIn14.frontRight,
        Direction3DIn14.frontBottom => Direction3DIn14.frontBottom,
        Direction3DIn14.back => Direction3DIn14.back,
        Direction3DIn14.backLeft => Direction3DIn14.backLeft,
        Direction3DIn14.backTop => Direction3DIn14.backTop,
        Direction3DIn14.backRight => Direction3DIn14.backRight,
        Direction3DIn14.backBottom => Direction3DIn14.backBottom,
      };

  @override
  Offset get toOffset => switch (this) {
        Direction3DIn14.left => Direction.offset_left,
        Direction3DIn14.top => Direction.offset_top,
        Direction3DIn14.right => Direction.offset_right,
        Direction3DIn14.bottom => Direction.offset_bottom,
        _ => throw UnimplementedError(),
      };

  @override
  Coordinate get toCoordinate => switch (this) {
        Direction3DIn14.left => Direction.coordinate_left,
        Direction3DIn14.top => Direction.coordinate_top,
        Direction3DIn14.right => Direction.coordinate_right,
        Direction3DIn14.bottom => Direction.coordinate_bottom,
        Direction3DIn14.front => Direction.coordinate_front,
        Direction3DIn14.frontLeft => Direction.coordinate_frontLeft,
        Direction3DIn14.frontTop => Direction.coordinate_frontTop,
        Direction3DIn14.frontRight => Direction.coordinate_frontRight,
        Direction3DIn14.frontBottom => Direction.coordinate_frontBottom,
        Direction3DIn14.back => Direction.coordinate_back,
        Direction3DIn14.backLeft => Direction.coordinate_backLeft,
        Direction3DIn14.backTop => Direction.coordinate_backTop,
        Direction3DIn14.backRight => Direction.coordinate_backRight,
        Direction3DIn14.backBottom => Direction.coordinate_backBottom,
      };

  double get scaleOnGrid => switch (this) {
        Direction3DIn14.left ||
        Direction3DIn14.top ||
        Direction3DIn14.right ||
        Direction3DIn14.bottom ||
        Direction3DIn14.front ||
        Direction3DIn14.back =>
          1,
        Direction3DIn14.frontLeft ||
        Direction3DIn14.frontTop ||
        Direction3DIn14.frontRight ||
        Direction3DIn14.frontBottom ||
        Direction3DIn14.backLeft ||
        Direction3DIn14.backTop ||
        Direction3DIn14.backRight ||
        Direction3DIn14.backBottom =>
          DoubleExtension.sqrt2,
      };
}

// enum Direction3DIn22 implements Direction3D<Direction3DIn22>{
//   top;
// }

///
/// [dz]
/// [isNot3D], [isNegative]
/// [hasNegative], [withoutXY]
/// [retainXY], [retainYZAsYX], [retainYZAsXY], [retainXZAsXY], [retainXZAsYX]
/// [roundup], [abs]
/// [distanceSquared], [distance], [volume], [isFinite], [isInfinite], [direction], [direction3D]
/// operators...
/// [scale], [scaleCoordinate], [translate], [rotate], [toString]
/// [Coordinate.cube], [Coordinate.ofX], [Coordinate.ofY], [Coordinate.ofZ]; [Coordinate.ofXY], [Coordinate.ofYZ], [Coordinate.ofXZ]
/// [Coordinate.fromDirection]
///
/// [Coordinate.zero], [Coordinate.one]
/// [maxDistance], [transferToTransformOf],
///
///
class Coordinate extends Offset {
  final double dz;

  bool get isNot3D => (dz == 0 || dx == 0 || dy == 0);

  bool get isNegative => (dz < 0 && dx < 0 && dy < 0);

  bool get hasNegative => (dz < 0 || dx < 0 || dy < 0);

  bool get withoutXY => (dx == 0 && dy == 0);

  Coordinate get retainXY => Coordinate(dx, dy, 0);

  Coordinate get retainYZAsYX => Coordinate(dz, dy, 0);

  Coordinate get retainYZAsXY => Coordinate(dy, dz, 0);

  Coordinate get retainXZAsXY => Coordinate(dx, dz, 0);

  Coordinate get retainXZAsYX => Coordinate(dz, dx, 0);

  Coordinate get roundup => Coordinate(
        dx.roundToDouble(),
        dy.roundToDouble(),
        dz.roundToDouble(),
      );

  Coordinate get abs => Coordinate(dx.abs(), dy.abs(), dz.abs());

  @override
  double get distanceSquared => super.distanceSquared + dz * dz;

  @override
  double get distance => math.sqrt(distanceSquared);

  double get volume => dx * dy * dz;

  @override
  bool get isFinite => super.isFinite && dz.isFinite;

  @override
  bool get isInfinite => super.isInfinite && dz.isInfinite;

  @override
  double get direction => throw UnimplementedError();

  CoordinateRadian get direction3D => throw UnimplementedError();

  @override
  Coordinate operator +(covariant Coordinate other) =>
      Coordinate(dx + other.dx, dy + other.dy, dz + other.dz);

  @override
  Coordinate operator -(covariant Coordinate other) =>
      Coordinate(dx - other.dx, dy - other.dy, dz - other.dz);

  @override
  Coordinate operator -() => Coordinate(-dx, -dy, -dz);

  @override
  Coordinate operator *(double operand) => Coordinate(
        dx * operand,
        dy * operand,
        dz * operand,
      );

  @override
  Coordinate operator /(double operand) => Coordinate(
        dx / operand,
        dy / operand,
        dz / operand,
      );

  @override
  Coordinate operator ~/(double operand) => Coordinate(
        (dx ~/ operand).toDouble(),
        (dy ~/ operand).toDouble(),
        (dz ~/ operand).toDouble(),
      );

  @override
  Coordinate operator %(double operand) => Coordinate(
        dx % operand,
        dy % operand,
        dz % operand,
      );

  @override
  bool operator <(covariant Coordinate other) =>
      dz < other.dz && (super < other);

  @override
  bool operator <=(covariant Coordinate other) =>
      dz <= other.dz && (super <= other);

  @override
  bool operator >(covariant Coordinate other) =>
      dz > other.dz && (super > other);

  @override
  bool operator >=(covariant Coordinate other) =>
      dz >= other.dz && (super >= other);

  @override
  bool operator ==(covariant Coordinate other) =>
      dz == other.dz && (super == other);

  @override
  Rect operator &(Size other) =>
      isNot3D ? (super & other) : throw UnimplementedError();

  @override
  int get hashCode => Object.hash(super.hashCode, dz);

  @override
  Coordinate scale(
    double scaleX,
    double scaleY, {
    double scaleZ = 0,
  }) =>
      Coordinate(dx * scaleX, dy * scaleY, dz * scaleZ);

  Coordinate scaleCoordinate(Coordinate scale) =>
      this.scale(scale.dx, scale.dy, scaleZ: scale.dz);

  @override
  Coordinate translate(
    double translateX,
    double translateY, {
    double translateZ = 0,
  }) =>
      Coordinate(dx + translateX, dy + translateY, dz + translateZ);

  Coordinate rotate(CoordinateRadian direction) =>
      Coordinate.fromDirection(direction3D + direction, distance);

  @override
  String toString() => 'Coordinate('
      '${dx.toStringAsFixed(1)}, '
      '${dy.toStringAsFixed(1)}, '
      '${dz.toStringAsFixed(1)})';

  const Coordinate(super.dx, super.dy, this.dz);

  const Coordinate.cube(double dimension)
      : dz = dimension,
        super(dimension, dimension);

  const Coordinate.ofX(double x)
      : dz = 0,
        super(x, 0);

  const Coordinate.ofY(double y)
      : dz = 0,
        super(0, y);

  const Coordinate.ofZ(double z)
      : dz = z,
        super(0, 0);

  const Coordinate.ofXY(double value)
      : dz = 0,
        super(value, value);

  const Coordinate.ofYZ(double value)
      : dz = value,
        super(0, value);

  const Coordinate.ofXZ(double value)
      : dz = value,
        super(value, 0);

  //
  Coordinate.fromOffset(Offset offset)
      : dz = 0,
        super(offset.dx, offset.dy);

  ///
  /// it implement in 'my coordinate system', not 'dart coordinate system' ([Transform], [Matrix4], [Offset]], ...)
  /// see the comment above [transferToTransformOf] to understand more.
  ///
  factory Coordinate.fromDirection(
    CoordinateRadian direction, [
    double distance = 1,
  ]) {
    final rX = direction.dx;
    final rY = direction.dy;
    final rZ = direction.dz;
    final d = distance * DoubleExtension.sqrt1_3;
    return Coordinate(
      d * (math.cos(rZ) * math.cos(rY)),
      d * (math.sin(rZ) * math.cos(rX)),
      d * (math.sin(rX) * math.sin(rY)),
    );
  }

  static const Coordinate zero = Coordinate.cube(0);
  static const Coordinate one = Coordinate.cube(1);

  static Coordinate maxDistance(Coordinate a, Coordinate b) =>
      a.distance > b.distance ? a : b;

  ///
  ///
  /// [Coordinate.transferToTransformOf] transfer from my coordinate system:
  /// x axis is [Direction3DIn6.left] -> [Direction3DIn6.right], radian start from [Direction3DIn6.back]
  /// y axis is [Direction3DIn6.front] -> [Direction3DIn6.back], radian start from [Direction3DIn6.left]
  /// z axis is [Direction3DIn6.bottom] -> [Direction3DIn6.top], radian start from [Direction3DIn6.right]
  ///
  /// to "dart coordinate system" ([Transform], [Matrix4], [Offset]], ...):
  /// x axis is [Direction3DIn6.left] -> [Direction3DIn6.right], radian start from [Direction3DIn6.back] ?
  /// y axis is [Direction3DIn6.top] -> [Direction3DIn6.bottom], radian start from [Direction3DIn6.left] ?
  /// z axis is [Direction3DIn6.front] -> [Direction3DIn6.back], radian start from [Direction3DIn6.right]
  ///
  ///
  /// See Also:
  ///   * [Offset.fromDirection], [Coordinate.fromDirection]
  ///   * [Direction], [Direction3DIn6]
  ///
  static Coordinate transferToTransformOf(Coordinate p) =>
      Coordinate(p.dx, -p.dz, -p.dy);
}

///
///
///
/// [CoordinateRadian]
///
///
///

///
/// see also [FRadian]
///

///
///
/// [CoordinateRadian.circle], [CoordinateRadian.ofX], [CoordinateRadian.ofY], [CoordinateRadian.ofZ]; [CoordinateRadian.ofXY], [CoordinateRadian.ofYZ], [CoordinateRadian.ofXZ]
/// [modulus90Angle], [modulus180Angle], [modulus360Angle]
/// [zero], [angleX_1], [angleY_1], [angleZ_1]...
///
class CoordinateRadian extends Coordinate {
  const CoordinateRadian(super.dx, super.dy, super.dz);

  const CoordinateRadian.circle(super.dimension) : super.cube();

  const CoordinateRadian.ofX(super.dx) : super.ofX();

  const CoordinateRadian.ofY(super.dy) : super.ofY();

  const CoordinateRadian.ofZ(super.dz) : super.ofZ();

  const CoordinateRadian.ofXY(super.value) : super.ofXY();

  const CoordinateRadian.ofYZ(super.value) : super.ofYZ();

  const CoordinateRadian.ofXZ(super.value) : super.ofXZ();

  @override
  CoordinateRadian operator +(covariant CoordinateRadian other) =>
      CoordinateRadian(dx + other.dx, dy + other.dy, dz + other.dz);

  @override
  CoordinateRadian operator -(covariant CoordinateRadian other) =>
      CoordinateRadian(dx - other.dx, dy - other.dy, dz - other.dz);

  ///
  /// getters
  ///
  CoordinateRadian get modulus90Angle => CoordinateRadian(
        FRadian.modulus90AngleOf(dx),
        FRadian.modulus90AngleOf(dy),
        FRadian.modulus90AngleOf(dz),
      );

  CoordinateRadian get modulus180Angle => CoordinateRadian(
        FRadian.modulus180AngleOf(dx),
        FRadian.modulus180AngleOf(dy),
        FRadian.modulus180AngleOf(dz),
      );

  CoordinateRadian get modulus360Angle => CoordinateRadian(
        FRadian.modulus360AngleOf(dx),
        FRadian.modulus360AngleOf(dy),
        FRadian.modulus360AngleOf(dz),
      );

  Coordinate get toAngle =>
      Coordinate(FRadian.angleOf(dx), FRadian.angleOf(dy), FRadian.angleOf(dz));

  Coordinate get toRound =>
      Coordinate(FRadian.roundOf(dx), FRadian.roundOf(dy), FRadian.roundOf(dz));

  ///
  /// constants
  ///
  static const zero = CoordinateRadian.circle(0);
  static const angleX_360 = CoordinateRadian.ofX(KRadian.angle_360);
  static const angleY_360 = CoordinateRadian.ofY(KRadian.angle_360);
  static const angleZ_360 = CoordinateRadian.ofZ(KRadian.angle_360);
  static const angleXYZ_360 = CoordinateRadian.circle(KRadian.angle_360);
  static const angleXY_360 = CoordinateRadian.ofXY(KRadian.angle_360);
  static const angleX_270 = CoordinateRadian.ofX(KRadian.angle_270);
  static const angleY_270 = CoordinateRadian.ofY(KRadian.angle_270);
  static const angleZ_270 = CoordinateRadian.ofZ(KRadian.angle_270);
  static const angleXYZ_270 = CoordinateRadian.circle(KRadian.angle_270);
  static const angleXY_270 = CoordinateRadian.ofXY(KRadian.angle_270);
  static const angleX_180 = CoordinateRadian.ofX(KRadian.angle_180);
  static const angleY_180 = CoordinateRadian.ofY(KRadian.angle_180);
  static const angleZ_180 = CoordinateRadian.ofZ(KRadian.angle_180);
  static const angleXYZ_180 = CoordinateRadian.circle(KRadian.angle_180);
  static const angleXY_180 = CoordinateRadian.ofXY(KRadian.angle_180);
  static const angleX_120 = CoordinateRadian.ofX(KRadian.angle_120);
  static const angleY_120 = CoordinateRadian.ofY(KRadian.angle_120);
  static const angleZ_120 = CoordinateRadian.ofZ(KRadian.angle_120);
  static const angleZ_150 = CoordinateRadian.ofZ(KRadian.angle_150);
  static const angleXYZ_120 = CoordinateRadian.circle(KRadian.angle_120);
  static const angleXY_120 = CoordinateRadian.ofXY(KRadian.angle_120);
  static const angleX_90 = CoordinateRadian.ofX(KRadian.angle_90);
  static const angleY_90 = CoordinateRadian.ofY(KRadian.angle_90);
  static const angleZ_90 = CoordinateRadian.ofZ(KRadian.angle_90);
  static const angleXYZ_90 = CoordinateRadian.circle(KRadian.angle_90);
  static const angleXY_90 = CoordinateRadian.ofXY(KRadian.angle_90);
  static const angleYZ_90 = CoordinateRadian.ofYZ(KRadian.angle_90);
  static const angleXZ_90 = CoordinateRadian.ofXZ(KRadian.angle_90);
  static const angleX_60 = CoordinateRadian.ofX(KRadian.angle_60);
  static const angleY_60 = CoordinateRadian.ofY(KRadian.angle_60);
  static const angleZ_60 = CoordinateRadian.ofZ(KRadian.angle_60);
  static const angleXYZ_60 = CoordinateRadian.circle(KRadian.angle_60);
  static const angleXY_60 = CoordinateRadian.ofXY(KRadian.angle_60);
  static const angleX_45 = CoordinateRadian.ofX(KRadian.angle_45);
  static const angleY_45 = CoordinateRadian.ofY(KRadian.angle_45);
  static const angleZ_45 = CoordinateRadian.ofZ(KRadian.angle_45);
  static const angleXYZ_45 = CoordinateRadian.circle(KRadian.angle_45);
  static const angleXY_45 = CoordinateRadian.ofXY(KRadian.angle_45);
  static const angleX_30 = CoordinateRadian.ofX(KRadian.angle_30);
  static const angleY_30 = CoordinateRadian.ofY(KRadian.angle_30);
  static const angleZ_30 = CoordinateRadian.ofZ(KRadian.angle_30);
  static const angleXYZ_30 = CoordinateRadian.circle(KRadian.angle_30);
  static const angleXY_30 = CoordinateRadian.ofXY(KRadian.angle_30);
  static const angleX_15 = CoordinateRadian.ofX(KRadian.angle_15);
  static const angleY_15 = CoordinateRadian.ofY(KRadian.angle_15);
  static const angleZ_15 = CoordinateRadian.ofZ(KRadian.angle_15);
  static const angleXYZ_15 = CoordinateRadian.circle(KRadian.angle_15);
  static const angleXY_15 = CoordinateRadian.ofXY(KRadian.angle_15);
  static const angleX_10 = CoordinateRadian.ofX(KRadian.angle_10);
  static const angleY_10 = CoordinateRadian.ofY(KRadian.angle_10);
  static const angleZ_10 = CoordinateRadian.ofZ(KRadian.angle_10);
  static const angleXYZ_10 = CoordinateRadian.circle(KRadian.angle_10);
  static const angleXY_10 = CoordinateRadian.ofXY(KRadian.angle_10);
  static const angleX_1 = CoordinateRadian.ofX(KRadian.angle_1);
  static const angleY_1 = CoordinateRadian.ofY(KRadian.angle_1);
  static const angleZ_1 = CoordinateRadian.ofZ(KRadian.angle_1);
  static const angleXYZ_1 = CoordinateRadian.circle(KRadian.angle_1);
  static const angleXY_1 = CoordinateRadian.ofXY(KRadian.angle_1);
  static const angleX_01 = CoordinateRadian.ofX(KRadian.angle_01);
  static const angleY_01 = CoordinateRadian.ofY(KRadian.angle_01);
  static const angleZ_01 = CoordinateRadian.ofZ(KRadian.angle_01);
  static const angleXYZ_01 = CoordinateRadian.circle(KRadian.angle_01);
  static const angleXY_01 = CoordinateRadian.ofXY(KRadian.angle_01);
}

///
///
///
/// [Vector3D]
///
///
///

//
class Vector3D {
  final CoordinateRadian direction;
  final double distance;

  const Vector3D(this.direction, this.distance);

  Offset get toOffset => Offset.fromDirection(-direction.dy, distance);

  Coordinate get toCoordinate => Coordinate.fromDirection(
        direction,
        distance,
      );

  Vector3D rotated(CoordinateRadian d) => Vector3D(direction + d, distance);

  @override
  String toString() => "Vector($direction, $distance)";

  static Vector3D lerp(Vector3D begin, Vector3D end, double t) => Vector3D(
        Tween(begin: begin.direction, end: end.direction).transform(t),
        Tween(begin: begin.distance, end: end.distance).transform(t),
      );
}

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
/// [Curving]
///
///
///

//
class Curving extends Curve {
  final Mapper<double> mapper;

  const Curving(this.mapper);

  Curving.sinPeriodOf(int times)
      : mapper = FMapperDouble.sinFromPeriod(times.toDouble());

  Curving.cosPeriodOf(int times)
      : mapper = FMapperDouble.cosFromPeriod(times.toDouble());

  @override
  double transformInternal(double t) => mapper(t);
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
