///
///
/// this file contains:
/// [Curving], [CurveFR], [CurveExtension]
/// [CubicOffset]
///
/// [ColorExtension]
/// [PathExtension]
///
///
/// [SizeExtension], [OffsetExtension], [RectExtension]
/// [AlignmentExtension]
///
///
/// [OperatorMaterialExtension]
/// [ImageExtension]
///
/// [FocusManagerExtension], [FocusNodeExtension]
/// [GlobalKeyExtension]
/// [RenderBoxExtension]
/// [PositionedExtension]
///
/// [BuildContextExtension]
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
part of dastore_flutter;

extension DoubleMaterialExtension on double {
  Radius get toCircularRadius => Radius.circular(this);

  double get clampPositive => clampDouble(this, 0.0, double.infinity);

  double get clampNegative => clampDouble(this, double.negativeInfinity, 0);
}

///
///
///
/// [Curving], [CurveFR], [CurveExtension]
///
///
///

//
class Curving extends Curve {
  final Mapper<double> mapper;

  const Curving(this.mapper);

  Curving.sinPeriodOf(int times)
      : mapper = FMapperDouble.fromPeriod(times.toDouble(), math.sin);

  Curving.cosPeriodOf(int times)
      : mapper = FMapperDouble.fromPeriod(times.toDouble(), math.cos);

  Curving.tanPeriodOf(int times)
      : mapper = FMapperDouble.fromPeriod(times.toDouble(), math.tan);

  @override
  double transformInternal(double t) => mapper(t);
}

///
/// [forward], [reverse]
///
/// [CurveFR.symmetry]
/// [CurveFR.intervalFlip]
///
/// [fusionIntervalFlipIn]
/// [fusionIntervalFlipForSymmetryPeriodSinIn]
///
/// [interval], [flipped]
///
class CurveFR {
  final Curve forward;
  final Curve reverse;

  const CurveFR(this.forward, this.reverse);

  const CurveFR.symmetry(Curve curve)
      : forward = curve,
        reverse = curve;

  CurveFR.intervalFlip(CurveFR curve, double begin, double end)
      : forward = Interval(begin, end, curve: curve.forward),
        reverse = Interval(begin, end, curve: curve.reverse);

  ///
  /// [fusionIntervalFlipIn]
  /// [fusionIntervalFlipForSymmetryPeriodSinIn]
  ///
  static Fusionor<CurveFR, double, double, CurveFR> fusionIntervalFlipIn(
    int steps,
  ) =>
      (curve, begin, end) => CurveFR.intervalFlip(
            curve,
            begin / steps,
            end / steps,
          );

  static Fusionor<int, double, double, CurveFR>
      fusionIntervalFlipForSymmetryPeriodSinIn(
    int steps,
  ) =>
          (times, begin, end) => CurveFR.intervalFlip(
                CurveFR.symmetry(Curving.sinPeriodOf(times)),
                begin / steps,
                end / steps,
              );

  CurveFR interval(double begin, double end) => CurveFR(
        Interval(begin, end, curve: forward),
        Interval(begin, end, curve: reverse),
      );

  CurveFR get flipped => CurveFR(reverse, forward);
}

extension CurveExtension on Curve {
  CurveFR get toCurveFR => CurveFR(this, this);
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
/// [ColorExtension], [PathExtension]
///
///

extension ColorExtension on Color {
  Color plusARGB(int alpha, int red, int green, int blue) => Color.fromARGB(
    this.alpha + alpha,
    this.red + red,
    this.green + green,
    this.blue + blue,
  );

  Color minusARGB(int alpha, int red, int green, int blue) => Color.fromARGB(
    this.alpha - alpha,
    this.red - red,
    this.green - green,
    this.blue - blue,
  );

  Color multiplyARGB(int alpha, int red, int green, int blue) => Color.fromARGB(
    this.alpha * alpha,
    this.red * red,
    this.green * green,
    this.blue * blue,
  );

  Color divideARGB(int alpha, int red, int green, int blue) => Color.fromARGB(
    this.alpha ~/ alpha,
    this.red ~/ red,
    this.green ~/ green,
    this.blue ~/ blue,
  );

  Color plusAllRGB(int value) =>
      Color.fromARGB(alpha, red + value, green + value, blue + value);

