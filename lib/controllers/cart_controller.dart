import 'package:dartz/dartz.dart';
import 'package:final_project/controllers/product_controller.dart';
import 'package:final_project/models/product_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:final_project/models/cart_model.dart';
import 'package:get_storage/get_storage.dart';
import 'repositories/cart_repository.dart';

class CartController extends GetxController {
  CartRepository _cartRepository = CartRepository();
  TextEditingController searchController = TextEditingController();
  RxList<CartModel> cartsList = <CartModel>[].obs;
  RxMap<int, bool> quantityLoading = <int, bool>{}.obs;
  RxString currentAppBar = 'mainAppBar'.obs;
  RxBool isSearchOpen = false.obs;
  RxBool isLoading = false.obs;
  int userId = GetStorage().read("userId");

  @override
  void onInit() async {
    super.onInit();
    Get.lazyPut<ProductController>(() => ProductController());
    await getCarts();
    _productController().getProducts();
  }

  void addCart(CartModel cart) async {
    Either<String, bool> result = await _cartRepository.addCart(cart);
    result.fold((l) {
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text('Server don\'t respond'),
        duration: Duration(seconds: 4),
      ));
    }, (bool r) {
      getCarts();
      _productController().getProducts();
      cartsList.refresh();
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text('Cart added'),
        duration: Duration(seconds: 2),
      ));
    });
  }

  void updateCart(CartModel cart, bool isIncrease, int index) async {
    if (isIncrease) {
      cart.product.quantity--;
      cart.productQuantity++;
    } else {
      cart.product.quantity++;
      cart.productQuantity--;
    }
    Either<String, bool> result = await _cartRepository.updateCart(cart);
    result.fold((l) {
      quantityLoading[index] = false;
      print(l);
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text('Server don\'t respond'),
        duration: Duration(seconds: 4),
      ));
    }, (bool r) {
      if (isIncrease) {
        // cartsList[index].product.quantity--;
        // cartsList[index].productQuantity++;
      } else {
        // cartsList[index].product.quantity++;
        // cartsList[index].productQuantity--;
      }
      // cartsList.refresh();
      quantityLoading[index] = false;
    });
  }

  Future<void> getCarts() async {
    isLoading(true);
    cartsList([]);
    Either<String, List<CartModel>> result = await _cartRepository.getCarts();
    result.fold((l) {
      print(l);
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text('No Cart added'),
        duration: Duration(seconds: 4),
      ));
    }, (List<CartModel> cartList) {
      if (cartList != null) {
        cartsList.addAll(cartList.where((element) => element.userId == userId).toList());
        for (var cart in cartList) {
          quantityLoading[cart.id] = false;
        }
      } else {
        ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
          content: Text('No Cart added'),
          duration: Duration(seconds: 2),
        ));
      }
    });
    isLoading(false);
  }

  Future<void> searchCarts(String param) async {
    cartsList([]);
    Either<String, List<CartModel>> result =
        await _cartRepository.searchCart(param);
    result.fold((l) {
      print(l);
    }, (List<CartModel> cartList) {
      if (cartList != null) {
        for (var cart in cartList) {
          if (cart.userId == userId) {
            cartsList.add(cart);
          }
        }
      } else {
        ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
          content: Text('No cart find'),
          duration: Duration(seconds: 4),
        ));
      }
    });
  }

  Future<void> removeProductFromShoppingCart(CartModel cart) async {
    Either<String, bool> result = await _cartRepository.cartRemove(cart.id);
    result.fold((l) {
      print(l);
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text('No Carts to remove.'),
        duration: Duration(seconds: 4),
      ));
    }, (r) {
      if (r) {
        cartsList.remove(cart);
        getCarts();
      } else {
        ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
          content: Text('Can\'t remove tag'),
          duration: Duration(seconds: 4),
        ));
      }
    });
  }

  void updateProductQuantity(
      int productId, int currentQuantity, bool isIncrease, int index) async {
    int quantityValue = isIncrease ? currentQuantity++ : currentQuantity--;
    quantityLoading[index] = true;
    Either<String, bool> result =
        await _cartRepository.updateProductQuantity(productId, quantityValue);
    result.fold((l) {
      quantityLoading[index] = false;
    }, (bool r) {
      updateCart(cartsList[index], isIncrease, index);
    });
    cartsList.refresh();
  }

  void addProductToCartIfNotExistInShoppingCart(
      int productId, int index) async {
    Either<String, bool> result =
    await _cartRepository.isExistInShoppingCart(userId, productId);
    result.fold((l) {}, (bool r) {
      if (!r) {
        addToShoppingCart(index);
      } else {
        ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
          content: Text('This product already exist in your shopping cart'),
          duration: Duration(seconds: 4),
        ));
      }
    });
  }

  void addToShoppingCart(int index) {
    updateQuantity(_productController().productsList[index].id, _productController().productsList[index].quantity - 1);
    CartModel cart = CartModel(
      userId: userId,
      product: _productController().productsList[index],
      productQuantity: 1,);
    addCart(cart);
  }

  void updateQuantity(int productId, int quantity) async {
    Either<String, bool> result =
    await _cartRepository.updateQuantity(productId, quantity);
    result.fold((l) {}, (bool r) {
      // productsList.refresh();
      // Get.off(() => AdminPanelScreen());
    });
  }

  ProductController _productController() => Get.find<ProductController>();
}
