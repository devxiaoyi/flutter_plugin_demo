import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'yvrtc_plugin_method_channel.dart';

abstract class YvrtcPluginPlatform extends PlatformInterface {
  /// Constructs a YvrtcPluginPlatform.
  YvrtcPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static YvrtcPluginPlatform _instance = MethodChannelYvrtcPlugin();

  /// The default instance of [YvrtcPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelYvrtcPlugin].
  static YvrtcPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [YvrtcPluginPlatform] when
  /// they register themselves.
  static set instance(YvrtcPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
