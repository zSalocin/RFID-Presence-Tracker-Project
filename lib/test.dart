import 'package:flutter/services.dart';

const platform = MethodChannel('com.yourcompany.app/serial');

typedef void DataCallback(String data);

class SerialListener {
  DataCallback onDataReceived;

  SerialListener({required this.onDataReceived});

  Future<void> startListening() async {
    platform.setMethodCallHandler((call) async {
      if (call.method == 'onDataReceived') {
        final String data = call.arguments;
        onDataReceived(data);
      }
    });

    try {
      await platform.invokeMethod('startSerialListening');
    } on PlatformException catch (e) {
      print('Error: ${e.message}');
    }
  }
}
