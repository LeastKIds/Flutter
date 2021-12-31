import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel("abcd");

// 배터리 레벨을 가져옵니다.

  // 배터리 레벨을 가져옵니다.
  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      //iOS
      final arguments = {'name': 'test'};
      try {
        final List aa = await platform.invokeMethod('test');
        print(aa[0]);
        // final int result = await platform.invokeMethod('getBatteryLevel', arguments);
        // batteryLevel = 'Battery level at $result % .';
      } on PlatformException catch (e) {
        batteryLevel = "Failed to get battery level: '${e.message}'.";
      }

    } else{
      //Android
      batteryLevel = 'android';
    }


    // setState(() {
    //   _batteryLevel = batteryLevel;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              child: Text('Get Battery Level'),
              onPressed: _getBatteryLevel,
            ),
            Text(_batteryLevel),
          ],
        ),
      ),
    );
  }
}