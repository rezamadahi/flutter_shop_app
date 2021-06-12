import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:final_project/controllers/repositories/sign_up_repository.dart';
import 'package:final_project/models/user_model.dart';
import 'package:final_project/views/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignUpController extends GetxController {

  SignUpRepository _signUpRepository = SignUpRepository();

  TextEditingController userNameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passConfirmController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  File image;
  String imageUrl;
  RxBool isPasswordShow = false.obs;
  RxBool isPasswordConfirmShow = false.obs;
  RxBool isImageLoaded = false.obs;
  Rx<Gender> gender = (Gender.Male).obs;

  final picker = ImagePicker();
  Future getImage() async {
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

  void addUser(UserModel user) async {
    user.username = userNameController.text;
    user.password = passController.text;
    user.userImage = imageUrl;
    user.fullName = fullNameController.text;
    user.email = emailController.text;
    user.mobile = phoneController.text;
    user.address = addressController.text;
    user.gender = gender.value;
    Either<String, bool> result = await _signUpRepository.addUser(user);
    result.fold((l) {
      print(l);
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text('Server don\'t respond'),
        duration: Duration(seconds: 4),
      ));
    }, (bool r) {
      Get.off(() => LoginScreen());
    });
  }

  void updateUser(UserModel user) async {
    user.username = userNameController.text;
    user.password = passController.text;
    user.fullName = fullNameController.text;
    user.email = emailController.text;
    user.mobile = phoneController.text;
    user.address = addressController.text;
    user.gender = gender.value;
    user.userImage = imageUrl;
    Either<String, bool> result = await _signUpRepository.updateUser(user);
    result.fold((l) {
      print(l);
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text('Server don\'t respond'),
        duration: Duration(seconds: 4),
      ));
    }, (bool r) {
      Get.off(() => LoginScreen());
    });
  }

}