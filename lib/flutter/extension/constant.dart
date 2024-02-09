///
///
/// this file contains:
/// [KColor], [KColorStyle1]
/// [KTextStyle]
///
/// [KSize], [KSize3Ratio4], [KSize9Ratio16], [KSize16Ratio9]
/// [KOffset], [KOffsetPermutation4], [KMapperCubicPointsPermutation]
///
/// [Coordinate], [CoordinateRadian]
///
/// [KRadius], [KBorderRadius]
/// [KEdgeInsets]
/// [KCurveFR], [KInterval]
///
///
/// [KMaskFilter]
/// [VPaintFill], [VPaintStroke]
///
/// [VThemeData]
/// [VRandomMaterial]
///
/// [FGeneratorRadius], [FGeneratorOffset]
/// [FMapperMaterial], [FMapperMaterialMapCubicOffset]
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
// ignore_for_file: non_constant_identifier_names

part of dastore_flutter;

///
///
///
/// [KColor]
///
///
///

extension KColor on Color {
  static const pureRed = Color(0xFFff0000);
  static const pureRedGreen = Color(0xFFffff00);
  static const pureGreen = Color(0xFF00ff00);
  static const pureGreenBlue = Color(0xFF00ffff);
  static const pureBlue = Color(0xFF0000ff);
  static const pureBlueRed = Color(0xFFff00ff);

  static const burgundy = Color(0xff880d1e);
  static const orange = Color(0xffefa47f);
  static const blue = Color(0xff8d8ce7);
  static const lightGrey = Color(0xffa28a8a);
  static const white = Color(0xfff5f5f5);
  static const grey = Color(0xffaeaeae);
  static const grey2 = Color(0xffE8E8E8);
  static const indyBlue = Color(0xff414361);
  static const spaceCadet = Color(0xff2a2d43);

  static const constant_200 = Color.fromARGB(255, 200, 200, 200);
  static const rice = Color.fromARGB(255, 240, 232, 200);
}

extension KColorStyle1 on Color {
  /// R
  static const redB1 = Color(0xFFffdddd);
  static const redB2 = Color(0xFFeecccc);
  static const redB3 = Color(0xFFdd9999);
  static const redPrimary = Color(0xFFdd7777);
  static const redD3 = Color(0xFFbb4444);
  static const redD2 = Color(0xFFaa1111);
  static const redD1 = Color(0xFF880000);

  /// G
  static const greenB1 = Color(0xFFddffdd);
  static const greenB2 = Color(0xFFcceecc);
  static const greenB3 = Color(0xFFaaddaa);
  static const greenPrimary = Color(0xFF88aa88);
  static const greenD3 = Color(0xFF559955);
  static const greenD2 = Color(0xFF227722);
  static const greenD1 = Color(0xFF005500);

  /// B
  static const blueB1 = Color(0xFFddddff);
  static const blueB2 = Color(0xFFbbbbee);
  static const blueB3 = Color(0xFF8888dd);
  static const bluePrimary = Color(0xFF6666cc);
  static const blueD3 = Color(0xFF4444bb);
  static const blueD2 = Color(0xFF222288);
  static const blueD1 = Color(0xFF111155);

  /// oranges that G over B oranges
  static const orangeB1 = Color(0xFFffeecc);
  static const orangeB2 = Color(0xFFffccaa);
  static const orangeB3 = Color(0xFFeeaa88);
  static const orangePrimary = Color(0xFFcc8866);
  static const orangeD3 = Color(0xFFaa5533);
  static const orangeD2 = Color(0xFF773322);
  static const orangeD1 = Color(0xFF551100);

  /// yellows that R over G
  static const yellowB1 = Color(0xFFffffbb);
  static const yellowB1_1 = Color(0xFFeeeeaa);
  static const yellowB2 = Color(0xFFeedd99);
  static const yellowB3 = Color(0xFFddcc66);
  static const yellowPrimary = Color(0xffccbb22);
  static const yellowD3 = Color(0xFFccbb33);
  static const yellowD2 = Color(0xFFbbaa22);
  static const yellowD1 = Color(0xFF998811);

  /// purples that B over R
  static const purpleB1 = Color(0xFFeeccff);
  static const purpleB2 = Color(0xFFddbbee);
  static const purpleB3 = Color(0xFFaa88dd);
  static const purpleB4 = Color(0xFF9977cc);
  static const purplePrimary = Color(0xff8866cc);
  static const purpleD3 = Color(0xFF8844bb);
  static const purpleD2 = Color(0xFF6622aa);
  static const purpleD1 = Color(0xFF440099);
}

