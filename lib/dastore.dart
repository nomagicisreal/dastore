library dastore;

import 'dart:async';
import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' show Vector3;

part 'util.dart';
part 'algorithm/collection.dart';
part 'algorithm/combination.dart';
part 'concurrent/concurrent.dart';
part 'element/mix.dart';
part 'element/setup.dart';
part 'geometry/geometry.dart';
part 'geometry/canvas.dart';
part 'value/constant.dart';
part 'value/extension.dart';
part 'value/function.dart';
part 'value/widget.dart';
// part 'algorithm/algorithm.dart';
// part 'algorithm/algorithm_tempt.dart';


///
///
/// some static methods implementation should be directly used in production mode,
/// instead of invoking these extension by passing arguments into function
///
///

