import 'dart:async';
import 'dart:io'; // Import for exit()
import 'dart:ui';
import 'package:EzeePayslip/splash_screen.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure minimum window size (Windows/Mac/Linux)
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    DesktopWindow.setMinWindowSize(const Size(800, 600));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const bool enablePopup = true;

  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: const SplashScreen(),
    );
  }
}

class PopupManager {
  static final PopupManager _instance = PopupManager._internal();
  Timer? _timer;
  final ValueNotifier<bool> _showPopup = ValueNotifier(false);
  final bool _popupEnabled = MyApp.enablePopup;

  static const int ninetyDaysInSeconds = 90 * 24 * 60 * 60; // 90 days in seconds
  static const String _startTimeKey = 'timerStartTime';

  PopupManager._internal();

  factory PopupManager() => _instance;

  Future<void> initialize() async {
    if (!_popupEnabled) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? startTime = prefs.getInt(_startTimeKey);

    if (startTime == null) {
      // First time running the timer
      int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000; // Current time in seconds
      await prefs.setInt(_startTimeKey, currentTime); // Save the start time
      startTimer(ninetyDaysInSeconds); // Start 90-day timer
    } else {
      // Calculate remaining time
      int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      int elapsedTime = currentTime - startTime;
      int remainingSeconds = ninetyDaysInSeconds - elapsedTime;

      if (remainingSeconds > 0) {
        startTimer(remainingSeconds);
      } else {
        _showPopupDialog(); // Timer expired
      }
    }
  }

  void startTimer(int secondsUntilPopup) {
    if (!_popupEnabled || secondsUntilPopup <= 0) return;

    _timer?.cancel();
    int remainingSeconds = secondsUntilPopup; // Local variable to track time

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingSeconds--;

      // Print remaining time every minute
      if (remainingSeconds % 60 == 0 || remainingSeconds < 60) {
        int remainingDays = remainingSeconds ~/ (24 * 60 * 60);
        int remainingHours = (remainingSeconds % (24 * 60 * 60)) ~/ 3600;
        int remainingMinutes = (remainingSeconds % 3600) ~/ 60;
        int remainingSecs = remainingSeconds % 60;
        print(
            'Time until popup: $remainingDays days, $remainingHours hours, $remainingMinutes minutes, $remainingSecs seconds');
      }

      if (remainingSeconds <= 0) {
        timer.cancel();
        _showPopupDialog();
      }
    });

    print("Timer started for ${secondsUntilPopup ~/ (24 * 60 * 60)} days.");
  }

  void _showPopupDialog() async {
    if (!_popupEnabled) {
      print("Popup feature is disabled.");
      return;
    }

    if (!_showPopup.value) {
      _showPopup.value = true;
      print("Showing popup dialog.");

      final navigator = MyApp.navigatorKey.currentState;

      if (navigator == null) {
        print("Error: Navigator key is not available.");
        return;
      }

      // Show the popup dialog with enhanced UI
      showDialog(
        context: navigator.context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Stack(
            children: [
              // Background image
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/windows wallpaer.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Blur effect using BackdropFilter
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  color: Colors.black.withOpacity(0.2), // Optional overlay color
                ),
              ),
              // Dialog box
              Center(
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  backgroundColor: Colors.white.withOpacity(0.9),
                  title: const Text(
                    "App Status",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Your app's trial period has expired.",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 48,
                        color: Colors.orangeAccent,
                      ),
                    ],
                  ),
                  actions: [
                    Center(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          exit(0); // Close the desktop app
                        },
                        child: const Text(
                          textAlign: TextAlign.center,
                          "OK",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    }
  }

  void dispose() {
    _timer?.cancel();
    print("Timer disposed.");
  }
}