  Color minusAllRGB(int value) =>
      Color.fromARGB(alpha, red - value, green - value, blue - value);

  Color multiplyAllRGB(int value) =>
      Color.fromARGB(alpha, red * value, green * value, blue * value);

  Color divideAllRGB(int value) =>
      Color.fromARGB(alpha, red ~/ value, green ~/ value, blue ~/ value);

  Color operateWithValue(Operator operator, int value) => switch (operator) {
    Operator.plus => plusARGB(0, value, value, value),
    Operator.minus => minusARGB(0, value, value, value),
    Operator.multiply => multiplyARGB(1, value, value, value),
    Operator.divide => divideARGB(1, value, value, value),
    Operator.modulus => throw UnimplementedError(),
  };
}

///
///
///
/// path
///
/// [moveToPoint], [lineToPoint], [moveOrLineToPoint]
/// [lineFromAToB], [lineFromAToAll]
/// [arcFromStartToEnd]
///
/// [quadraticBezierToPoint]
/// [quadraticBezierToRelativePoint]
/// [cubicToPoint]
/// [cubicToRelativePoint]
/// [cubic]
///
/// [addOvalFromCircle]
/// [addRectFromPoints]
/// [addRectFromCenter]
/// [addRectFromLTWH]
///
///
extension PathExtension on Path {
  ///
  /// move, line, arc
  ///
  void moveToPoint(Offset point) => moveTo(point.dx, point.dy);

  void lineToPoint(Offset point) => lineTo(point.dx, point.dy);

  void moveOrLineToPoint(Offset point, bool shouldMove) =>
      shouldMove ? moveToPoint(point) : lineTo(point.dx, point.dy);

  void lineFromAToB(Offset a, Offset b) => this
    ..moveToPoint(a)
    ..lineToPoint(b);

  void lineFromAToAll(Offset a, Iterable<Offset> points) => points.fold<Path>(
    this..moveToPoint(a),
        (path, point) => path..lineToPoint(point),
  );

  void arcFromStartToEnd(
      Offset arcStart,
      Offset arcEnd, {
        Radius radius = Radius.zero,
        bool clockwise = true,
        double rotation = 0.0,
        bool largeArc = false,
      }) =>
      this
        ..moveToPoint(arcStart)
        ..arcToPoint(
          arcEnd,
          radius: radius,
          clockwise: clockwise,
          rotation: rotation,
          largeArc: largeArc,
        );

  // see https://www.youtube.com/watch?v=aVwxzDHniEw for explanation of cubic bezier
  void quadraticBezierToPoint(Offset controlPoint, Offset endPoint) =>
      quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        endPoint.dx,
        endPoint.dy,
      );

  void quadraticBezierToRelativePoint(Offset controlPoint, Offset endPoint) =>
      relativeQuadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        endPoint.dx,
        endPoint.dy,
      );

  void cubicToPoint(
      Offset controlPoint1,
      Offset controlPoint2,
      Offset endPoint,
      ) =>
      cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        endPoint.dx,
        endPoint.dy,
      );

  void cubicToRelativePoint(
      Offset controlPoint1,
      Offset controlPoint2,
      Offset endPoint,
      ) =>
      relativeCubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        endPoint.dx,
        endPoint.dy,
      );

  void cubic(CubicOffset offsets) => this
    ..moveToPoint(offsets.a)
    ..cubicToPoint(offsets.b, offsets.c, offsets.d);

  ///
  ///
  ///
  /// shape
  ///
  ///
  ///
  void addOvalFromCircle(Offset center, double radius) =>
      addOval(Rect.fromCircle(center: center, radius: radius));

  void addRectFromPoints(Offset a, Offset b) => addRect(Rect.fromPoints(a, b));

  void addRectFromCenter(Offset center, double width, double height) =>
      addRect(Rect.fromCenter(center: center, width: width, height: height));

  void addRectFromLTWH(double left, double top, double width, double height) =>
      addRect(Rect.fromLTWH(left, top, width, height));
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
    Direction2D() => direction.di(this),
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
        Alignment.center => (0, KRadian.angle_360),
        Alignment.centerLeft => (-KRadian.angle_90, KRadian.angle_90),
        Alignment.centerRight => (KRadian.angle_90, KRadian.angle_270),
        Alignment.topCenter => (0, KRadian.angle_180),
        Alignment.topLeft => (0, KRadian.angle_90),
        Alignment.topRight => (KRadian.angle_90, KRadian.angle_180),
        Alignment.bottomCenter => (KRadian.angle_180, KRadian.angle_360),
        Alignment.bottomLeft => (KRadian.angle_270, KRadian.angle_360),
        Alignment.bottomRight => (KRadian.angle_180, KRadian.angle_270),
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

