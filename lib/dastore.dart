library dastore;

import 'dart:math' as math;
import 'dart:ui';

import 'package:damath/damath.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

part 'extension/constant.dart';
part 'extension/others.dart';
part 'extension/space.dart';
part 'extension/widget.dart';
part 'extension/widget_kit.dart';
part 'extension/widget_mix.dart';

///
///
///
///
/// [Extruding2D]
///
/// [WidgetParentBuilder]
/// [WidgetListBuilder]
/// [WidgetGlobalKeysBuilder]
///
/// [TextFormFieldValidator]
///
///
///

typedef Extruding2D = Rect Function(double width, double height);

typedef WidgetParentBuilder = Widget Function(
  BuildContext context,
  List<Widget> children,
);

typedef WidgetListBuilder = List<Widget> Function(BuildContext context);

typedef WidgetGlobalKeysBuilder<S extends State<StatefulWidget>> = Widget
    Function(
  BuildContext context,
  Map<String, GlobalKey<S>> keys,
);

typedef TextFormFieldValidator = FormFieldValidator<String> Function(
  String failedMessage,
);
