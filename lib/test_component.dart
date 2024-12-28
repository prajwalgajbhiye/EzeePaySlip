// import 'dart:async';
// import 'dart:io'; // Import for exit()
// import 'dart:ui';
// import 'package:EzeePayslip/splash_screen.dart';
// import 'package:desktop_window/desktop_window.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   // Ensure minimum window size (Windows/Mac/Linux)
//   if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
//     DesktopWindow.setMinWindowSize(const Size(800, 600));
//   }
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   static const bool enablePopup = true;
//
//   static final GlobalKey<NavigatorState> navigatorKey =
//   GlobalKey<NavigatorState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       navigatorKey: navigatorKey,
//       home: const SplashScreen(),
//     );
//   }
// }
//
// class PopupManager {
//   static final PopupManager _instance = PopupManager._internal();
//   Timer? _timer;
//   final ValueNotifier<bool> _showPopup = ValueNotifier(false);
//   final bool _popupEnabled = MyApp.enablePopup;
//
//   PopupManager._internal();
//
//   factory PopupManager() => _instance;
//
//   void initialize() async {
//     if (!_popupEnabled) return;
//
//     final prefs = await SharedPreferences.getInstance();
//     final int? storedDesiredTime = prefs.getInt('desiredTime');
//     final int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//
//     if (storedDesiredTime == null) {
//       // Set default popup time to 2 hours from now
//       final int newDesiredTime = currentTime + 7200; // 2 hours
//       prefs.setInt('desiredTime', newDesiredTime);
//       startTimer(30);
//     } else if (currentTime >= storedDesiredTime) {
//       _showPopupDialog();
//     } else {
//       startTimer(storedDesiredTime - currentTime);
//     }
//   }
//
//   void startTimer(int secondsUntilPopup) {
//     if (!_popupEnabled || secondsUntilPopup <= 0) return;
//
//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       secondsUntilPopup--;
//
//       print('Time until popup: $secondsUntilPopup seconds');
//
//       if (secondsUntilPopup <= 0) {
//         timer.cancel();
//         _showPopupDialog();
//       }
//     });
//
//     print("Timer started for $secondsUntilPopup seconds.");
//   }
//
//   void _showPopupDialog() async {
//     if (!_popupEnabled) {
//       print("Popup feature is disabled.");
//       return;
//     }
//
//     if (!_showPopup.value) {
//       _showPopup.value = true;
//       print("Showing popup dialog.");
//
//       final navigator = MyApp.navigatorKey.currentState;
//
//       if (navigator == null) {
//         print("Error: Navigator key is not available.");
//         return;
//       }
//
//       // Show the popup dialog with enhanced UI
//       showDialog(
//         context: navigator.context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return Stack(
//             children: [
//               // Background image
//               Container(
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage("assets/images/windows wallpaer.jpg"),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               // Blur effect using BackdropFilter
//               BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//                 child: Container(
//                   color: Colors.black.withOpacity(0.2), // Optional overlay color
//                 ),
//               ),
//               // Dialog box
//               Center(
//                 child: AlertDialog(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20), // Rounded corners
//                   ),
//                   backgroundColor: Colors.white.withOpacity(0.9),
//                   title: const Text(
//                     "App Status",
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blueAccent,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   content: const Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         "Your app is not running.",
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.black87,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 16),
//                       Icon(
//                         Icons.warning_amber_rounded,
//                         size: 48,
//                         color: Colors.orangeAccent,
//                       ),
//                     ],
//                   ),
//                   actions: [
//                     Center(
//                       child: TextButton(
//                         style: TextButton.styleFrom(
//                           backgroundColor: Colors.blueAccent,
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 8),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         onPressed: () async {
//                           final prefs = await SharedPreferences.getInstance();
//
//                           // Set the new desired time (forward the time by 15 hours)
//                           final int newDesiredTime =
//                               DateTime.now().millisecondsSinceEpoch ~/ 1000 + 54000;
//                           prefs.setInt('desiredTime', newDesiredTime);
//
//                           exit(0); // Close the desktop app
//                         },
//                         child: const Text(
//                           textAlign: TextAlign.center,
//                           "OK",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//
//   void dispose() {
//     _timer?.cancel();
//     print("Timer disposed.");
//   }
// }
