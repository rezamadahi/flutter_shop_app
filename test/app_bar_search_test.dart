import 'package:final_project/controllers/product_controller.dart';
import 'package:final_project/generated/locales.g.dart';
import 'package:final_project/generated/localization_service.dart';
import 'package:final_project/views/pages/shopping_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  final _controller = Get.put(ProductController());

  testWidgets(
    "open search field test",
        (WidgetTester tester) async {
      await tester.pumpWidget(GetMaterialApp(
        title: 'Flutter Store',
        debugShowCheckedModeBanner: false,
        locale: Get.deviceLocale,
        translations: LocalizationService(),
        home: Scaffold(
          body: Obx(() {
            Map<String, AppBar> appBarList;
            AppBar mainAppBar = AppBar(
              elevation: 5,
              title: Text(
                'Products',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(top: 6, right: 8, left: 8),
                  child: Stack(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Get.off(() => ShoppingCartScreen());
                        },
                      ),
                      Positioned(
                        right: 0,
                        top: 3,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 10,
                          child: Obx(() => Text('${_controller.cartCount}' , style: TextStyle(fontWeight: FontWeight.bold),)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onTap: () {
                      _controller.isSearchOpen(true);
                      _controller.currentAppBar('searchAppBar');
                    },
                  ),
                ),
              ],
            );

            AppBar searchAppBar = AppBar(
              elevation: 5,
              backgroundColor: Colors.white,
              title: TextField(
                controller: _controller.searchController,
                onChanged: (String value) {
                  _controller.searchProducts(value);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: LocaleKeys.appbar_page_search.tr,
                  hintStyle: TextStyle(color: Colors.black54),
                ),
              ),
              leading: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  child: Icon(
                    Icons.arrow_back,
                    color: Color(0xff075e54),
                  ),
                  onTap: (){
                    _controller.isSearchOpen(false);
                    _controller.searchController.clear();
                    _controller.getProducts();
                    _controller.currentAppBar('mainAppBar');
                  },
                ),
              ),
            );
            appBarList = <String, AppBar>{
              'mainAppBar': mainAppBar,
              'searchAppBar': searchAppBar,
            };
            return appBarList[_controller.currentAppBar];
          }),
        ),
      ));

      await tester.pump();
      expect(find.byIcon(Icons.search), findsOneWidget);
      await tester.tap(find.byIcon(Icons.search));
      await tester.pump();
      expect(find.byIcon(Icons.search), findsNothing);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    },
  );
}
