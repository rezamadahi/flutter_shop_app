import 'dart:convert';
import 'package:final_project/controllers/cart_controller.dart';
import 'package:final_project/views/components/drawer_screen.dart';
import 'package:final_project/views/components/shopping_cart_appbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantity_package/quantity_package.dart';

class ShoppingCartScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController());
  }
}

class ShoppingCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CartController());
    final _pageColor = Colors.pink;
    return Scaffold(
      backgroundColor: Color(0xffe74c3c),
      appBar: ShoppingCartAppBar(),
      drawer: mainDrawer(context),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() {
            Get.lazyPut(() => CartController());
            return ListView.builder(
              itemCount: _controller().cartsList.length,
              itemBuilder: (context, index) {
                if (!_controller().isLoading()) {
                  return productItem(_pageColor, index);
                }
                return SizedBox();
              },
            );
          }),
        ),
      ),
    );
  }

  Widget productItem(MaterialColor _pageColor, int index) {
    Get.lazyPut(() => CartController());

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
            child: showImage(_controller().cartsList[index].product.imageUrl),
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
                        _controller().cartsList[index].product.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        'Price : ${_controller().cartsList[index].product.price}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 66,
                    minHeight: 65,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Description : ${_controller().cartsList[index].product.description}',
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
                      (_controller().cartsList[index].product.quantity == 0)
                          ? 'Product finished'
                          : 'Quantity : ${_controller().cartsList[index].product.quantity}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ((_controller()
                                      .cartsList[index]
                                      .product
                                      .quantity) <=
                                  5)
                              ? Colors.red
                              : Colors.black87),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        QuantityButton(
                          isLoading: _controller().quantityLoading[
                              _controller().cartsList[index].id],
                          onChangeValue: (bool isIncrease) {
                            _controller().updateProductQuantity(
                                _controller().cartsList[index].product.id,
                                _controller().cartsList[index].product.quantity,
                                isIncrease,
                                index);
                          },
                          value: _controller().cartsList[index].productQuantity,
                          maxValue: _controller()
                                  .cartsList[index]
                                  .product
                                  .quantity +
                              _controller().cartsList[index].productQuantity,
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: 45,
                      width: 280,
                      decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2,
                        ),
                        itemCount: _controller()
                            .cartsList[index]
                            .product
                            .productTags
                            .length,
                        itemBuilder: (context, tagIndex) {
                          return Text(
                            '#${_controller().cartsList[index].product.productTags[tagIndex].tagName}',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 30,
                        ),
                        onPressed: () {
                          _controller().removeProductFromShoppingCart(
                              _controller().cartsList[index]);
                        }),
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

  CartController _controller() => Get.find<CartController>();
}
