import 'package:flutter_test/flutter_test.dart';
import 'package:yvrtc_plugin/yvrtc_plugin.dart';
import 'package:yvrtc_plugin/yvrtc_plugin_platform_interface.dart';
import 'package:yvrtc_plugin/yvrtc_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockYvrtcPluginPlatform
    with MockPlatformInterfaceMixin
    implements YvrtcPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final YvrtcPluginPlatform initialPlatform = YvrtcPluginPlatform.instance;

  test('$MethodChannelYvrtcPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelYvrtcPlugin>());
  });

  test('getPlatformVersion', () async {
    YvrtcPlugin yvrtcPlugin = YvrtcPlugin();
    MockYvrtcPluginPlatform fakePlatform = MockYvrtcPluginPlatform();
    YvrtcPluginPlatform.instance = fakePlatform;

    expect(await yvrtcPlugin.getPlatformVersion(), '42');
  });
}