///
/// operator, image, path
///
extension OperatorMaterialExtension on Operator {
  IconData get iconData => switch (this) {
        Operator.plus => Icons.add,
        Operator.minus => Icons.remove,
        Operator.multiply => CupertinoIcons.multiply,
        Operator.divide => CupertinoIcons.divide,
        Operator.modulus => CupertinoIcons.percent,
      };
}

extension ImageExtension on Image {
  static assetsInDimension(
    String path,
    double dimension, {
    Alignment alignment = Alignment.center,
    FilterQuality filterQuality = FilterQuality.medium,
  }) =>
      Image.asset(
        path,
        height: dimension,
        width: dimension,
        alignment: alignment,
        filterQuality: filterQuality,
      );
}

///
/// focus manager, focus node, global key
///
extension FocusManagerExtension on FocusManager {
  void unFocus() => primaryFocus?.unfocus();
}

extension FocusNodeExtension on FocusNode {
  VoidCallback addFocusChangedListener(VoidCallback listener) =>
      hasFocus ? listener : FListener.none;
}

extension GlobalKeyExtension on GlobalKey {
  RenderBox get renderBox => currentContext?.findRenderObject() as RenderBox;

  Rect get renderRect => renderBox.fromLocalToGlobalRect;

  Offset adjustScaffoldOf(Offset offset) {
    final translation = currentContext
        ?.findRenderObject()
        ?.getTransformTo(null)
        .getTranslation();

    return translation == null
        ? offset
        : Offset(
            offset.dx - translation.x,
            offset.dy - translation.y,
          );
  }
}

extension RenderBoxExtension on RenderBox {
  Rect get fromLocalToGlobalRect =>
      RectExtension.fromOffsetSize(localToGlobal(Offset.zero), size);
}

extension PositionedExtension on Positioned {
  Rect? get rect =>
      (left == null || top == null || width == null || height == null)
          ? null
          : Rect.fromLTWH(left!, top!, width!, height!);
}

///
///
///
/// material
///
///
///
///

///
/// [theme], [themeText], .... , [colorScheme]
/// [mediaSize], [mediaViewInsets]
/// [isKeyboardShowing]
///
/// [renderBox]
/// [scaffold], [scaffoldMessenger]
/// [navigator]
///
/// [closeKeyboardIfShowing]
/// [showSnackbar], [showSnackbarWithMessage]
/// [showDialogGenericStyle1], [showDialogGenericStyle2], [showDialogListAndGetItem], [showDialogDecideTureOfFalse]
///
extension BuildContextExtension on BuildContext {
  // AppLocalizations get loc => AppLocalizations.of(this)!;

  ///
  ///
  ///
  ///
  /// theme
  ///
  ///
  ///
  ///

  ThemeData get theme => Theme.of(this);

  TargetPlatform get platform => theme.platform;

  IconThemeData get themeIcon => theme.iconTheme;

  TextTheme get themeText => theme.textTheme;

  AppBarTheme get themeAppBar => theme.appBarTheme;

  BadgeThemeData get themeBadge => theme.badgeTheme;

  MaterialBannerThemeData get themeBanner => theme.bannerTheme;

  BottomAppBarTheme get themeBottomAppBar => theme.bottomAppBarTheme;

  BottomNavigationBarThemeData get themeBottomNavigationBar =>
      theme.bottomNavigationBarTheme;

  BottomSheetThemeData get themeBottomSheet => theme.bottomSheetTheme;

  ButtonBarThemeData get themeButtonBar => theme.buttonBarTheme;

  ButtonThemeData get themeButton => theme.buttonTheme;

  CardTheme get themeCard => theme.cardTheme;

  CheckboxThemeData get themeCheckbox => theme.checkboxTheme;

