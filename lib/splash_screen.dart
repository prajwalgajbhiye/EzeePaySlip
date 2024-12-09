import 'dart:async';
import 'package:EzeePayslip/pages/home_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'android_pages/android_home_page.dart'; // Required for defaultTargetPlatform

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  bool _visible = false;
  bool _positioned = false;

  @override
  void initState() {
    super.initState();
    // Start animation after a delay
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _visible = true;
        _positioned = true;
      });
    });
    // Navigate to home page after splash screen
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Platform-specific parameters
    final bool isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final double imageWidth = isAndroid ? 200 : 300;
    final double imageHeight = isAndroid ? 200 : 300;
    final double leftPosition = isAndroid
        ? (MediaQuery.of(context).size.width * 0.3)
        : (MediaQuery.of(context).size.width * 0.4);
    final double topPosition = isAndroid
        ? (MediaQuery.of(context).size.height * 0.35)
        : (MediaQuery.of(context).size.height * 0.20);
    final double textBottomPosition = isAndroid ? 150 : 200;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.grey.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Fading and Moving Image
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              left: _positioned ? leftPosition : 0,
              top: _positioned ? topPosition : 0,
              child: AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: _visible ? 1.0 : 0.0,
                child: Image.asset(
                  'assets/images/splashscreen.png', // Replace with your image asset
                  width: imageWidth,
                  height: imageHeight,
                ),
              ),
            ),
            // Moving Text
            Positioned(
              bottom: textBottomPosition,
              child: isAndroid ?Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(10),
                height: 200,
                width: 300,
                // color: Colors.red,
                child: AnimatedTextKit(

                  animatedTexts: [
                    TyperAnimatedText(
                      textAlign: TextAlign.center,
                      'Create a one-click payment slip for your business',

                      textStyle: const TextStyle(

                        fontFamily: "Oi-Regular.ttf",
                        fontSize: 24,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      speed: const Duration(milliseconds: 30),
                    ),
                  ],
                  totalRepeatCount: 1,
                ),
              ):AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'Create a one-click payment slip for your business',

                    textStyle: const TextStyle(

                      fontFamily: "Oi-Regular.ttf",
                      fontSize: 24,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 30),
                  ),
                ],
                totalRepeatCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
