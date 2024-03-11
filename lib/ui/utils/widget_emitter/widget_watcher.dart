import 'package:example/app/app.locator.dart';
import 'package:example/enum/widget_type.dart';
import 'package:example/models/widget_description.dart';
import 'package:example/services/widget_monitor_service.dart';
import 'package:flutter/material.dart';

class WidgetWatcher extends StatefulWidget {
  final Widget child;
  WidgetWatcher({Key? key, required this.child}) : super(key: key);

  @override
  State<WidgetWatcher> createState() => _WidgetWatcherState();
}

class _WidgetWatcherState extends State<WidgetWatcher> {
  final widgetMonitorService = locator<WidgetMonitorService>();
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    traverseAndMonitorWidgets();
  }

  void traverseAndMonitorWidgets() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      List<WidgetDescription> widgetsFound = [];

      void traverse(Element element) {
        final widget = element.widget;
        final renderObject = element.renderObject;

        if (widget is GestureDetector || widget is InkWell) {
          final position = renderObject?.getTransformTo(null)?.getTranslation();
          final size = renderObject?.semanticBounds.size;
          if (position != null && size != null) {
            widgetsFound.add(WidgetDescription(
              type: WidgetType.touchable,
              position: Offset(position.x, position.y),
              size: Size(size.width, size.height),
            ));
          }
        } else if (widget is SingleChildScrollView ||
            widget is ListView ||
            widget is GridView) {
          final position = renderObject?.getTransformTo(null)?.getTranslation();
          final size = renderObject?.semanticBounds.size;
          if (position != null && size != null) {
            widgetsFound.add(WidgetDescription(
              type: WidgetType.scrollable,
              position: Offset(position.x, position.y),
              size: Size(size.width, size.height),
            ));
          }
        } else if (widget is TextField || widget is Focus) {
          final position = renderObject?.getTransformTo(null)?.getTranslation();
          final size = renderObject?.semanticBounds.size;
          if (position != null && size != null) {
            widgetsFound.add(WidgetDescription(
              type: WidgetType.input,
              position: Offset(position.x, position.y),
              size: Size(size.width, size.height),
            ));
          }
        }

        element.visitChildren(traverse);
      }

      WidgetsBinding.instance?.renderViewElement?.visitChildren(traverse);

      // Add unique widgets found to the widget monitor service
      widgetsFound.toSet().forEach((widget) {
        widgetMonitorService.addWidget(widget);
      });
    });
  }
}
