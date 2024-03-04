///
/// this file contains:
///
/// [WWidgetBuilder], [WWidgetParentBuilder]
/// [WImageLoadingBuilder], [WImageErrorWidgetBuilder]
///
/// [FBoxShadow]
/// [FBorderSide], [FBorderBox], [FBorderOutlined], [FBorderInput]
/// [FDecorationBox], [FDecorationShape], [FDecorationInput]
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
///
///
///
///
part of dastore;

//
extension WWidgetBuilder on WidgetBuilder {
  static WidgetBuilder of(Widget child) => (_) => child;

  static List<WidgetBuilder> ofList(List<Widget> children) =>
      children.mapToList((child) => (_) => child);

  static Widget none(BuildContext context) => WSizedBox.none;

  static Widget noneAnimation(Animation animation, Widget child) => child;

  static Widget progressing(BuildContext _) => WProgressIndicator.circular;

  static List<Widget> sandwich({
    Axis direction = Axis.vertical,
    VerticalDirection verticalDirection = VerticalDirection.down,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    Clip clipBehavior = Clip.none,
    TextDirection textDirection = TextDirection.ltr,
    TextBaseline? textBaseline,
    required int breadCount,
    required Generator<Widget> bread,
    required Generator<Widget> meat,
  }) {
    List<Widget> children(int index) => [
      bread(index),
      if (index < breadCount - 1) meat(index),
    ];

    return List<Widget>.generate(
      breadCount,
          (index) => Flex(
        direction: direction,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        clipBehavior: clipBehavior,
        children: children(index),
      ),
    );
  }

  static Mapper<Widget> deviateBuilderOf(Alignment alignment) {
    final x = alignment.x;
    final y = alignment.y;
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
}

extension WWidgetParentBuilder on WidgetParentBuilder {
  WidgetBuilder builderFrom(Iterable<WidgetBuilder> children) =>
          (context) => this(context, [...children.map((build) => build(context))]);
}

extension WImageLoadingBuilder on ImageLoadingBuilder {
  static Widget style1(
      BuildContext context,
      Widget child,
      ImageChunkEvent? loadingProgress,
      ) =>
      loadingProgress == null
          ? child
          : Center(
        child: CircularProgressIndicator(
          color: Colors.blueGrey,
          value: loadingProgress.expectedTotalBytes != null &&
              loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
              loadingProgress.expectedTotalBytes!
              : null,
        ),
      );

  static Widget style2(
      BuildContext context,
      Widget child,
      ImageChunkEvent? loadingProgress,
      ) =>
      loadingProgress == null
          ? child
          : SizedBox(
        width: 90,
        height: 90,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.grey,
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
                : null,
          ),
        ),
      );

  static Widget style3(
      BuildContext ctx,
      Widget child,
      ImageChunkEvent? loadingProgress,
      ) =>
      loadingProgress == null
          ? child
          : Center(
        child: CircularProgressIndicator(
          color: Colors.blueGrey,
          value: loadingProgress.expectedTotalBytes != null &&
              loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
              loadingProgress.expectedTotalBytes!
              : null,
        ),
      );

  static Widget style4(
      BuildContext context,
      Widget child,
      ImageChunkEvent? loadingProgress,
      ) =>
      loadingProgress == null
          ? child
          : SizedBox(
        width: 200,
        height: 200,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.brown,
            value: loadingProgress.expectedTotalBytes != null &&
                loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
                : null,
          ),
        ),
      );
}

extension WImageErrorWidgetBuilder on ImageErrorWidgetBuilder {
  static Widget accountStyle2(BuildContext c, Object o, StackTrace? s) =>
      WIconMaterial.accountCircleStyle2;

  static Widget errorStyle1(BuildContext c, Object o, StackTrace? s) =>
      const SizedBox(height: 200, width: 200, child: Icon(Icons.error));
}

///
///
/// [FBoxShadow]
///   [FBoxShadow.blurNormal]
///   [FBoxShadow.blurSolid]
///   [FBoxShadow.blurOuter]
///   [FBoxShadow.blurInner]
///
///
extension FBoxShadow on BoxShadow {
  static BoxShadow blurNormal({
    Color color = Colors.white,
    Offset offset = Offset.zero,
    double spreadRadius = 0.0,
    double blurRadius = 0.0,
  }) =>
      BoxShadow(
        color: color,
        offset: offset,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        blurStyle: BlurStyle.normal,
      );

  static BoxShadow blurSolid({
    Color color = Colors.white,
    Offset offset = Offset.zero,
    double spreadRadius = 0.0,
    double blurRadius = 0.0,
  }) =>
      BoxShadow(
        color: color,
        offset: offset,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        blurStyle: BlurStyle.solid,
      );

