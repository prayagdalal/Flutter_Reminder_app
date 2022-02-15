import 'package:flutter/material.dart';
import 'package:reminder_app/core/utils/color_constant.dart';
import 'package:reminder_app/core/utils/image_constant.dart';
import 'package:reminder_app/presentation/home_screen/home_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreenView(
        navigateRoute: HomeScreen(),
        duration: 3000,
        speed: 50,
        imageSize: 130,
        imageSrc: ImageConstant.img_remainder_logo,
        text: "Reminder",
        textType: TextType.NormalText,
        textStyle: TextStyle(
          fontSize: 25.0,
          letterSpacing: 1.0,
          color: ColorConstant.green,
        ),
      ),
    );
  }
}
