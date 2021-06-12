import 'package:final_project/controllers/cart_controller.dart';
import 'package:final_project/generated/locales.g.dart';
import 'package:final_project/views/pages/shopping_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingCartAppBar extends StatefulWidget
    implements PreferredSizeWidget {

  @override
  _ShoppingCartAppBarState createState() => _ShoppingCartAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _ShoppingCartAppBarState extends State<ShoppingCartAppBar> {
  Map<String, AppBar> appBarList;

  @override
  void initState() {
    super.initState();

    AppBar mainAppBar = AppBar(
      elevation: 5,
      title: Text(
        'Shopping Cart',
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
                  child: Obx(() => Text('${_controller().cartsList.length}' , style: TextStyle(fontWeight: FontWeight.bold),)),
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
          _controller().searchCarts(value);
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
    _controller().getCarts();
    _controller().currentAppBar('mainAppBar');
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<CartController>(() => CartController());
    return Obx(() => appBarList[_controller().currentAppBar]);
  }
  CartController _controller() => Get.find<CartController>();
}
