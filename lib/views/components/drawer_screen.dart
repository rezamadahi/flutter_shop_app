import 'dart:convert';
import 'package:final_project/generated/locales.g.dart';
import 'package:final_project/views/authentication/edit_profile.dart';
import 'package:final_project/views/pages/admin_panel_screen.dart';
import 'package:final_project/views/pages/favourites_screen.dart';
import 'package:final_project/views/product/products_list_screen.dart';
import 'package:final_project/views/pages/shopping_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:final_project/controllers/drawer_controller.dart';
import 'package:get_storage/get_storage.dart';
import '../authentication/login_screen.dart';

Drawer mainDrawer(BuildContext context) {
  final _controller = Get.put(MyDrawerController());
  final _pageColor = Colors.pink;
  final userInfo = GetStorage();
  bool isAdmin = userInfo.read("isAdmin");

  return Drawer(
    child: Container(
      decoration: BoxDecoration(
        color: _pageColor.shade50,
      ),
      child: ListView(
        children: [
          drawerHeader(),
          homeButton(),
          drawerDivider(),
          shoppingCartButton(),
          drawerDivider(),
          favouritesButton(),
          drawerDivider(),
          Obx(
            () => languageButton(_controller),
          ),
          Container(
            child: Obx(() => languagesOption(_controller)),
          ),
          isAdmin ? drawerDivider() : SizedBox(),
          isAdmin ? adminPanelButton() : SizedBox(),
          OutlinedButton(
            onPressed: onLogOutButton,
            child: Text(LocaleKeys.drawer_page_log_out_button.tr),
          ),
        ],
      ),
    ),
  );
}

void onLogOutButton() {
  final userInfo = GetStorage();
  userInfo.remove('id');
  userInfo.remove('username');
  userInfo.remove('userImage');
  Get.off(LoginScreen());
}

Widget drawerHeader() {
  final userInfo = GetStorage();
  String username;
  String userImage;
  if (userInfo.read('username') != null) {
    username = userInfo.read('username');
    userImage = userInfo.read('userImage');
  } else {
    username = 'admin';
  }
  return DrawerHeader(
    padding: EdgeInsets.zero,
    child: InkWell(
      onTap: () {
        Get.off(() => EditProfile());
      },
      child: Container(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (userImage.isNotEmpty)
                  ? CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.transparent,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Card(
                          child: showImage(userImage),
                          clipBehavior: Clip.antiAlias,
                        ),
                      ),
                    )
                  : CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.black87,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30,
                      ),
                      // backgroundImage: FileImage(userImage),
                    ),
              SizedBox(
                height: 8,
              ),
              Text(
                username,
                style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

showImage(String imageUrl) {
  return
    imageUrl == null ?
    Image.asset(
      'assets/images/add_image.jpg',
      fit: BoxFit.cover,
      width: 200,
    ):
    Image.memory(
    base64Decode(imageUrl),
    fit: BoxFit.cover,
  );
}

Widget homeButton() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
    child: GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.home,
            color: Colors.black87,
            size: 25,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            LocaleKeys.drawer_page_home_button.tr,
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ],
      ),
      onTap: () {
        Get.to(() => ProductsListScreen());
      },
    ),
  );
}

Widget favouritesButton() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
    child: GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.favorite_border,
            color: Colors.black87,
            size: 25,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            LocaleKeys.drawer_page_favourites.tr,
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ],
      ),
      onTap: () {
        Get.to(() => FavouritesScreen());
      },
    ),
  );
}

Widget shoppingCartButton() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
    child: GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.shopping_cart,
            color: Colors.black87,
            size: 25,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            LocaleKeys.drawer_page_shopping_cart.tr,
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ],
      ),
      onTap: () {
        Get.to(() => ShoppingCartScreen());
      },
    ),
  );
}

Widget drawerDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Expanded(
            child: Divider(
          height: 2,
          color: Colors.black87,
        ))
      ],
    ),
  );
}

Widget languageButton(MyDrawerController _controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
  );
}

Widget languagesOption(MyDrawerController controller) {
  if (controller.isLanguageOpen.value) {
    return Column(
      children: [
        drawerDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 45),
          child: GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.drawer_page_english_language.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ],
            ),
            onTap: () {
              Get.updateLocale(Locale('en'));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 45),
          child: GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.drawer_page_persian_language.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ],
            ),
            onTap: () {
              Get.updateLocale(Locale('fa'));
            },
          ),
        ),
      ],
    );
  } else {
    return SizedBox();
  }
}

Widget adminPanelButton() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
    child: GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.admin_panel_settings,
            color: Colors.black87,
            size: 25,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            LocaleKeys.drawer_page_admin_panel.tr,
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ],
      ),
      onTap: () {
        Get.to(() => AdminPanelScreen());
      },
    ),
  );
}
