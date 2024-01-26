///
///
/// this file contains:
///
/// stateful widget:
/// [WProgressIndicator]
///
/// stateless widget:
/// [WDrawer]
/// [WListView]
/// [WIconMaterial]
/// [WGridPaper]
/// [WSpacer]
/// [WDivider]
///
/// render object widget:
/// [WSizedBox], [WColoredBox]
///
/// function for widget related elements:
/// [WWidgetBuilder]
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
part of dastore;

///
///
///
///
///
/// stateful widget
///
///
///
///
///

extension WProgressIndicator on ProgressIndicator {
  static const circular = CircularProgressIndicator();
  static const circularBlueGrey = CircularProgressIndicator(
    color: Colors.blueGrey,
  );
  static const linear = LinearProgressIndicator();
  static const refresh = RefreshProgressIndicator();
}

///
///
///
///
///
/// stateless widget
///
///
///
///
///
///

extension WDrawer on Drawer {
  static const none = Drawer();
}

extension WListView on ListView {
  static ListView get bigSmall_25 => ListView.builder(
        padding: KEdgeInsets.symV_8,
        itemCount: 25,
        itemBuilder: (context, index) => Container(
          margin: KEdgeInsets.symHV_24_8,
          height: index.isOdd ? 128 : 36,
          decoration: BoxDecoration(
            borderRadius: KBorderRadius.allCircular_1 * 8,
            color: Colors.grey.shade600,
          ),
        ),
      );
}

extension WIconMaterial on Icon {
  static const check = Icon(Icons.check);
  static const close = Icon(Icons.close);

  static const add = Icon(Icons.add);
  static const minus = Icon(Icons.remove);
  static const plus = add;
  static const cross = close;
  static const multiple = cross;
  static const questionMark = Icon(Icons.question_mark);

  static const play = Icon(Icons.play_arrow);
  static const pause = Icon(Icons.pause);
  static const stop = Icon(Icons.stop);
  static const create = Icon(Icons.create);
  static const edit = Icon(Icons.edit);
  static const delete = Icon(Icons.delete);
  static const cancel_24 = Icon(Icons.cancel, size: 24);
  static const cancelSharp = Icon(Icons.cancel_sharp);
  static const send = Icon(Icons.send);

  static const arrowRight = Icon(Icons.arrow_forward_ios);
  static const arrowLeft = Icon(Icons.arrow_back_ios);
  static const arrowRightward = Icon(Icons.arrow_forward);
  static const arrowLeftward = Icon(Icons.arrow_back);
  static const chevronLeft = Icon(Icons.chevron_left);
  static const chevronRight = Icon(Icons.chevron_right);

  static const accountBox = Icon(Icons.account_box);
  static const accountCircle = Icon(Icons.account_circle);
  static const backspace = Icon(Icons.backspace);
  static const email = Icon(Icons.email);
  static const mailOutline = Icon(Icons.mail_outline);
  static const password = Icon(Icons.password);
  static const phone = Icon(Icons.phone);
  static const photo = Icon(Icons.photo);
  static const photo_28 = Icon(Icons.photo, size: 28);
  static const readMore = Icon(Icons.read_more);
  static const calendarToday = Icon(Icons.calendar_today);

  static const accountCircleStyle1 = Icon(
    Icons.account_circle,
    size: 90,
    color: Colors.grey,
  );
  static const accountCircleStyle2 = Icon(
    Icons.account_circle,
    size: 35,
    color: Colors.grey,
  );
}

extension WIconMaterialWhite on Icon {
  static const add = Icon(Icons.add, color: Colors.white);
}

extension WGridPaper on GridPaper {
  static const none = GridPaper();
  static const simple =
      GridPaper(color: Colors.white, interval: 100, subdivisions: 1);

  static const simpleList = <GridPaper>[simple, simple, simple];

  static const simpleListList = <List<GridPaper>>[
    <GridPaper>[simple, simple, simple],
    <GridPaper>[simple, simple, simple]
  ];
}

extension WSpacer on Spacer {
  static const Spacer none = Spacer();
}

extension WDivider on Divider {
  static const white = Divider(color: Colors.white);
  static const black_3 = Divider(thickness: 3);
}

///
///
///
///
/// render object widgets
///
///
///
///

extension WSizedBox on SizedBox {
  static const none = SizedBox();
  static const shrink = SizedBox.shrink();
  static const expand = SizedBox.expand();
  static const expandW = SizedBox(width: double.infinity);
  static const expandH = SizedBox(height: double.infinity);

  // square
  static const square5 = SizedBox.square(dimension: 5);
  static const square10 = SizedBox.square(dimension: 10);
  static const square50 = SizedBox.square(dimension: 50);
  static const square100 = SizedBox.square(dimension: 100);

