import 'package:final_project/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/models/favourites_model.dart';
import 'package:get_storage/get_storage.dart';
import 'repositories/favourites_repository.dart';

class FavouriteController extends GetxController {
  FavouritesRepository _favouritesRepository = FavouritesRepository();
  List<FavouriteModel> favouritesList = [];
  int userId = GetStorage().read("userId");

  bool checkFavoriteProduct(ProductModel product) {
    return favouritesList
        .where((element) =>
            element.product.id == product.id && element.userId == userId)
        .toList()
        .isNotEmpty;
  }

  int getFavoriteIdFromProduct(ProductModel product) {
    int favouriteId = -1;
    favouritesList.forEach((element) {
      if (element.product.id == product.id && element.userId == userId) {
        favouriteId = element.id;
      }
    });
    return favouriteId;
  }

  void addFavourite(ProductModel product) async {
    FavouriteModel favourite = FavouriteModel(
      userId: userId,
      product: product,
    );
    Either<String, bool> result =
        await _favouritesRepository.addFavourite(favourite);
    result.fold((l) {
      print(l);
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text('Server don\'t respond'),
        duration: Duration(seconds: 3),
      ));
    }, (bool r) async {
      await getFavourites();
      update();
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text('Added to favourites list'),
        duration: Duration(seconds: 3),
      ));
    });
  }

  Future<void> getFavourites() async {
    favouritesList = [];
    Either<String, List<FavouriteModel>> result =
        await _favouritesRepository.getFavourites();
    result.fold((l) {
      print(l);
    }, (List<FavouriteModel> favouriteList) {
      if (favouriteList != null) {
        favouritesList.addAll(favouriteList);
        update();
      } else {
        ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
          content: Text('No favourite added'),
          duration: Duration(seconds: 2),
        ));
      }
    });
  }

  Future<void> searchFavourites(String param) async {
    favouritesList = [];
    Either<String, List<FavouriteModel>> result =
        await _favouritesRepository.searchFavourites(param);
    result.fold((l) {
      print(l);
    }, (List<FavouriteModel> favouriteList) {
      if (favouriteList != null) {
        favouritesList.addAll(favouriteList);
        getFavourites();
        update();
      } else {
        ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
          content: Text('No favourite find'),
          duration: Duration(seconds: 4),
        ));
      }
    });
  }

  Future<void> removeFavourite(ProductModel product) async {
    Either<String, bool> result = await _favouritesRepository
        .removeFavourite(getFavoriteIdFromProduct(product));
    result.fold((l) {
      print(l);
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text('No favourite to remove.'),
        duration: Duration(seconds: 4),
      ));
    }, (r) {
      if (r) {
        favouritesList.remove(getFavoriteIdFromProduct(product));
        getFavourites();
        update();
      } else {
        ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
          content: Text('Can\'t remove favourite'),
          duration: Duration(seconds: 4),
        ));
      }
    });
  }
}