///
///
///
/// [KTextStyle]
///
///
///

extension KTextStyle on TextStyle {
  static const size_10 = TextStyle(fontSize: 10);
  static const size_20 = TextStyle(fontSize: 20);
  static const size_30 = TextStyle(fontSize: 30);
  static const size_40 = TextStyle(fontSize: 40);
  static const size_50 = TextStyle(fontSize: 50);
  static const white = TextStyle(color: Colors.white);
  static const black = TextStyle(color: Colors.black);
  static const black12 = TextStyle(color: Colors.black12);
  static const black26 = TextStyle(color: Colors.black26);
  static const black38 = TextStyle(color: Colors.black38);
  static const black45 = TextStyle(color: Colors.black45);
  static const black54 = TextStyle(color: Colors.black54);
  static const black87 = TextStyle(color: Colors.black87);

  static const white_24 = TextStyle(color: Colors.white, fontSize: 24);
  static const white_28 = TextStyle(color: Colors.white, fontSize: 28);
  static const boldWhite = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const boldBlack = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const boldBlack_30 = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 30,
  );

  static const boldItalicSpaceCadet = TextStyle(
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    color: KColor.spaceCadet,
  );

  static const italicGrey_12 = TextStyle(
    fontStyle: FontStyle.italic,
    color: Colors.grey,
    fontSize: 12,
  );
}

///
///
///
///
/// geometry
///
///
///
///
///

extension KSize on Size {
  static const square_1 = Size.square(1);
  static const square_10 = Size.square(10);
  static const square_20 = Size.square(20);
  static const square_30 = Size.square(30);
  static const square_40 = Size.square(40);
  static const square_50 = Size.square(50);
  static const square_56 = Size.square(56);
  static const square_60 = Size.square(60);
  static const square_70 = Size.square(70);
  static const square_80 = Size.square(80);
  static const square_90 = Size.square(90);
  static const square_100 = Size.square(100);
  static const square_110 = Size.square(110);
  static const square_120 = Size.square(120);
  static const square_130 = Size.square(130);
  static const square_140 = Size.square(140);
  static const square_150 = Size.square(150);
  static const square_160 = Size.square(160);
  static const square_170 = Size.square(170);
  static const square_180 = Size.square(180);
  static const square_190 = Size.square(190);
  static const square_200 = Size.square(200);
  static const square_210 = Size.square(210);
  static const square_220 = Size.square(220);
  static const square_230 = Size.square(230);
  static const square_240 = Size.square(240);
  static const square_250 = Size.square(250);
  static const square_260 = Size.square(260);
  static const square_270 = Size.square(270);
  static const square_280 = Size.square(280);
  static const square_290 = Size.square(290);
  static const square_300 = Size.square(300);

  // in cm
  static const a4 = Size(21.0, 29.7);
  static const a3 = Size(29.7, 42.0);
  static const a2 = Size(42.0, 59.4);
  static const a1 = Size(59.4, 84.1);
}

extension KSize3Ratio4 on Size {
  static const w360_h480 = Size(360, 480);
  static const w420_h560 = Size(420, 560);
  static const w450_h600 = Size(450, 600);
  static const w480_h640 = Size(480, 640);
}

extension KSize9Ratio16 on Size {
  static const w270_h480 = Size(270, 480);
  static const w405_h720 = Size(405, 720);
  static const w450_h800 = Size(450, 800);
}

extension KSize16Ratio9 on Size {
  static const w800_h450 = Size(800, 450);
}

///
///
///
/// offset, coordinate, vector
///
///
///

extension KOffset on Offset {
  static const square_1 = Offset(1, 1);
  static const square_2 = Offset(2, 2);
  static const square_3 = Offset(3, 3);
  static const square_4 = Offset(4, 4);
  static const square_5 = Offset(5, 5);
  static const square_6 = Offset(6, 6);
  static const square_7 = Offset(7, 7);
  static const square_8 = Offset(8, 8);
  static const square_9 = Offset(9, 9);
  static const square_10 = Offset(10, 10);
  static const square_20 = Offset(20, 20);
  static const square_30 = Offset(30, 30);
  static const square_40 = Offset(40, 40);
  static const square_50 = Offset(50, 50);
  static const square_60 = Offset(60, 60);
  static const square_70 = Offset(70, 70);
  static const square_80 = Offset(80, 80);
  static const square_90 = Offset(90, 90);
  static const square_100 = Offset(100, 100);

