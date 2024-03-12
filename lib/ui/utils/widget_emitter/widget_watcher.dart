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
  // with WidgetsBindingObserver{
  final widgetMonitorService = locator<WidgetMonitorService>();
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  /// A set of element IDs that have already been scanned.
  final Set<int> _scannedElementIds = {};

  @override
  void initState() {
    super.initState();
    //  WidgetsBinding.instance.addObserver(this); //Also We have to dispose // Currently Not Used

    ///Persistent frame callbacks cannot be unregistered. Once registered, they are called for every frame for the lifetime of the application.
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
      context.visitChildElements(_recursiveVisitor);

     
    });
    // WidgetDescription widgetFound = WidgetDescription(
    //   type: WidgetType.touchable,
    //   position: Offset.zero,
    //   size: Size.zero,
    // );

    // // TASK: Listen to widgets here (or anywhere besides the UI files) and pass it to the widget monitor service
    // //
    // // NON-NEGOTIABLE IMPLEMENTATION RULES:
    // // 1. Widgets should be added as they appear in the widget tree (tap "get started button to add and remove widgets")
    // // 2. No code to be added in any of the UI files (this code will eventually be used in a package)
    // // 2. The same widget should not be added twice
    // // 3. We want to get the position, size and type of widget
    // // 4. We should detect all tappable widgets, all input/text fields, all scrollable widgets

    // widgetMonitorService.addWidget(widgetFound);
  }

 
  void _recursiveVisitor(Element element) {
    final elementId = identityHashCode(element);
    // Only scan unique elements.
    if (!_scannedElementIds.contains(elementId)) {
      _scannedElementIds.add(elementId);
      final renderObject = element.findRenderObject();
      if (renderObject case RenderBox(hasSize: true)
          when !renderObject.paintBounds.isEmpty) {
        final Offset position = renderObject.localToGlobal(Offset.zero);
        final Size size = renderObject.size;
        // Check the widget type
        WidgetType? type;
        if (element.widget is GestureDetector || element.widget is InkWell) { //TODO: What They Use Under the Hood
          type = WidgetType.touchable;
        } else if (element.widget is ScrollView || //AS most of Scrollable widget use ScrollView under the hood
            element.widget is Scrollable) {
          type = WidgetType.scrollable;
        } else if (element.widget is EditableText) { //as ALL Those TextField , TextFormField and CupertinoTexTField Uses EditableText Widget under the hood
 
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
     
    }
     // Recurse to children
      element.visitChildren(_recursiveVisitor);
  }
}
