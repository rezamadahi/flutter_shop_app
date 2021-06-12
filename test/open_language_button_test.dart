import 'package:final_project/controllers/drawer_controller.dart';
import 'package:final_project/generated/locales.g.dart';
import 'package:final_project/generated/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  final _controller = Get.put(MyDrawerController());

  testWidgets(
    "open language button test",
        (WidgetTester tester) async {
      await tester.pumpWidget(GetMaterialApp(
        title: 'Flutter Store',
        debugShowCheckedModeBanner: false,
        locale: Get.deviceLocale,
        translations: LocalizationService(),
        home: Scaffold(
          body: Obx(() => Container(
            child: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.language,
                        color: Colors.black87,
                        size: 25,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        LocaleKeys.drawer_page_language.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ],
                  ),
                  (!_controller.isLanguageOpen.value)
                      ? Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 25,
                    color: Colors.black87,
                  )
                      : Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.black87,
                    size: 25,
                  ),
                ],
              ),
              onTap: () {
                _controller.isLanguageOpen(!_controller.isLanguageOpen.value);
              },
            ),
          )),
        ),
      ));

      await tester.pump();
      expect(find.byIcon(Icons.keyboard_arrow_right_outlined), findsOneWidget);
      await tester.tap(find.byIcon(Icons.language));
      await tester.pump();
      expect(find.byIcon(Icons.keyboard_arrow_right_outlined), findsNothing);
      expect(find.byIcon(Icons.keyboard_arrow_down_outlined), findsOneWidget);
    },
  );
}