  // y == 0
  static const x_1 = Offset(1, 0);
  static const x_2 = Offset(2, 0);
  static const x_3 = Offset(3, 0);
  static const x_4 = Offset(4, 0);
  static const x_5 = Offset(5, 0);
  static const x_6 = Offset(6, 0);
  static const x_7 = Offset(7, 0);
  static const x_8 = Offset(8, 0);
  static const x_9 = Offset(9, 0);
  static const x_10 = Offset(10, 0);
  static const x_20 = Offset(20, 0);
  static const x_30 = Offset(30, 0);
  static const x_40 = Offset(40, 0);
  static const x_50 = Offset(50, 0);
  static const x_60 = Offset(60, 0);
  static const x_70 = Offset(70, 0);
  static const x_80 = Offset(80, 0);
  static const x_90 = Offset(90, 0);
  static const x_100 = Offset(100, 0);
  static const x_110 = Offset(110, 0);

  // x == 0
  static const y_1 = Offset(0, 1);
  static const y_2 = Offset(0, 2);
  static const y_3 = Offset(0, 3);
  static const y_4 = Offset(0, 4);
  static const y_5 = Offset(0, 5);
  static const y_6 = Offset(0, 6);
  static const y_7 = Offset(0, 7);
  static const y_8 = Offset(0, 8);
  static const y_9 = Offset(0, 9);
  static const y_10 = Offset(0, 10);
  static const y_20 = Offset(0, 20);
  static const y_30 = Offset(0, 30);
  static const y_40 = Offset(0, 40);
  static const y_50 = Offset(0, 50);
  static const y_60 = Offset(0, 60);
  static const y_70 = Offset(0, 70);
  static const y_80 = Offset(0, 80);
  static const y_90 = Offset(0, 90);
  static const y_100 = Offset(0, 100);
  static const y_200 = Offset(0, 200);

  // x == 1
  static const xy_1_2 = Offset(1, 2);
  static const xy_1_3 = Offset(1, 3);
  static const xy_1_4 = Offset(1, 4);
  static const xy_1_5 = Offset(1, 5);
  static const xy_1_6 = Offset(1, 6);
  static const xy_1_7 = Offset(1, 7);
  static const xy_1_8 = Offset(1, 8);
  static const xy_1_9 = Offset(1, 9);
  static const xy_1_10 = Offset(1, 10);

  // x == 10
  static const xy_10_20 = Offset(10, 20);
  static const xy_10_30 = Offset(10, 30);
  static const xy_10_40 = Offset(10, 40);
  static const xy_10_50 = Offset(10, 50);
  static const xy_10_60 = Offset(10, 60);
  static const xy_10_70 = Offset(10, 70);
  static const xy_10_80 = Offset(10, 80);
  static const xy_10_90 = Offset(10, 90);
  static const xy_10_10N = Offset(10, -10);
  static const xy_10_20N = Offset(10, -20);
  static const xy_10_30N = Offset(10, -30);
  static const xy_10_40N = Offset(10, -40);
  static const xy_10_50N = Offset(10, -50);
  static const xy_10_60N = Offset(10, -60);
  static const xy_10_70N = Offset(10, -70);
  static const xy_10_80N = Offset(10, -80);
  static const xy_10_90N = Offset(10, -90);

  // x == 100
  static const xy_100_10 = Offset(100, 10);
  static const xy_100_20 = Offset(100, 20);
  static const xy_100_30 = Offset(100, 30);
  static const xy_100_40 = Offset(100, 40);
  static const xy_100_50 = Offset(100, 50);
  static const xy_100_60 = Offset(100, 60);
  static const xy_100_70 = Offset(100, 70);
  static const xy_100_80 = Offset(100, 80);
  static const xy_100_90 = Offset(100, 90);
  static const xy_100_10N = Offset(100, -10);
  static const xy_100_20N = Offset(100, -20);
  static const xy_100_30N = Offset(100, -30);
  static const xy_100_40N = Offset(100, -40);
  static const xy_100_50N = Offset(100, -50);
  static const xy_100_60N = Offset(100, -60);
  static const xy_100_70N = Offset(100, -70);
  static const xy_100_80N = Offset(100, -80);
  static const xy_100_90N = Offset(100, -90);
  static const xy_100_100N = Offset(100, -100);
}

extension KOffsetPermutation4 on List<Offset> {
  // 0, 1, 2, 3
  // 1, 2, 3, a (add a, remove a)
  // 2, 3, a, b
  // 3, a, 1, c
  static List<Offset> p0123(List<Offset> list) => list;

  static List<Offset> p1230(List<Offset> list) =>
      list..addFirstAndRemoveFirst();

  static List<Offset> p2301(List<Offset> list) =>
      p1230(list)..addFirstAndRemoveFirst();