  // height
  static const h5 = SizedBox(height: 5);
  static const h10 = SizedBox(height: 10);
  static const h16 = SizedBox(height: 16);
  static const h20 = SizedBox(height: 20);
  static const h30 = SizedBox(height: 30);
  static const h32 = SizedBox(height: 32);
  static const h40 = SizedBox(height: 40);
  static const h50 = SizedBox(height: 50);
  static const h60 = SizedBox(height: 60);
  static const h70 = SizedBox(height: 70);
  static const h80 = SizedBox(height: 80);
  static const h90 = SizedBox(height: 90);
  static const h100 = SizedBox(height: 100);
  static const h110 = SizedBox(height: 110);
  static const h120 = SizedBox(height: 120);
  static const h130 = SizedBox(height: 130);
  static const h140 = SizedBox(height: 140);
  static const h150 = SizedBox(height: 150);
  static const h160 = SizedBox(height: 160);
  static const h170 = SizedBox(height: 170);
  static const h180 = SizedBox(height: 180);
  static const h190 = SizedBox(height: 190);
  static const h200 = SizedBox(height: 200);

  // width
  static const w5 = SizedBox(width: 5);
  static const w10 = SizedBox(width: 10);
  static const w16 = SizedBox(width: 16);
  static const w20 = SizedBox(width: 20);
  static const w30 = SizedBox(width: 30);
  static const w32 = SizedBox(width: 32);
  static const w40 = SizedBox(width: 40);
  static const w50 = SizedBox(width: 50);
  static const w60 = SizedBox(width: 60);
  static const w70 = SizedBox(width: 70);
  static const w80 = SizedBox(width: 80);
  static const w90 = SizedBox(width: 90);
  static const w100 = SizedBox(width: 100);
  static const w110 = SizedBox(width: 110);
  static const w120 = SizedBox(width: 120);
  static const w130 = SizedBox(width: 130);
  static const w140 = SizedBox(width: 140);
  static const w150 = SizedBox(width: 150);
  static const w160 = SizedBox(width: 160);
  static const w170 = SizedBox(width: 170);
  static const w180 = SizedBox(width: 180);
  static const w190 = SizedBox(width: 190);
  static const w200 = SizedBox(width: 200);

  // infinite width
  static const infiniteW_100H = SizedBox(height: 100, width: double.infinity);
  static const infiniteW_200H = SizedBox(height: 200, width: double.infinity);
  static const infiniteW_300H = SizedBox(height: 300, width: double.infinity);
  static const infiniteW_400H = SizedBox(height: 400, width: double.infinity);
  static const infiniteW_500H = SizedBox(height: 500, width: double.infinity);
  static const infiniteW_128H = SizedBox(height: 128, width: double.infinity);
  static const infiniteW_256H = SizedBox(height: 256, width: double.infinity);
  static const infiniteW_512H = SizedBox(height: 512, width: double.infinity);

  // infinite height
  static const infiniteH_16W = SizedBox(height: double.infinity, width: 16);
  static const infiniteH_32W = SizedBox(height: double.infinity, width: 32);
  static const infiniteH_64W = SizedBox(height: double.infinity, width: 64);
  static const infiniteH_128W = SizedBox(height: double.infinity, width: 128);

  static SizedBox squareColored({
    required double dimension,
    required Color color,
    Widget? child,
  }) =>
      SizedBox.square(
        dimension: dimension,
        child: ColoredBox(
          color: color,
          child: child,
        ),
      );
}

extension WColoredBox on ColoredBox {
  static const ColoredBox white = ColoredBox(color: Colors.white);
  static const ColoredBox red = ColoredBox(color: Colors.red);
  static const ColoredBox orange = ColoredBox(color: Colors.orange);
  static const ColoredBox yellow = ColoredBox(color: Colors.yellow);
  static const ColoredBox green = ColoredBox(color: Colors.green);
  static const ColoredBox blue = ColoredBox(color: Colors.blue);
  static const ColoredBox blueAccent = ColoredBox(color: Colors.blueAccent);
  static const ColoredBox purple = ColoredBox(color: Colors.purple);
}

///
///
///
///
///
///
/// functions
///
///
///
///
///
///
///

extension WWidgetBuilder on WidgetBuilder {
  static WidgetBuilder of(Widget child) => (_) => child;

  static List<WidgetBuilder> ofList(List<Widget> children) =>
      children.mapToList((child) => (_) => child);

  static Widget none(BuildContext context) => WSizedBox.none;

  static Widget noneAnimation(Animation animation, Widget child) => child;
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
///
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
