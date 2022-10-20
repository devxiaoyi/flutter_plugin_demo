import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:yvrtc_plugin/yvrtc_plugin.dart';

import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:dio/dio.dart';
import 'dart:isolate';

void getRequestFunction() async {
  ///创建Dio对象
  Dio dio = new Dio();

  ///请求地址 获取用户列表
  String url = "http://www.baidu.com";

  ///发起get请求
  Response response = await dio.get(url);
}

int videoReceiverCallback(var message) {
  Uint8List videoFrame = message;
  print('dart videoReceiver ${videoFrame[4]} == ${videoFrame.length}');
  return 0;
}

void main() {
  runApp(const MyApp());

  getRequestFunction();

  // init YVRTC
  var context = fYVPlayInit();
  // init native-api
  var nativeInited = initializeApi(NativeApi.initializeApiDLData);
  assert(nativeInited == 0, 'init api-dl failed.'); //check success or not
  // init ReceivePort
  ReceivePort receivePort = ReceivePort();
  receivePort.listen((message) => videoReceiverCallback(message));
  // register
  registerSendPort(context, receivePort.sendPort.nativePort);
  // start
  String webrtcUrl = "webrtc://192.168.50.152:1988/live/livestream";
  fYVPlayStart(context, webrtcUrl.toNativeUtf8().cast<Int8>());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _yvrtcPlugin = YvrtcPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _yvrtcPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