  static List<Offset> p3012(List<Offset> list) =>
      p2301(list)..addFirstAndRemoveFirst();

  // a, 2, 3, b (add 1, remove b)
  // 2, 3, 1, a
  // 3, 1, a, c
  // 1, a, 2, d
  static List<Offset> p0231(List<Offset> list) => list
    ..add(list[1])
    ..removeAt(1);

  static List<Offset> p2310(List<Offset> list) =>
      p0231(list)..addFirstAndRemoveFirst();

  static List<Offset> p3102(List<Offset> list) =>
      p2310(list)..addFirstAndRemoveFirst();

  static List<Offset> p1023(List<Offset> list) =>
      p3102(list)..addFirstAndRemoveFirst();

  // 0, 1, 3, 2 (add 2, remove 2)
  // 1, 3, 2, 0
  // 3, 2, 0, 1
  // 2, 0, 1, 3
  static List<Offset> p0132(List<Offset> list) => list
    ..add(list[2])
    ..removeAt(2);

  static List<Offset> p1320(List<Offset> list) =>
      p0132(list)..addFirstAndRemoveFirst();

  static List<Offset> p3201(List<Offset> list) =>
      p1320(list)..addFirstAndRemoveFirst();

  static List<Offset> p2013(List<Offset> list) =>
      p3201(list)..addFirstAndRemoveFirst();

  // 1, 3, 0, 2 (add 02, remove 02)
  // 3, 0, 2, 1
  // 0, 2, 1, 3
  // 2, 1, 3, 0
  static List<Offset> p1302(List<Offset> list) => p1230(list)
    ..add(list[1])
    ..removeAt(1);

  static List<Offset> p3021(List<Offset> list) =>
      p1302(list)..addFirstAndRemoveFirst();

  static List<Offset> p0213(List<Offset> list) =>
      p3021(list)..addFirstAndRemoveFirst();

  static List<Offset> p2130(List<Offset> list) =>
      p0213(list)..addFirstAndRemoveFirst();

  // 0, 3, 1, 2 (add 12, remove 12)
  // 3, 1, 2, 0
  // 1, 2, 0, 3
  // 2, 0, 3, 1
  static List<Offset> p0312(List<Offset> list) => p0231(list)
    ..add(list[1])
    ..removeAt(1);

  static List<Offset> p3120(List<Offset> list) =>
      p0312(list)..addFirstAndRemoveFirst();

  static List<Offset> p1203(List<Offset> list) =>
      p3120(list)..addFirstAndRemoveFirst();

  static List<Offset> p2031(List<Offset> list) =>
      p1203(list)..addFirstAndRemoveFirst();

  // 0, 3, 2, 1 (add 21, remove 21)
  // 3, 2, 1, 0
  // 2, 1, 0, 3
  // 1, 0, 3, 2
  static List<Offset> p0321(List<Offset> list) => p0132(list)
    ..add(list[1])
    ..removeAt(1);

  static List<Offset> p3210(List<Offset> list) =>
      p0321(list)..addFirstAndRemoveFirst();

  static List<Offset> p2103(List<Offset> list) =>
      p3210(list)..addFirstAndRemoveFirst();

  static List<Offset> p1032(List<Offset> list) =>
      p2103(list)..addFirstAndRemoveFirst();
}

extension KMapperCubicPointsPermutation on Mapper<Map<Offset, List<Offset>>> {
  static const Mapper<Map<Offset, List<Offset>>> p0231 = _0231;
  static const Mapper<Map<Offset, List<Offset>>> p1230 = _1230;

  static Map<Offset, List<Offset>> _0231(Map<Offset, List<Offset>> points) =>
      points.map(
        (points, cubicPoints) => MapEntry(
          points,
          KOffsetPermutation4.p0231(cubicPoints),
        ),
      );

  static Map<Offset, List<Offset>> _1230(Map<Offset, List<Offset>> points) =>
      points.map(
        (points, cubicPoints) => MapEntry(
          points,
          KOffsetPermutation4.p1230(cubicPoints),
        ),
      );

  static Mapper<Map<Offset, List<Offset>>> of(Mapper<List<Offset>> mapper) =>
      (points) => points
          .map((points, cubicPoints) => MapEntry(points, mapper(cubicPoints)));
}

///
///
///
///
///
///
/// radius, border radius
///
///
///
///
///
///

