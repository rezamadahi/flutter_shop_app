import 'package:final_project/controllers/tag_controller.dart';
import 'package:final_project/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TagAppBarScreen extends StatefulWidget implements PreferredSizeWidget {
  @override
  _TagAppBarScreenState createState() => _TagAppBarScreenState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TagAppBarScreenState extends State<TagAppBarScreen> {
  Map<String, AppBar> appBarList;

  @override
  void initState() {
    super.initState();

    AppBar mainAppBar = AppBar(
      elevation: 5,
      title: Text(
        LocaleKeys.appbar_page_tag_title.tr,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      actions: [
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
        controller: _controller.searchController,
        onChanged: (String value) {
          _controller.searchTags(value);
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

  void _onBackButton() {
    _controller.isSearchOpen(false);
    _controller.searchController.clear();
    _controller.getTags();
    _controller.currentAppBar('mainAppBar');
  }

  void _onSearchButton() {
    _controller.isSearchOpen(true);
    _controller.currentAppBar('searchAppBar');
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => appBarList[_controller.currentAppBar]);
  }

  TagController get _controller => Get.find<TagController>();
}
