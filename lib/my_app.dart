import 'package:final_project/views/authentication/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'generated/localization_service.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Store',
      debugShowCheckedModeBanner: false,
      locale: Get.deviceLocale,
      translations: LocalizationService(),
      theme: ThemeData(
        primaryColor: Color(0xffdd4747),
        accentColor: Color(0xfffb3640),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Vazir',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color(0xffdd4747),
            onPrimary: Color(0xfff2edd7),
            padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
            minimumSize: Size(100 , 40),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: Color(0xfff2edd7),
            backgroundColor: Color(0xffdd4747),
            padding: const EdgeInsets.all(8),
          ),
        ),
      ),

      routes: {
        '/splash_screen' : (context) => SplashScreen(),
      },

      initialRoute: '/splash_screen',
    );
  }
}