extension KRadius on Radius {
  static const circular1 = Radius.circular(1);
  static const circular2 = Radius.circular(2);
  static const circular3 = Radius.circular(3);
  static const circular4 = Radius.circular(4);
  static const circular5 = Radius.circular(5);
  static const circular6 = Radius.circular(6);
  static const circular7 = Radius.circular(7);
  static const circular8 = Radius.circular(8);
  static const circular9 = Radius.circular(9);
  static const circular10 = Radius.circular(10);
  static const circular100 = Radius.circular(100);
}

extension KBorderRadius on BorderRadius {
  static const zero = BorderRadius.all(Radius.zero);
  static const allCircular_1 = BorderRadius.all(KRadius.circular1);
  static const allCircular_2 = BorderRadius.all(KRadius.circular2);
  static const allCircular_3 = BorderRadius.all(KRadius.circular3);
  static const allCircular_4 = BorderRadius.all(KRadius.circular4);
  static const allCircular_5 = BorderRadius.all(KRadius.circular5);
  static const allCircular_6 = BorderRadius.all(KRadius.circular6);
  static const allCircular_7 = BorderRadius.all(KRadius.circular7);
  static const allCircular_8 = BorderRadius.all(KRadius.circular8);
  static const allCircular_9 = BorderRadius.all(KRadius.circular9);
  static const allCircular_10 = BorderRadius.all(KRadius.circular10);
  static const allCircular_100 = BorderRadius.all(KRadius.circular100);
  static const bottom_10 = BorderRadius.vertical(bottom: KRadius.circular10);
  static const top_4 = BorderRadius.vertical(top: Radius.circular(4.0));
}

extension KEdgeInsets on EdgeInsets {
  static const onlyLeft_4 = EdgeInsets.only(left: 4);
  static const onlyLeft_8 = EdgeInsets.only(left: 8);
  static const onlyLeft_10 = EdgeInsets.only(left: 10);
  static const onlyLeft_24 = EdgeInsets.only(left: 24);
  static const onlyLeftTop_10 = EdgeInsets.only(left: 10, top: 10);
  static const onlyTop_4 = EdgeInsets.only(top: 4);
  static const onlyTop_8 = EdgeInsets.only(top: 8);
  static const onlyTop_12 = EdgeInsets.only(top: 12);
  static const onlyTop_16 = EdgeInsets.only(top: 16);
  static const onlyTop_32 = EdgeInsets.only(top: 32);
  static const onlyTop_10 = EdgeInsets.only(top: 10);
  static const onlyTop_20 = EdgeInsets.only(top: 20);
  static const onlyTop_30 = EdgeInsets.only(top: 30);
  static const onlyTop_40 = EdgeInsets.only(top: 40);
  static const onlyTop_50 = EdgeInsets.only(top: 50);
  static const onlyBottom_8 = EdgeInsets.only(bottom: 8);
  static const onlyBottom_16 = EdgeInsets.only(bottom: 16);
  static const onlyBottom_32 = EdgeInsets.only(bottom: 32);
  static const onlyBottom_64 = EdgeInsets.only(bottom: 64);
  static const onlyRight_4 = EdgeInsets.only(right: 4);
  static const onlyRight_8 = EdgeInsets.only(right: 8);
  static const onlyRight_10 = EdgeInsets.only(right: 10);
  static const onlyRightTop_10 = EdgeInsets.only(right: 10, top: 10);

  static const symH_8 = EdgeInsets.symmetric(horizontal: 8);
  static const symH_10 = EdgeInsets.symmetric(horizontal: 10);
  static const symH_12 = EdgeInsets.symmetric(horizontal: 12);
  static const symH_16 = EdgeInsets.symmetric(horizontal: 16);
  static const symH_18 = EdgeInsets.symmetric(horizontal: 18);
  static const symH_20 = EdgeInsets.symmetric(horizontal: 20);
  static const symH_32 = EdgeInsets.symmetric(horizontal: 32);
  static const symH_64 = EdgeInsets.symmetric(horizontal: 64);
  static const symV_8 = EdgeInsets.symmetric(vertical: 8);
  static const symV_16 = EdgeInsets.symmetric(vertical: 16);
  static const symV_32 = EdgeInsets.symmetric(vertical: 32);
  static const symV_10 = EdgeInsets.symmetric(vertical: 10);
  static const symV_20 = EdgeInsets.symmetric(vertical: 20);
  static const symV_30 = EdgeInsets.symmetric(vertical: 30);

  static const symHV_64_32 = EdgeInsets.symmetric(horizontal: 64, vertical: 32);
  static const symHV_32_4 = EdgeInsets.symmetric(horizontal: 32, vertical: 4);
  static const symHV_24_8 = EdgeInsets.symmetric(horizontal: 24, vertical: 8);

