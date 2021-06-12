import 'dart:convert';
import 'package:final_project/controllers/cart_controller.dart';
import 'package:final_project/controllers/favourite_controller.dart';
import 'package:final_project/controllers/product_controller.dart';
import 'package:final_project/generated/locales.g.dart';
import 'package:final_project/models/cart_model.dart';
import 'package:final_project/models/product_model.dart';
import 'package:final_project/views/product/product_edit_create_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  final int productItemIndex;

  ProductItem(this.product, this.productItemIndex);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ProductController>(() => ProductController());
    Get.lazyPut<FavouriteController>(() => FavouriteController());
    Get.lazyPut<CartController>(() => CartController());
    final _pageColor = Colors.pink;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _pageColor.shade50,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 180,
            width: double.infinity,
            child: showImage(product.imageUrl),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                          color: Colors.grey,
                          width: 1,
                          style: BorderStyle.solid)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        '${LocaleKeys.product_list_page_product_price.tr} : ${product.price}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 66,
                    minHeight: 65,
                    maxWidth: 330,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${LocaleKeys.product_list_page_product_description.tr} : ${product.description}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (product.quantity == 0)
                          ? LocaleKeys.admin_panel_page_product_finished.tr
                          : '${LocaleKeys.product_list_page_product_quantity.tr} : ${product.quantity}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ((product.quantity) <= 5)
                              ? Colors.red
                              : Colors.black87),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.shopping_cart),
                          onPressed: (product.quantity > 0)
                              ? () {
                                  _cartController()
                                      .addProductToCartIfNotExistInShoppingCart(
                                          product.id, productItemIndex);
                                }
                              : null,
                        ),
                        GetBuilder<FavouriteController>(
                            init: FavouriteController(),
                            initState: (_) {},
                            builder: (_) {
                              return (_favouriteController()
                                      .checkFavoriteProduct(product)
                                  ? IconButton(
                                      icon: Icon(Icons.favorite),
                                      onPressed: () => _favouriteController()
                                          .removeFavourite(product))
                                  : IconButton(
                                      icon: Icon(Icons.favorite_outline),
                                      onPressed: () => _favouriteController()
                                          .addFavourite(product)));
                            }),
                      ],
                    ),
                  ],
                ),
                Divider(),
                GetStorage().read("isAdmin")
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _controller().removeProduct(product);
                              }),
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _controller().isEditMood(true);
                                Get.to(() => ProductEditCreateScreen(
                                      editItemIndex: productItemIndex,
                                    ));
                              }),
                        ],
                      )
                    : SizedBox(),
                GetStorage().read("isAdmin") ? Divider() : SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: 45,
                      width: 330,
                      decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2,
                        ),
                        itemCount: _controller()
                            .productsList[productItemIndex]
                            .productTags
                            .length,
                        itemBuilder: (context, tagIndex) {
                          return Text(
                            '#${_controller().productsList[productItemIndex].productTags[tagIndex].tagName}',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showImage(String imageUrl) {
    return imageUrl == null
        ? Image.asset(
            'assets/images/add_image.jpg',
            fit: BoxFit.cover,
            width: 200,
          )
        : Image.memory(
            base64Decode(imageUrl),
            fit: BoxFit.cover,
          );
  }

  ProductController _controller() => Get.find<ProductController>();
  CartController _cartController() => Get.find<CartController>();
  FavouriteController _favouriteController() => Get.find<FavouriteController>();
}
