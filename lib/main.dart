import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mm_notes/screens/landing_screen/landing_screen.dart';
import 'package:mm_notes/utils/color_utils.dart';

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
      theme: ThemeData(
        fontFamily: 'ProductSans',
        primaryColor: const Color(0xff9EC3F9),
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: const Color(0xffececf4),
        cardColor: Colors.transparent,
        secondaryHeaderColor: const Color(0xffececf4),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            elevation: 4, backgroundColor: Color(0xffececf4)),
        primaryIconTheme: const IconThemeData(color: Color(0xffFFBA00)),
      ),
      home: const LandingScreen(),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'ProductSans',
          primaryColor: const Color(0xff9EC3F9),
          scaffoldBackgroundColor: Colors.white12,
          backgroundColor: Colors.white12,
          cardColor: const Color(0xff2D2F33),
          secondaryHeaderColor: const Color(0xff2D2F33),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              elevation: 4, backgroundColor: Color(0xff2D2F33)),
          primaryIconTheme:
              IconThemeData(color: Colors.white.withOpacity(0.85))),
      themeMode: getCurrentDeviceThemeMode(),
    );
  }
}
