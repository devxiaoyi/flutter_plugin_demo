import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yvrtc_plugin/yvrtc_plugin_method_channel.dart';

void main() {
  MethodChannelYvrtcPlugin platform = MethodChannelYvrtcPlugin();
  const MethodChannel channel = MethodChannel('yvrtc_plugin');

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
    expect(await platform.getPlatformVersion(), '42');
  });
}