  static const all_1 = EdgeInsets.all(1);
  static const all_2 = EdgeInsets.all(2);
  static const all_3 = EdgeInsets.all(3);
  static const all_4 = EdgeInsets.all(4);
  static const all_5 = EdgeInsets.all(5);
  static const all_6 = EdgeInsets.all(6);
  static const all_7 = EdgeInsets.all(7);
  static const all_8 = EdgeInsets.all(8);
  static const all_9 = EdgeInsets.all(9);
  static const all_10 = EdgeInsets.all(10);
  static const all_100 = EdgeInsets.all(100);

  static const ltrb_2_16_2_0 = EdgeInsets.fromLTRB(2, 16, 2, 0);
  static const ltrb_2_0_2_8 = EdgeInsets.fromLTRB(2, 0, 2, 8);
  static const ltrb_4_16_4_0 = EdgeInsets.fromLTRB(4, 16, 4, 0);
  static const ltrb_8_0_8_8 = EdgeInsets.fromLTRB(8, 0, 8, 8);
  static const ltrb_8_0_8_20 = EdgeInsets.fromLTRB(8, 0, 8, 20);
  static const ltrb_8_16_8_0 = EdgeInsets.fromLTRB(8, 16, 8, 0);
  static const ltrb_16_20_16_16 = EdgeInsets.fromLTRB(64, 20, 64, 8);
  static const ltrb_32_20_32_8 = EdgeInsets.fromLTRB(32, 20, 32, 8);
  static const ltrb_64_20_64_8 = EdgeInsets.fromLTRB(64, 20, 64, 8);
  static const ltrb_50_6_0_8 = EdgeInsets.fromLTRB(50, 6, 0, 8);
}

///
///
///
/// curve, interval
///
///
///

extension KCurveFR on CurveFR {
  /// list.length == 43, see https://api.flutter.dev/flutter/animation/Curves-class.html?gclid=CjwKCAiA-bmsBhAGEiwAoaQNmg9ZfimSGJRAty3QNZ0AA32ztq51qPlJfFPBsFc5Iv1n-EgFQtULyxoC8q0QAvD_BwE&gclsrc=aw.ds
  static const List<CurveFR> all = [
    linear,
    decelerate,
    fastLinearToSlowEaseIn,
    fastEaseInToSlowEaseOut,
    ease,
    easeInToLinear,
    linearToEaseOut,
    easeIn,
    easeInSine,
    easeInQuad,
    easeInCubic,
    easeInQuart,
    easeInQuint,
    easeInExpo,
    easeInCirc,
    easeInBack,
    easeOut,
    easeOutSine,
    easeOutQuad,
    easeOutCubic,
    easeOutQuart,
    easeOutQuint,
    easeOutExpo,
    easeOutCirc,
    easeOutBack,
    easeInOut,
    easeInOutSine,
    easeInOutQuad,
    easeInOutCubic,
    easeInOutCubicEmphasized,
    easeInOutQuart,
    easeInOutQuint,
    easeInOutExpo,
    easeInOutCirc,
    easeInOutBack,
    fastOutSlowIn,
    slowMiddle,
    bounceIn,
    bounceOut,
    bounceInOut,
    elasticIn,
    elasticOut,
    elasticInOut,
  ];

