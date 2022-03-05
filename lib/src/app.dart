import 'dart:async';

import 'package:chotot_app/src/pages/authentication/login/login_page.dart';
import 'package:chotot_app/src/pages/splash/flash_page.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class AppChoTot extends StatefulWidget {
  const AppChoTot({Key? key}) : super(key: key);

  @override
  _AppChoTotState createState() => _AppChoTotState();
}

class _AppChoTotState extends State<AppChoTot> {
  Timer? _timer;
  void startTime() async {
    var oneSec = Duration(milliseconds: 3000);

    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (time <= 0) {
            _timer!.cancel();
          } else {
            time--;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  void dispose() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return time > 0 ? SplashScreen() : LoginScreen();
  }
}
