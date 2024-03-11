import 'dart:ui';

import 'package:example/enum/widget_type.dart';

class WidgetDescription {
  final WidgetType type;
  final Offset position;
  final Size size;

  WidgetDescription({
    required this.type,
    required this.position,
    required this.size,
  });

  @override
  String toString() {
    return '$type @ (${position.dx}, ${position.dy}) with size $size';
  }
}
