import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Accept Permission Test', () {
    late FlutterDriver driver;

    SerializableFinder _getFinderForKey(String key) {
      return find.byValueKey(key);
    }

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect(printCommunication: true);
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      driver.close();
    });

    test('Accept permission should navigate to main View', () async {
      final loginView = _getFinderForKey('login_view');
      final homeViewFinder = _getFinderForKey('home_view');

      await driver.waitFor(loginView);

      await Future.delayed(Duration(seconds: 10));

      await driver.setTextEntryEmulation(enabled: true);

      await Future.delayed(Duration(seconds: 10));
    });
  });
}
