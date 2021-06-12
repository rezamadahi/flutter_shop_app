import 'package:final_project/controllers/product_controller.dart';
import 'package:final_project/views/components/admin_drawer_screen.dart';
import 'package:final_project/views/components/main_appbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:final_project/views/product/product_item.dart';

class AdminPanelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pageColor = Colors.pink;
    Get.lazyPut<ProductController>(() => ProductController());

    return Scaffold(
      backgroundColor: Color(0xffe74c3c),
      appBar: MainAppBarScreen(
        appBarTitle: 'Admin Panel',
      ),
      drawer: adminDrawer(context),
      body: adminPanelScreenBody(_pageColor),
    );
  }

  SafeArea adminPanelScreenBody(MaterialColor _pageColor) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: GetBuilder<ProductController>(
            init: ProductController(),
            initState: (_) {
              Get.lazyPut<ProductController>(() => ProductController());
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
        // child: Obx(() => ListView.builder(
        //       itemCount: _controller().productsList.length,
        //       itemBuilder: (context, index) {
        //         return ProductItem(_controller().productsList[index] , index);
        //       },
        //     )),
      ),
    );
  }
  ProductController _controller() => Get.find<ProductController>();
}
