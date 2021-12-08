import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_touch/fake_touch.dart';

void main() {
  const MethodChannel channel = MethodChannel('fake_touch');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FakeTouch.platformVersion, '42');
  });
}
