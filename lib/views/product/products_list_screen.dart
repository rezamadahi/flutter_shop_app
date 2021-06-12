import 'package:final_project/controllers/cart_controller.dart';
import 'package:final_project/controllers/product_controller.dart';
import 'package:final_project/generated/locales.g.dart';
import 'package:final_project/views/components/drawer_screen.dart';
import 'package:final_project/views/components/main_appbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:final_project/views/product/product_item.dart';

class ProductsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe74c3c),
      appBar: MainAppBarScreen(
        appBarTitle: LocaleKeys.appbar_page_products_title.tr,
      ),
      drawer: mainDrawer(context),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: GetBuilder<ProductController>(
            init: ProductController(),
            initState: (_) {
              Get.lazyPut<ProductController>(() => ProductController());
              Get.lazyPut<CartController>(() => CartController());
              _controller().getProducts();
            },
              builder: (_) {
                return ListView.builder(
                  itemCount: _controller().productsList.length,
                  itemBuilder: (context, index) {
                    return (_controller().productsList[index].isActive)
                        ? ProductItem(_controller().productsList[index] , index)
                        : SizedBox();
                  },
                );
              }
          ),
        ),
      ),
    );
  }

  ProductController _controller() => Get.find<ProductController>();
}