  static const linear = CurveFR.symmetry(Curves.linear);
  static const decelerate = CurveFR.symmetry(Curves.decelerate);
  static const fastLinearToSlowEaseIn =
      CurveFR.symmetry(Curves.fastLinearToSlowEaseIn);
  static const fastEaseInToSlowEaseOut =
      CurveFR.symmetry(Curves.fastEaseInToSlowEaseOut);
  static const ease = CurveFR.symmetry(Curves.ease);
  static const easeInToLinear = CurveFR.symmetry(Curves.easeInToLinear);
  static const linearToEaseOut = CurveFR.symmetry(Curves.linearToEaseOut);
  static const easeIn = CurveFR.symmetry(Curves.easeIn);
  static const easeInSine = CurveFR.symmetry(Curves.easeInSine);
  static const easeInQuad = CurveFR.symmetry(Curves.easeInQuad);
  static const easeInCubic = CurveFR.symmetry(Curves.easeInCubic);
  static const easeInQuart = CurveFR.symmetry(Curves.easeInQuart);
  static const easeInQuint = CurveFR.symmetry(Curves.easeInQuint);
  static const easeInExpo = CurveFR.symmetry(Curves.easeInExpo);
  static const easeInCirc = CurveFR.symmetry(Curves.easeInCirc);
  static const easeInBack = CurveFR.symmetry(Curves.easeInBack);
  static const easeOut = CurveFR.symmetry(Curves.easeOut);
  static const easeOutSine = CurveFR.symmetry(Curves.easeOutSine);
  static const easeOutQuad = CurveFR.symmetry(Curves.easeOutQuad);
  static const easeOutCubic = CurveFR.symmetry(Curves.easeOutCubic);
  static const easeOutQuart = CurveFR.symmetry(Curves.easeOutQuart);
  static const easeOutQuint = CurveFR.symmetry(Curves.easeOutQuint);
  static const easeOutExpo = CurveFR.symmetry(Curves.easeOutExpo);
  static const easeOutCirc = CurveFR.symmetry(Curves.easeOutCirc);
  static const easeOutBack = CurveFR.symmetry(Curves.easeOutBack);
  static const easeInOut = CurveFR.symmetry(Curves.easeInOut);
  static const easeInOutSine = CurveFR.symmetry(Curves.easeInOutSine);
  static const easeInOutQuad = CurveFR.symmetry(Curves.easeInOutQuad);
  static const easeInOutCubic = CurveFR.symmetry(Curves.easeInOutCubic);
  static const easeInOutCubicEmphasized =
      CurveFR.symmetry(Curves.easeInOutCubicEmphasized);
  static const easeInOutQuart = CurveFR.symmetry(Curves.easeInOutQuart);
  static const easeInOutQuint = CurveFR.symmetry(Curves.easeInOutQuint);
  static const easeInOutExpo = CurveFR.symmetry(Curves.easeInOutExpo);
  static const easeInOutCirc = CurveFR.symmetry(Curves.easeInOutCirc);
  static const easeInOutBack = CurveFR.symmetry(Curves.easeInOutBack);
  static const fastOutSlowIn = CurveFR.symmetry(Curves.fastOutSlowIn);
  static const slowMiddle = CurveFR.symmetry(Curves.slowMiddle);
  static const bounceIn = CurveFR.symmetry(Curves.bounceIn);
  static const bounceOut = CurveFR.symmetry(Curves.bounceOut);
  static const bounceInOut = CurveFR.symmetry(Curves.bounceInOut);
  static const elasticIn = CurveFR.symmetry(Curves.elasticIn);
  static const elasticOut = CurveFR.symmetry(Curves.elasticOut);
  static const elasticInOut = CurveFR.symmetry(Curves.elasticInOut);

  ///
  /// interval
  ///
  static const easeInOut_00_04 = CurveFR.symmetry(KInterval.easeInOut_00_04);
}

extension KInterval on Interval {
  static const easeInOut_00_04 = Interval(0, 0.4, curve: Curves.easeInOut);
  static const easeInOut_00_05 = Interval(0, 0.5, curve: Curves.easeInOut);
  static const easeOut_00_06 = Interval(0, 0.6, curve: Curves.easeOut);
  static const easeInOut_02_08 = Interval(0.2, 0.8, curve: Curves.easeInOut);
  static const easeInOut_04_10 = Interval(0.4, 1, curve: Curves.easeInOut);
  static const fastOutSlowIn_00_05 =
      Interval(0, 0.5, curve: Curves.fastOutSlowIn);
}

///
///
///
/// mask filter
///
///
///

extension KMaskFilter on Paint {
  /// normal
  static const MaskFilter normal_05 = MaskFilter.blur(BlurStyle.normal, 0.5);
  static const MaskFilter normal_1 = MaskFilter.blur(BlurStyle.normal, 1);
  static const MaskFilter normal_2 = MaskFilter.blur(BlurStyle.normal, 2);
  static const MaskFilter normal_3 = MaskFilter.blur(BlurStyle.normal, 3);
  static const MaskFilter normal_4 = MaskFilter.blur(BlurStyle.normal, 4);
  static const MaskFilter normal_5 = MaskFilter.blur(BlurStyle.normal, 5);
  static const MaskFilter normal_6 = MaskFilter.blur(BlurStyle.normal, 6);
  static const MaskFilter normal_7 = MaskFilter.blur(BlurStyle.normal, 7);
  static const MaskFilter normal_8 = MaskFilter.blur(BlurStyle.normal, 8);
  static const MaskFilter normal_9 = MaskFilter.blur(BlurStyle.normal, 9);
  static const MaskFilter normal_10 = MaskFilter.blur(BlurStyle.normal, 10);

  /// solid
  static const MaskFilter solid_05 = MaskFilter.blur(BlurStyle.solid, 0.5);
}

//
extension VPaintFill on Paint {
  static Paint get _fill => Paint()..style = PaintingStyle.fill;

