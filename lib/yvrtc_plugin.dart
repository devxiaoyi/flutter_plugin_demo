import 'yvrtc_plugin_platform_interface.dart';
import 'dart:ffi';

class YvrtcPlugin {
  Future<String?> getPlatformVersion() {
    return YvrtcPluginPlatform.instance.getPlatformVersion();
  }
}

final DynamicLibrary nativeLib = DynamicLibrary.process();

final int Function(int x, int y) nativeAdd = nativeLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('native_add')
    .asFunction();

final Pointer<Void> Function() fYVPlayInit = nativeLib
    .lookup<NativeFunction<Pointer<Void> Function()>>("YVPlayInit")
    .asFunction();

final int Function(Pointer context, Pointer<Int8> url) fYVPlayStart = nativeLib
    .lookup<NativeFunction<Int32 Function(Pointer, Pointer<Int8>)>>(
        "YVPlayStart")
    .asFunction();

final registerSendPort = nativeLib.lookupFunction<
    Void Function(Pointer context, Int64 sendPort),
    void Function(Pointer context, int sendPort)>('YVRegisterSendPort');

final initializeApi = nativeLib.lookupFunction<IntPtr Function(Pointer<Void>),
    int Function(Pointer<Void>)>("InitDartApiDL");
