import 'dart:io';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:final_project/models/tag_model.dart';
import 'package:final_project/views/pages/admin_panel_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:final_project/controllers/repositories/product_repository.dart';
import 'package:final_project/models/product_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ProductRepository _productRepository = ProductRepository();
  TextEditingController productTitleController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();
  TextEditingController productTagController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  int userId = GetStorage().read("userId");

  File image;
  String imageUrl;
  List<ProductModel> productsList = [];
  List<TagModel> productTags = [];
  RxList<TagModel> tagsList = <TagModel>[].obs;
  RxBool isActive = false.obs;
  RxBool isOnlyExistProducts = false.obs;
  RxBool isFilterRowOpen = false.obs;
  RxBool isImageLoaded = false.obs;
  RxBool isEditMood = false.obs;
  RxString currentAppBar = 'mainAppBar'.obs;
  RxBool isSearchOpen = false.obs;
  RxInt cartCount = 0.obs;
  List<ProductModel> favouriteProducts = [];

  @override
  void onInit() {
    // getProducts();
    super.onInit();
  }

  final picker = ImagePicker();

  Future uploadImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    isImageLoaded(true);
    if (pickedFile != null) {
      image = File(pickedFile.path.toString());
      imageUrl = base64Encode(image.readAsBytesSync());
    } else {
      print('No image selected');
    }
    isImageLoaded(false);
  }

  void addProduct(ProductModel product) async {
    product.isActive = isActive.value;
    product.title = productTitleController.text;
    product.description = productDescriptionController.text;
    product.price = int.parse(productPriceController.text);
    product.quantity = int.parse(productQuantityController.text);
    product.productTags = productTags;
    product.imageUrl = imageUrl;
    Either<String, bool> result = await _productRepository.addProduct(product);
    result.fold((l) {
      print(l);
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text('Server don\'t respond'),
        duration: Duration(seconds: 4),
      ));
    }, (bool r) {
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text('Product added'),
        duration: Duration(seconds: 4),
      ));
      getProducts();
      productTitleController.clear();
      productDescriptionController.clear();
      productPriceController.clear();
      productQuantityController.clear();
      productTagController.clear();
      imageUrl = null;
      Get.to(() => AdminPanelScreen());
    });
  }

  void updateProduct(ProductModel product) async {
    Either<String, bool> result =
        await _productRepository.updateProduct(product);
    result.fold((l) {
      print(l);
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text('Server don\'t respond'),
        duration: Duration(seconds: 4),
      ));
    }, (bool r) {
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text('Product updated'),
        duration: Duration(seconds: 4),
      ));
      Get.to(() => AdminPanelScreen());
    });
  }

  void updateQuantity(int productId, int quantity) async {
    Either<String, bool> result =
        await _productRepository.updateQuantity(productId, quantity);
    result.fold((l) {}, (bool r) {
      // productsList.refresh();
      // Get.off(() => AdminPanelScreen());
    });
  }

  Future<void> getProducts() async {
    // productsList([]);
    productsList = [];
    Either<String, List<ProductModel>> result =
        await _productRepository.getProducts();
    result.fold((l) {
      print(l);
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text('No Product added'),
        duration: Duration(seconds: 4),
      ));
    }, (List<ProductModel> productList) {
      if (productList != null) {
        productsList.addAll(productList);
        update();
      } else {
        ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
          content: Text('No Product added'),
          duration: Duration(seconds: 4),
        ));
      }
    });
  }

  ProductModel getProductById(int productId) {
    ProductModel productResult;
    productsList.forEach((element) {
      if (element.id == productId) {
        productResult = element;
      }
    });
    return productResult;
  }

  Future<void> searchProducts(String param) async {
    productsList = [];
    Either<String, List<ProductModel>> result =
        await _productRepository.searchProducts(param);
    result.fold((l) {
      print(l);
    }, (List<ProductModel> productList) {
      if (productList != null) {
        productsList.addAll(productList);
        update();
      } else {
        ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
          content: Text('No Product find'),
          duration: Duration(seconds: 4),
        ));
      }
    });
  }

  Future<void> removeProduct(ProductModel product) async {
    Either<String, bool> result =
        await _productRepository.productRemove(product.id);
    result.fold((l) {
      print(l);
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text('No Product to remove.'),
        duration: Duration(seconds: 4),
      ));
    }, (r) {
      if (r) {
        productsList.remove(product);
        getProducts();
      } else {
        ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
          content: Text('Can\'t remove Product'),
          duration: Duration(seconds: 4),
        ));
      }
    });
  }

  void addProductTag(TagModel newTag) {
    if (productTags
        .where((element) => element.id == newTag.id)
        .toList()
        .isEmpty) {
      productTagController.text = newTag.tagName;
      productTags.add(newTag);
    }
  }

  Future<void> searchTags(String param) async {
    tagsList([]);
    Either<String, List<TagModel>> result =
        await _productRepository.searchTags(param);
    result.fold((l) {
      print(l);
    }, (List<TagModel> tagList) {
      if (tagList != null) {
        tagsList.addAll(tagList);
      } else {
        ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
          content: Text('No Tags find'),
          duration: Duration(seconds: 4),
        ));
      }
    });
  }

}
