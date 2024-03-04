library dastore;

import 'dart:math' as math;

import 'package:damath/damath.dart';
import 'package:damath/damath_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

part 'extension/value.dart';
part 'extension/function.dart';
part 'extension/kit.dart';
part 'extension/mix.dart';

///
///
///
/// [WidgetParentBuilder]
/// [WidgetListBuilder]
/// [WidgetGlobalKeysBuilder]
///
///
///
///


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