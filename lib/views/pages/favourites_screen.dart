import 'dart:convert';
import 'package:final_project/controllers/favourite_controller.dart';
import 'package:final_project/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:final_project/views/components/main_appbar_screen.dart';
import 'package:final_project/views/components/drawer_screen.dart';
import 'package:get/get.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pageColor = Colors.pink;
    // _controller().getFavourites();
    return Scaffold(
        backgroundColor: Color(0xffe74c3c),
        appBar: MainAppBarScreen(
          appBarTitle: 'Favourites',
        ),
        drawer: mainDrawer(context),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: GetBuilder<FavouriteController>(
                init: FavouriteController(),
                initState: (_) {
                  Get.lazyPut<FavouriteController>(() => FavouriteController());
                },
                builder: (_) {
                  return ListView.builder(
                    itemCount: _controller().favouritesList.length,
                    itemBuilder: (context, index) {
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
                              child: showImage(_controller().favouritesList[index].product.imageUrl),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                        border: Border.all(
                                            color: Colors.grey,
                                            width: 1,
                                            style: BorderStyle.solid)),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _controller().favouritesList[index].product.title,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          'Price : ${_controller().favouritesList[index].product.price}',
                                          style:
                                          TextStyle(fontWeight: FontWeight.bold),
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
                                          'Description : ${_controller().favouritesList[index].product.description}',
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
                                        (_controller().favouritesList[index].product.quantity == 0)
                                            ? 'Product finished'
                                            : 'Quantity : ${_controller().favouritesList[index].product.quantity}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: (_controller().favouritesList[index].product.quantity <= 5)
                                                ? Colors.red
                                                : Colors.black87),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                              icon: Icon(Icons.favorite),
                                              onPressed: () {
                                                _controller().removeFavourite(_controller().favouritesList[index].product);
                                              }),
                                          IconButton(
                                              icon: Icon(Icons.shopping_cart),
                                              onPressed: () {}),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        height: 40,
                                        width: 330,
                                        decoration: BoxDecoration(
                                            color: Colors.white60,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16))),
                                        child: GridView.builder(
                                          gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 2,
                                          ),
                                          itemCount: _controller().favouritesList[index].product.productTags.length,
                                          itemBuilder: (context, tagIndex) {
                                            return Text(
                                              '#${_controller().favouritesList[index].product.productTags[tagIndex].tagName}',
                                              style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontWeight:
                                                  FontWeight.bold),
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
                    },
                  );
                }),
          ),
        ));
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
  FavouriteController _controller() => Get.find<FavouriteController>();
}
