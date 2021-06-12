import 'package:final_project/controllers/cart_controller.dart';
import 'package:final_project/generated/locales.g.dart';
import 'package:final_project/views/pages/shopping_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:final_project/controllers/product_controller.dart';

class MainAppBarScreen extends StatefulWidget implements PreferredSizeWidget {
  final String appBarTitle;

  MainAppBarScreen({this.appBarTitle});

  @override
  _MainAppBarScreenState createState() => _MainAppBarScreenState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MainAppBarScreenState extends State<MainAppBarScreen> {
  Map<String, AppBar> appBarList;

  @override
  void initState() {
    super.initState();

    AppBar mainAppBar = AppBar(
      elevation: 5,
      title: Text(
        widget.appBarTitle,
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
                  Get.to(() {
                    Get.lazyPut<CartController>(() => CartController());
                    return ShoppingCartScreen();
                  });
                },
              ),
              Positioned(
                right: 0,
                top: 3,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 10,
                  child: Obx(() => Text(
                        '${_cartController().cartsList.length}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
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
            onTap: _onSearchButton,
          ),
        ),
      ],
    );

    AppBar searchAppBar = AppBar(
      elevation: 5,
      backgroundColor: Colors.white,
      title: TextField(
        controller: _controller().searchController,
        onChanged: (String value) {
          _controller().searchProducts(value);
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
          onTap: _onBackButton,
        ),
      ),
    );

    appBarList = <String, AppBar>{
      'mainAppBar': mainAppBar,
      'searchAppBar': searchAppBar,
    };
  }

  void _onSearchButton() {
    _controller().isSearchOpen(true);
    _controller().currentAppBar('searchAppBar');
  }

  void _onBackButton() {
    _controller().isSearchOpen(false);
    _controller().searchController.clear();
    _controller().getProducts();
    _controller().currentAppBar('mainAppBar');
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ProductController>(() => ProductController());
    Get.lazyPut<CartController>(() => CartController());
    return Obx(() => appBarList[_controller().currentAppBar]);
  }

  ProductController _controller() => Get.find<ProductController>();

  CartController _cartController() => Get.find<CartController>();
}
