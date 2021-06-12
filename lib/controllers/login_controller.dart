import 'package:dartz/dartz.dart';
import 'package:final_project/views/product/products_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:final_project/models/user_model.dart';
import 'package:final_project/controllers/repositories/login_repository.dart';
import 'package:get_storage/get_storage.dart';
import 'package:final_project/generated/locales.g.dart';

class LoginController extends GetxController {
  LoginRepository _loginRepository = LoginRepository();
  RxBool isPasswordShow = false.obs;
  RxBool pageLoading = false.obs;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  Future<void> userValidate(String username, String password) async {
    pageLoading(true);
    Either<String, UserModel> result =
        await _loginRepository.userValidate(username, password);
    result.fold((l) {
      pageLoading(false);
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text(LocaleKeys.login_page_wrong_acount.tr),
        duration: Duration(seconds: 4),
      ));
    }, (UserModel user) {
      if (user != null) {
        final box = GetStorage();
        box.write("userId", user.id);
        box.write("username", user.username);
        box.write("userImage", user.userImage);
        box.write(
            "isAdmin",
            (user.username == 'admin' && user.password == '123456')
                ? true
                : false);
        Get.off(() => ProductsListScreen());
      } else {
        ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
          content: Text(LocaleKeys.login_page_wrong_acount.tr),
          duration: Duration(seconds: 4),
        ));
      }
      pageLoading(false);
    });
  }
}
