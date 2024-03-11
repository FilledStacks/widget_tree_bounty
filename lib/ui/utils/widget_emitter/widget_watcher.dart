import 'package:example/app/app.locator.dart';
import 'package:example/enum/widget_type.dart';
import 'package:example/models/widget_description.dart';
import 'package:example/services/widget_monitor_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class WidgetWatcher extends StatefulWidget {
  final Widget child;

  WidgetWatcher({Key? key, required this.child}) : super(key: key);

  @override
  State<WidgetWatcher> createState() => _WidgetWatcherState();
}

class _WidgetWatcherState extends State<WidgetWatcher> {
  final widgetMonitorService = locator<WidgetMonitorService>();

  /// A set of element IDs that have already been scanned.
  final Set<int> _scannedElementIds = {};

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    _scanWidgetTree();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scanWidgetTree();
  }

  void _scanWidgetTree() {
    // Re-scan the widget tree when the dependencies change.
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.visitChildElements(_recursiveVisitor),
    );
  }

  void _recursiveVisitor(Element element) {
    // Get the element's identity hash code. This is used to determine if the
    // element has already been scanned. The identityHashCode of an object is
    // guaranteed to be unique for each instance of an object for the duration
    // of a Dart program’s execution. Unlike the key, the identity hash code
    // exists always, so it is stable across widget rebuilds.
    final elementId = identityHashCode(element);

    // Only scan unique elements.
    if (!_scannedElementIds.contains(elementId)) {
      _scannedElementIds.add(elementId);

      final renderBox = element.findRenderObject() as RenderBox?;
      if (renderBox != null && renderBox.hasSize) {
        final Offset position = renderBox.localToGlobal(Offset.zero);
        final Size size = renderBox.size;

        // Check the widget type
        WidgetType? type;
        if (element.widget is GestureDetector || element.widget is InkWell) {
          type = WidgetType.touchable;
        } else if (element.widget is ScrollView ||
            element.widget is Scrollable) {
          type = WidgetType.scrollable;
        } else if (element.widget is TextField ||
            element.widget is TextFormField ||
            element.widget is CupertinoTextField) {
          type = WidgetType.input;
        }

        if (type != null) {
          final WidgetDescription widgetFound = WidgetDescription(
            type: type,
            position: position,
            size: size,
          );
          widgetMonitorService.addWidget(widgetFound);
        }
      }

      // Recurse to children
      element.visitChildren(_recursiveVisitor);
    }
  }
}