  static BoxShadow blurOuter({
    Color color = Colors.white,
    Offset offset = Offset.zero,
    double spreadRadius = 0.0,
    double blurRadius = 0.0,
  }) =>
      BoxShadow(
        color: color,
        offset: offset,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        blurStyle: BlurStyle.outer,
      );

  static BoxShadow blurInner({
    Color color = Colors.white,
    Offset offset = Offset.zero,
    double spreadRadius = 0.0,
    double blurRadius = 0.0,
  }) =>
      BoxShadow(
        color: color,
        offset: offset,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        blurStyle: BlurStyle.inner,
      );
}

///
///
///
///
///
/// [FBorderSide]
///   [FBorderSide.solidInside]
///   [FBorderSide.solidCenter]
///   [FBorderSide.solidOutside]
///
///
/// [FBorderBox]
///   [FBorderBox.sideSolidCenter]
///   [FBorderBox.directionalSideSolidCenter]
///
/// [FBorderOutlined]
///   [FBorderOutlined.star]
///   [FBorderOutlined.linear]
///   [FBorderOutlined.stadium]
///   [FBorderOutlined.beveledRectangle]
///   [FBorderOutlined.roundedRectangle]
///   [FBorderOutlined.continuousRectangle]
///   [FBorderOutlined.circle]
///   [FBorderOutlined.oval]
///
/// [FBorderInput]
///   [FBorderInput.outline]
///   [FBorderInput.outlineSolidInside]
///   [FBorderInput.underline]
///
/// see https://api.flutter.dev/flutter/painting/ShapeBorder-class.html for more detail about [ShapeBorder]
/// [FBorderOutlined.linear] usually used with [ButtonStyle.shape] by invoking [TextButton.styleFrom]
///
///
///
///
///

// border side
extension FBorderSide on BorderSide {
  static BorderSide solidInside({
    Color color = Colors.blueGrey,
    double width = 1.5,
  }) =>
      BorderSide(
        color: color,
        width: width,
        style: BorderStyle.solid,
        strokeAlign: BorderSide.strokeAlignInside,
      );

  static BorderSide solidCenter({
    Color color = Colors.blueGrey,
    double width = 1.5,
  }) =>
      BorderSide(
        color: color,
        width: width,
        style: BorderStyle.solid,
        strokeAlign: BorderSide.strokeAlignCenter,
      );

  static BorderSide solidOutside({
    Color color = Colors.blueGrey,
    double width = 1.5,
  }) =>
      BorderSide(
        color: color,
        width: width,
        style: BorderStyle.solid,
        strokeAlign: BorderSide.strokeAlignOutside,
      );
}

// box border
extension FBorderBox on BoxBorder {
  static Border sideSolidCenter({
    Color color = Colors.blueGrey,
    double width = 1.5,
  }) =>
      Border.fromBorderSide(
        FBorderSide.solidCenter(color: color, width: width),
      );

  static BorderDirectional directionalSideSolidCenter({
    Color color = Colors.blueGrey,
    double width = 1.5,
  }) {
    final side = FBorderSide.solidCenter(color: color, width: width);
    return BorderDirectional(top: side, start: side, end: side, bottom: side);
  }
}

// outlined border
extension FBorderOutlined on OutlinedBorder {
  static StarBorder star({
    BorderSide side = BorderSide.none,
    double points = 5,
    double innerRadiusRatio = 0.4,
    double pointRounding = 0,
    double valleyRounding = 0,
    double rotation = 0,
    double squash = 0,
  }) =>
      StarBorder(
        side: side,
        points: points,
        innerRadiusRatio: innerRadiusRatio,
        pointRounding: pointRounding,
        valleyRounding: valleyRounding,
        rotation: rotation,
        squash: squash,
      );

  static LinearBorder linear({
    BorderSide side = BorderSide.none,
    LinearBorderEdge? start,
    LinearBorderEdge? end,
    LinearBorderEdge? top,
    LinearBorderEdge? bottom,
  }) =>
      LinearBorder(
        side: side,
        start: start,
        end: end,
        top: top,
        bottom: bottom,
      );

  static StadiumBorder stadium([BorderSide side = BorderSide.none]) =>
      StadiumBorder(side: side);

  static BeveledRectangleBorder beveledRectangle({
    BorderSide side = BorderSide.none,
    required BorderRadius borderRadius,
  }) =>
      BeveledRectangleBorder(
        side: side,
        borderRadius: borderRadius,
      );

  static RoundedRectangleBorder roundedRectangle({
    BorderSide side = BorderSide.none,
    required BorderRadius borderRadius,
  }) =>
      RoundedRectangleBorder(
        side: side,
        borderRadius: borderRadius,
      );

