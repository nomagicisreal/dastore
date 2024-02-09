import 'dart:core';

import 'package:dastore/dastore.dart';

void main(List<String> arguments) {
  final sinMapper = FMapperDouble.fromPeriod(3);
  for (var i = 0.0  ; i < 1 ; i+=0.01) {
    print(sinMapper(i));
  }
}
