# Widget Tree Reader

[Bounty hosted by Ticket Stacker](https://ticketstacker.substack.com/)

The price for this bounty is $100 and the requirements are as follows. 

### Requirement

The code to be written will be apart of a pub dev package that will scan the widget tree and emmit details of specific widget types. 

The code is already setup and wrapped with the `widget_watcher.dart` which is the widget where you will scan the widget tree.

Since this code will be apart of the package, you cannot modify the UI to complete this task.

### Technical Overview

In `widget_watcher.dart` is where you'll find the widget that you can use to scan the widget tree.

This widget should traverse the widget tree and add all the widgets that:
1. Are tappable
2. You can input text in
3. You can scroll in

We have a model called `WidgetDescription` which is what needs to be populated

### What Is Allowed

- The use of any package (including testing packages) to traverse the widget tree

### Run the code

1. Run `flutter pub get`
2. Run `flutter run` and make sure you have an emulator/simulator open

### Expected Results

- 7 Widgets are found
- The last 2 should only be found when "Get Started" is tapped