  static ContinuousRectangleBorder continuousRectangle({
    BorderSide side = BorderSide.none,
    required BorderRadius borderRadius,
  }) =>
      ContinuousRectangleBorder(side: side, borderRadius: borderRadius);

  static CircleBorder circle({
    BorderSide side = BorderSide.none,
    double eccentricity = 0.0,
  }) =>
      CircleBorder(side: side, eccentricity: eccentricity);

  static CircleBorder oval({
    BorderSide side = BorderSide.none,
    double eccentricity = 1.0,
  }) =>
      OvalBorder(side: side, eccentricity: eccentricity);
}

// input border
extension FBorderInput on InputBorder {
  static OutlineInputBorder outline({
    BorderSide borderSide = const BorderSide(),
    double gapPadding = 4.0,
    required BorderRadius borderRadius,
  }) =>
      OutlineInputBorder(
        borderSide: borderSide,
        borderRadius: borderRadius,
        gapPadding: gapPadding,
      );

  static OutlineInputBorder outlineSolidInside({
    Color color = Colors.blueGrey,
    double width = 1.5,
    double gapPadding = 4.0,
    required BorderRadius borderRadius,
  }) =>
      OutlineInputBorder(
        borderSide: FBorderSide.solidInside(
          color: color,
          width: width,
        ),
        borderRadius: borderRadius,
        gapPadding: gapPadding,
      );

  static UnderlineInputBorder underline({
    BorderSide borderSide = const BorderSide(),
    BorderRadius borderRadius = KBorderRadius.top_4,
  }) =>
      UnderlineInputBorder(
        borderSide: borderSide,
        borderRadius: borderRadius,
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
///
/// [FDecorationBox]
///   [FDecorationBox.rectangle]
///   [FDecorationBox.circle]
///
/// [FDecorationShape]
///   [FDecorationShape.stadiumBorder]
///   [FDecorationShape.outlineInputBorder]
///
/// [FDecorationInput]
///   [FDecorationInput.rowLabelIconText]
///   [FDecorationInput.style1]
///
///
///
///
///
///
///
///

// box decoration
extension FDecorationBox on BoxDecoration {
  static BoxDecoration rectangle(
      {Color? color,
        DecorationImage? image,
        Border? border,
        BorderRadiusGeometry? borderRadius,
        List<BoxShadow>? boxShadow,
        BlendMode? backgroundBlendMode}) =>
      BoxDecoration(
        color: color,
        image: image,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        backgroundBlendMode: backgroundBlendMode,
        shape: BoxShape.rectangle,
      );

  static BoxDecoration circle({
    Color? color,
    DecorationImage? image,
    Border? border,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    BlendMode? backgroundBlendMode,
  }) =>
      BoxDecoration(
        color: color,
        image: image,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        backgroundBlendMode: backgroundBlendMode,
        shape: BoxShape.circle,
      );
}

// shape decoration
extension FDecorationShape on ShapeDecoration {
  static ShapeDecoration stadiumBorder({
    required BorderSide side,
    Color? color,
    DecorationImage? image,
    List<BoxShadow>? shadows,
    Gradient? gradient,
  }) =>
      ShapeDecoration(
        shape: StadiumBorder(side: side),
        color: color,
        image: image,
        gradient: gradient,
        shadows: shadows,
      );

  static ShapeDecoration outlineInputBorder({
    required BorderSide side,
    Color? color,
    DecorationImage? image,
    List<BoxShadow>? shadows,
    Gradient? gradient,
    BorderSide borderSide = const BorderSide(),
    BorderRadius borderRadius = KBorderRadius.allCircular_4,
    double gapPadding = 4.0,
  }) =>
      ShapeDecoration(
        shape: OutlineInputBorder(
          borderSide: borderSide,
          borderRadius: borderRadius,
          gapPadding: gapPadding,
        ),
        color: color,
        image: image,
        gradient: gradient,
        shadows: shadows,
      );
}

// input decoration
extension FDecorationInput on InputDecoration {
  static InputDecoration rowLabelIconText({
    InputBorder? border,
    required Icon icon,
    required Text text,
  }) =>
      InputDecoration(
        alignLabelWithHint: true,
        border: border,
        contentPadding: switch (border) {
          null => EdgeInsets.zero,
          _ => throw UnimplementedError(),
        },
        label: Row(children: [icon, text]),
      );

  static InputDecoration style1({
    required InputBorder enabledBorder,
  }) =>
      InputDecoration(
        labelStyle: TextStyle(color: Colors.blueGrey),
        enabledBorder: enabledBorder,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.5),
          borderRadius: KBorderRadius.allCircular_10,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
          borderRadius: KBorderRadius.allCircular_10,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
          borderRadius: KBorderRadius.allCircular_10,
        ),
      );
}
