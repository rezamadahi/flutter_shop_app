import 'package:final_project/controllers/login_controller.dart';
import 'package:final_project/generated/locales.g.dart';
import 'package:final_project/generated/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  final _controller = Get.put(LoginController());

  testWidgets(
    "password visibility test",
    (WidgetTester tester) async {
      await tester.pumpWidget(GetMaterialApp(
        title: 'Flutter Store',
        debugShowCheckedModeBanner: false,
        locale: Get.deviceLocale,
        translations: LocalizationService(),
        home: Scaffold(
          body: Obx(() => Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _controller.passController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return LocaleKeys.login_page_empty_password.tr;
                    } else if (value.length < 6) {
                      return LocaleKeys.login_page_password_length.tr;
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(fontSize: 20),
                  obscureText: (!_controller.isPasswordShow.value),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(15),
                    hintText: LocaleKeys.login_page_password.tr,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    suffixIcon: IconButton(
                      icon: (!_controller.isPasswordShow.value)
                          ? Icon(
                        Icons.visibility_off,
                        color: Color(0xff707070),
                      )
                          : Icon(
                        Icons.visibility,
                        color: Color(0xff707070),
                      ),
                      onPressed: () {
                        _controller.isPasswordShow.value =
                        (!_controller.isPasswordShow.value);
                      },
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ));

      await tester.pump();
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      expect(find.byIcon(Icons.visibility_off), findsNothing);
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    },
  );
}
