import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Palette.dart';

class SplashScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashScreen());
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bannerColor,
      body: Center(
        child: SizedBox(height: 200, width: 200, child: Image.asset(Assets.giraffeLogo, color: Color(0xffDD5B27), height: 200, width: 200)),
      ),
    );
  }
}
