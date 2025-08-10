import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'screens/camera_screen.dart';
import 'screens/camera_web_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Ios18CameraApp());
}

class Ios18CameraApp extends StatelessWidget {
  const Ios18CameraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iOS 18 Camera',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        fontFamily: 'SF Pro Display',
        scaffoldBackgroundColor: Colors.black,
      ),
      home: kIsWeb ? const CameraWebScreen() : const CameraScreen(),
    );
  }
}