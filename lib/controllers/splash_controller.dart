import 'package:dartz/dartz.dart';
import 'package:final_project/controllers/repositories/spalsh_repository.dart';
import 'package:final_project/views/authentication/login_screen.dart';
import 'package:get/get.dart';
import 'package:final_project/models/user_model.dart';

class SplashController extends GetxController {
  SplashRepository _splashRepository = SplashRepository();

  void isAdminExist() async {
    Either<String, bool> result = await _splashRepository.isAdminExist();
    result.fold((l) {
      print(l);
    }, (bool r) {
      if (r) {
        Get.off(LoginScreen());
      } else {
        UserModel adminUser = UserModel(username: "admin", password: "123456");
        this.addAdmin(adminUser);
      }
    });
  }

  void addAdmin(UserModel adminUser) async {
    Either<String, bool> result = await _splashRepository.addAdmin(adminUser);
    result.fold((l) {
      print(l);
    }, (bool r) {
      Get.off(() => LoginScreen());
    });
  }
}
