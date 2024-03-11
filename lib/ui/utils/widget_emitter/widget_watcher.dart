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

    WidgetDescription widgetFound = WidgetDescription(
      type: WidgetType.touchable,
      position: Offset.zero,
      size: Size.zero,
    );

    // TASK: Listen to widgets here (or anywhere besides the UI files) and pass it to the widget monitor service
    //
    // NON-NEGOTIABLE IMPLEMENTATION RULES:
    // 1. Widgets should be added as they appear in the widget tree (tap "get started button to add and remove widgets")
    // 2. No code to be added in any of the UI files (this code will eventually be used in a package)
    // 2. The same widget should not be added twice
    // 3. We want to get the position, size and type of widget
    // 4. We should detect all tappable widgets, all input/text fields, all scrollable widgets

    widgetMonitorService.addWidget(widgetFound);
  }
}
