import 'package:final_project/controllers/login_controller.dart';
import 'package:final_project/generated/locales.g.dart';
import 'package:final_project/generated/localization_service.dart';
import 'package:final_project/views/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main(){

  testWidgets('login page test', (WidgetTester tester) async {
    final enterText = find.byType(TextFormField);
    await tester.pumpWidget(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tav Shop',
      locale: Locale('fa'),
      translations: LocalizationService(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Helvetica',
      ),
      home: LoginScreen(),
    ));

    await tester.enterText(enterText, "test");
    expect(find.text("test"), findsOneWidget);

  });
}