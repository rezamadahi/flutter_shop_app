import 'package:final_project/controllers/product_controller.dart';
import 'package:final_project/generated/locales.g.dart';
import 'package:final_project/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../components/admin_drawer_screen.dart';

class ProductEditCreateScreen extends StatelessWidget {
  final int editItemIndex;

  ProductEditCreateScreen({this.editItemIndex});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ProductController>(() => ProductController());
    Size _screenSize = MediaQuery.of(context).size;
    final _pageColor = Colors.pink;

    return Scaffold(
      appBar: AppBar(
        title: (_controller.isEditMood.value) ? Text(LocaleKeys.product_list_page_edit_product.tr) : Text(LocaleKeys.product_list_page_add_product.tr),
      ),
      drawer: adminDrawer(context),
      body: Obx(() => addProductScreenBody(_screenSize, _pageColor)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: (_controller.isEditMood.value)
            ? Icon(
                Icons.edit,
                size: 25,
              )
            : Icon(
                Icons.add,
                size: 25,
              ),
        onPressed: () {
          if (_controller.formKey.currentState.validate()) {
            ProductModel product = ProductModel();
            if (_controller.isEditMood.value) {
              product.id = _controller.productsList[editItemIndex].id;
              product.quantity =
                  int.parse(_controller.productQuantityController.text);
              product.price =
                  int.parse(_controller.productPriceController.text);
              product.description =
                  _controller.productDescriptionController.text;
              product.isActive = _controller.isActive.value;
              product.title = _controller.productTitleController.text;
              product.productTags = _controller.productTags;
              product.imageUrl = _controller.image.path;
              _controller.updateProduct(product);
            } else {
              _controller.addProduct(product);
            }
            _controller.getProducts();
            _controller.isEditMood(false);
          }
        },
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }

  Widget addProductScreenBody(Size _screenSize, MaterialColor _pageColor) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: _screenSize.width,
          height: _screenSize.height,
          color: _pageColor.shade50,
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _controller.productTitleController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return LocaleKeys.product_list_page_product_name_empty.tr;
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    isDense: true,
                    fillColor: Colors.white,
                    filled: true,
                    hintText: (_controller.isEditMood.value)
                        ? '${_controller.productsList[editItemIndex].title}'
                        : LocaleKeys.product_list_page_product_title_field.tr,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _controller.productDescriptionController,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  minLines: 1,
                  maxLines: 5,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    isDense: true,
                    fillColor: Colors.white,
                    filled: true,
                    hintText: (_controller.isEditMood.value)
                        ? '${_controller.productsList[editItemIndex].description}'
                        : LocaleKeys.product_list_page_product_description_field.tr,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                SizedBox(height: 16),
                TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    autofocus: false,
                    controller: _controller.productTagController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16),
                      isDense: true,
                      fillColor: Colors.white,
                      filled: true,
                      hintText: LocaleKeys.product_list_page_product_tags.tr,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    return await searchSuggestion(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: Icon(Icons.tag),
                      title: Text(suggestion.tagName),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    _controller.addProductTag(suggestion);
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _controller.productPriceController,
                  keyboardType: TextInputType.number,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Insert the price of product.';
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    isDense: true,
                    fillColor: Colors.white,
                    filled: true,
                    hintText: (_controller.isEditMood.value)
                        ? '${_controller.productsList[editItemIndex].price}'
                        : 'Product Price',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _controller.productQuantityController,
                  keyboardType: TextInputType.number,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return LocaleKeys.product_list_page_product_quantity_empty.tr;
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    isDense: true,
                    fillColor: Colors.white,
                    filled: true,
                    hintText: (_controller.isEditMood.value)
                        ? '${_controller.productsList[editItemIndex].quantity}'
                        : LocaleKeys.product_list_page_product_quantity.tr,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff707070), width: 1.0),
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.white,
                    ),
                    height: 170,
                    alignment: Alignment.center,
                    child: (!_controller.isImageLoaded.value)
                        ? (_controller.image == null)
                            ? Image.asset(
                                'assets/images/add_image.jpg',
                                fit: BoxFit.cover,
                                width: 200,
                              )
                            : Image.file(_controller.image)
                        : Image.asset(
                            'assets/images/add_image.jpg',
                            fit: BoxFit.cover,
                            width: 200,
                          ),
                  ),
                  onTap: () {
                    _controller.uploadImage();
                  },
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Active',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Checkbox(
                      value: _controller.isActive.value,
                      onChanged: (value) {
                        _controller.isActive.value =
                            !_controller.isActive.value;
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List> searchSuggestion(String pattern) async {
    _controller.searchTags(pattern);
    return _controller.tagsList;
  }

  ProductController get _controller => Get.find<ProductController>();

}
