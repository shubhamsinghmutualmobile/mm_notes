import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mm_notes/screens/landing_screen/landing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.top]);

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.lime, fontFamily: 'ProductSans'),
      home: const LandingScreen(),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'ProductSans',
          primaryColor: Colors.blueAccent,
          scaffoldBackgroundColor: Colors.white12,
          backgroundColor: Colors.white12,
          cardColor: const Color(0xff1e1e1e),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              elevation: 4, backgroundColor: Colors.blueAccent)),
    );
  }
}