  ChipThemeData get themeChip => theme.chipTheme;

  DataTableThemeData get themeDataTable => theme.dataTableTheme;

  DatePickerThemeData get themeDatePicker => theme.datePickerTheme;

  DialogTheme get themeDialog => theme.dialogTheme;

  DividerThemeData get themeDivider => theme.dividerTheme;

  DrawerThemeData get themeDrawer => theme.drawerTheme;

  DropdownMenuThemeData get themeDropdownMenu => theme.dropdownMenuTheme;

  ElevatedButtonThemeData get themeElevatedButton => theme.elevatedButtonTheme;

  ExpansionTileThemeData get themeExpansionTile => theme.expansionTileTheme;

  FilledButtonThemeData get themeFilledButton => theme.filledButtonTheme;

  FloatingActionButtonThemeData get themeFloatingActionButton =>
      theme.floatingActionButtonTheme;

  IconButtonThemeData get themeIconButton => theme.iconButtonTheme;

  ListTileThemeData get themeListTile => theme.listTileTheme;

  MenuBarThemeData get themeMenuBar => theme.menuBarTheme;

  MenuButtonThemeData get themeMenuButton => theme.menuButtonTheme;

  MenuThemeData get themeMenu => theme.menuTheme;

  NavigationBarThemeData get themeNavigationBar => theme.navigationBarTheme;

  NavigationDrawerThemeData get themeNavigationDrawer =>
      theme.navigationDrawerTheme;

  NavigationRailThemeData get themeNavigationRail => theme.navigationRailTheme;

  OutlinedButtonThemeData get themeOutlinedButton => theme.outlinedButtonTheme;

  PopupMenuThemeData get themePopupMenu => theme.popupMenuTheme;

  ProgressIndicatorThemeData get themeProgressIndicator =>
      theme.progressIndicatorTheme;

  RadioThemeData get themeRadio => theme.radioTheme;

  SearchBarThemeData get themeSearchBar => theme.searchBarTheme;

  SearchViewThemeData get themeSearchView => theme.searchViewTheme;

  SegmentedButtonThemeData get themeSegmentedButton =>
      theme.segmentedButtonTheme;

  SliderThemeData get themeSlider => theme.sliderTheme;

  SnackBarThemeData get themeSnackBar => theme.snackBarTheme;

  SwitchThemeData get themeSwitch => theme.switchTheme;

  TabBarTheme get themeTabBar => theme.tabBarTheme;

  TextButtonThemeData get themeTextButton => theme.textButtonTheme;

  TextSelectionThemeData get themeTextSelection => theme.textSelectionTheme;

  TimePickerThemeData get themeTimePicker => theme.timePickerTheme;

  ToggleButtonsThemeData get themeToggleButtons => theme.toggleButtonsTheme;

  TooltipThemeData get themeTooltip => theme.tooltipTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  ///
  ///
  ///
  ///
  /// material
  ///
  ///
  ///
  ///

  Size get mediaSize => MediaQuery.sizeOf(this);

  Size get renderBoxSize => renderBox.size;

  EdgeInsets get mediaViewInsets => MediaQuery.viewInsetsOf(this);

  double get mediaViewInsetsBottom => mediaViewInsets.bottom;

  bool get isKeyboardShowing => mediaViewInsetsBottom > 0;

  RenderBox get renderBox => findRenderObject() as RenderBox;

  ScaffoldState get scaffold => Scaffold.of(this);

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  NavigatorState get navigator => Navigator.of(this);

  DefaultTextStyle get defaultTextStyle => DefaultTextStyle.of(this);

  TextDirection get textDirection => Directionality.of(this);

  TextStyle defaultTextStyleMerge(TextStyle? other) {
    final style = defaultTextStyle.style;
    return style.inherit ? style.merge(other) : style;
  }

  void pop() => Navigator.pop(this);

  void closeKeyboardIfShowing() {
    if (isKeyboardShowing) {
      FocusScopeNode currentFocus = FocusScope.of(this);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }
  }

  ///
  ///
  ///
  /// insert overlay, show snackbar, material banner, dialog
  ///
  ///
  ///

  /// snackbar
  void showSnackbar(SnackBar snackBar) =>
      scaffoldMessenger.showSnackBar(snackBar);