  ///
  /// blur
  ///
  static Paint get blurNormal_05 => _fill..maskFilter = KMaskFilter.normal_05;

  static Paint get blurNormal_1 => _fill..maskFilter = KMaskFilter.normal_1;

  static Paint get blurNormal_2 => _fill..maskFilter = KMaskFilter.normal_2;

  static Paint get blurNormal_3 => _fill..maskFilter = KMaskFilter.normal_3;

  static Paint get blurNormal_4 => _fill..maskFilter = KMaskFilter.normal_4;

  static Paint get blurNormal_5 => _fill..maskFilter = KMaskFilter.normal_5;
}

//
extension VPaintStroke on Paint {
  static Paint get _stroke => Paint()..style = PaintingStyle.stroke;

  static Paint get capRound => _stroke..strokeCap = StrokeCap.round;

  static Paint get capSquare => _stroke..strokeCap = StrokeCap.square;

  static Paint get capButt => _stroke..strokeCap = StrokeCap.butt;
}

///
///
///
/// theme
///
///
///

extension VThemeData on ThemeData {
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      );

  static ThemeData get style1 {
    const primaryBrown = Color.fromARGB(255, 189, 166, 158);
    const secondaryBrown = Color.fromARGB(255, 109, 92, 90);

    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryBrown,
      primarySwatch: Colors.brown,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBrown,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: primaryBrown,
        selectedItemColor: Colors.black,
        elevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: secondaryBrown,
        elevation: 10,
      ),
      fontFamily: 'Setofont',
      textTheme: const TextTheme(
          // headlineSmall, Medium, Large, 1-6:
          // bodySmall, Medium, Large, 1-3:
          ),
    );
  }

  static ThemeData get style2 => ThemeData(
        primaryColor: KColor.spaceCadet,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(backgroundColor: KColor.spaceCadet),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.blueGrey),
      );
}

///
/// [colorPrimary], ...
/// [fabLocation]
///
extension VRandomMaterial on math.Random {
  ///
  /// material
  ///
  static Color get colorPrimary => Colors.primaries[math.Random().nextInt(18)];

  static Widget coloredSizedBoxSquare(double dimension) => SizedBox.square(
        dimension: dimension,
        child: ColoredBox(color: colorPrimary),
      );

  static final List<FloatingActionButtonLocation> _fabLocations = [
    FloatingActionButtonLocation.startTop,
    FloatingActionButtonLocation.startDocked,
    FloatingActionButtonLocation.startFloat,
    FloatingActionButtonLocation.centerTop,
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
    FloatingActionButtonLocation.endTop,
    FloatingActionButtonLocation.endDocked,
    FloatingActionButtonLocation.endFloat,
    FloatingActionButtonLocation.endContained,
  ];

  static FloatingActionButtonLocation get fabLocation =>
      _fabLocations[math.Random().nextInt(10)];
}

///
///
///
///
///
///

extension FGeneratorRadius on Generator<Radius> {
  static Generator<Radius> fillCircular(double radius) =>
          (_) => Radius.circular(radius);
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


extension FMapperMaterial on Mapper {
  static Offset offset(Offset v) => v;

  static Iterable<Offset> ofOffsetIterable(Iterable<Offset> v) => v;

  static Coordinate ofCoordinate(Coordinate v) => v;

  static Size ofSize(Size v) => v;

  static Curve ofCurve(Curve v) => v;

  static Curve ofCurveFlipped(Curve v) => v.flipped;

  static BoxConstraints ofBoxConstraints(BoxConstraints v) => v;

  static BoxConstraints boxConstraintsLoosen(BoxConstraints constraints) =>
      constraints.loosen();

  static Cubic cubic_0231(Cubic cubic) =>
      Cubic(cubic.a, cubic.c, cubic.d, cubic.b);

  static Cubic cubic_1230(Cubic cubic) =>
      Cubic(cubic.b, cubic.c, cubic.d, cubic.a);
}

extension FMapperMaterialMapCubicOffset on Mapper<Map<Offset, CubicOffset>> {
  static Map<Offset, CubicOffset> aCdB(Map<Offset, CubicOffset> points) =>
      points.map(
            (current, cubics) => MapEntry(
          current,
          cubics.mapXY(FMapperMaterial.cubic_0231),
        ),
      );

  static Mapper<Map<Offset, CubicOffset>> of(Mapper<Cubic> mapper) =>
          (corners) => corners.map(
            (p, cubics) => MapEntry(p, cubics.mapXY(mapper)),
      );
}

///
///
/// [FExtruding2D]
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