  void showSnackbarWithMessage(
    String? message, {
    bool isCenter = true,
    bool showWhetherMessageIsNull = false,
    Duration duration = KDuration.second1,
    Color? backgroundColor,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {
    if (showWhetherMessageIsNull || message != null) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor ?? theme.cardColor,
          behavior: behavior,
          duration: duration,
          content: isCenter
              ? Center(child: Text(message ?? ''))
              : Text(message ?? ''),
        ),
      );
    }
  }

  /// material banner
  void showMaterialBanner(MaterialBanner banner) =>
      ScaffoldMessenger.of(this).showMaterialBanner(banner);

  void hideMaterialBanner({
    MaterialBannerClosedReason reason = MaterialBannerClosedReason.dismiss,
  }) =>
      ScaffoldMessenger.of(this).hideCurrentMaterialBanner(reason: reason);

  /// dialog
  Future<T?> showDialogGenericStyle1<T>({
    required String title,
    required String content,
    required Supplier<Map<String, T>> optionsBuilder,
  }) {
    final options = optionsBuilder();
    return showDialog(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: options.keys
            .map((optionTitle) => TextButton(
                  onPressed: () => context.navigator.pop(
                    options[optionTitle],
                  ),
                  child: Text(optionTitle),
                ))
            .toList(),
      ),
    );
  }

  Future<T?> showDialogGenericStyle2<T>({
    required String title,
    required String? content,
    required Map<String, T Function()> actionTitleAndActions,
  }) async {
    final actions = <Widget>[];
    T? returnValue;
    actionTitleAndActions.forEach((label, action) {
      actions.add(TextButton(
        onPressed: () {
          navigator.pop();
          returnValue = action();
        },
        child: Text(label),
      ));
    });
    await showDialog(
        context: this,
        builder: (context) => content == null
            ? SimpleDialog(title: Text(title), children: actions)
            : AlertDialog(
                title: Text(title),
                content: Text(content),
                actions: actions,
              ));
    return returnValue;
  }

  void showDialogStyle3(
    String text,
    VoidCallback? onEnsure, {
    Widget? content,
    String messageEnsure = '確認',
  }) {
    showDialog<void>(
      context: this,
      builder: (context) {
        return AlertDialog(
          content: content ?? Text(text),
          actions: [
            if (onEnsure != null)
              TextButton(
                onPressed: onEnsure,
                child: Text(messageEnsure),
              ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('關閉'),
            ),
          ],
        );
      },
    );
  }

  Future<T?> showDialogListAndGetItem<T>({
    required String title,
    required List<T> itemList,
  }) async {
    late final T? selectedItem;
    await showDialog(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          height: 200,
          width: 100,
          child: ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              final item = itemList[index];
              return Center(
                child: TextButton(
                  onPressed: () {
                    selectedItem = item;
                    context.navigator.pop();
                  },
                  child: Text(item.toString()),
                ),
              );
            },
          ),
        ),
      ),
    );
    return selectedItem;
  }

  Future<bool?> showDialogDecideTureOfFalse() async {
    bool? result;
    await showDialog(
        context: this,
        builder: (context) => SimpleDialog(
              children: [
                TextButton(
                  onPressed: () {
                    result = true;
                    context.navigator.pop();
                  },
                  child: WIconMaterial.check,
                ),
                TextButton(
                  onPressed: () {
                    result = false;
                    context.navigator.pop();
                  },
                  child: WIconMaterial.cross,
                ),
              ],
            ));
    return result;
  }
}

///
///
///
/// [IterableOffsetExtension]
/// [ListOffsetExtension]
///
///
///
///

extension IterableOffsetExtension on Iterable<Offset> {
  Iterable<Offset> scaling(double value) => map((o) => o * value);

  Iterable<Offset> adjustCenterFor(
      Size size, {
        Offset origin = Offset.zero,
      }) {
    final center = size.center(origin);
    return map((p) => p + center);
  }

  static Mapper<Iterable<Offset>> scalingMapper(double scale) => scale == 1
      ? FMapperMaterial.ofOffsetIterable
      : (points) => points.scaling(scale);

  static Iterable<Offset> adjustCenterCompanion(
      Iterable<Offset> points,
      Size size,
      ) =>
      points.adjustCenterFor(size);
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
