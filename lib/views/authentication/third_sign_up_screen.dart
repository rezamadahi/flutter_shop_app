import 'package:final_project/generated/locales.g.dart';
import 'package:final_project/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:final_project/controllers/sign_up_controller.dart';

class ThirdSignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    final _pageColor = Colors.pink;
    Get.lazyPut<SignUpController>(() => SignUpController());

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: thirdSignUpBody(_screenSize, _pageColor),
    );
  }

  Widget thirdSignUpBody(Size _screenSize, MaterialColor _pageColor) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: _screenSize.width,
          height: _screenSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              signUpIcon(_screenSize, _pageColor),
              thirdSignUpForm(_screenSize, _pageColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget signUpIcon(Size _screenSize, MaterialColor _pageColor) {
    return Container(
      height: _screenSize.height * 0.2,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CircleAvatar(
              radius: 40,
              backgroundColor: _pageColor.shade100,
              child: Icon(
                Icons.person,
                size: 48,
                color: _pageColor.shade800,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                LocaleKeys.sign_up_page_sign_up.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget thirdSignUpForm(Size _screenSize, MaterialColor _pageColor) {
    return Container(
      height: _screenSize.height * 0.78,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: _pageColor.shade50,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(56),
          topLeft: Radius.circular(56),
        ),
      ),
      child: thirdSignUpFormBody(),
    );
  }

  Widget thirdSignUpFormBody() {
    return ListView(
      children: <Widget>[profileImageBox(), profileDetailsBox(), buttonRow()],
    );
  }

  Widget profileImageBox() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff707070), width: 1.0),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      height: 170,
      alignment: Alignment.center,
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey,
        backgroundImage: FileImage(_controller.image),
      ),
    );
  }

  Widget profileDetailsBox() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff707070), width: 1.0),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
      ),
      height: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${LocaleKeys.sign_up_page_full_name.tr} : ${_controller.fullNameController.text}',
            style: TextStyle(fontSize: 17),
          ),
          SizedBox(height: 8),
          Text(
            '${LocaleKeys.sign_up_page_email.tr} : ${_controller.emailController.text}',
            style: TextStyle(fontSize: 17),
          ),
          SizedBox(height: 8),
          Text(
            '${LocaleKeys.sign_up_page_phone_number.tr} : ${_controller.phoneController.text}',
            style: TextStyle(fontSize: 17),
          ),
          SizedBox(height: 8),
          Text(
            '${LocaleKeys.sign_up_page_username.tr} : ${_controller.userNameController.text}',
            style: TextStyle(fontSize: 17),
          ),
          SizedBox(height: 8),
          Text(
            '${LocaleKeys.sign_up_page_gender.tr} : ${(_controller.gender.value) == Gender.Male ? 'Male' : 'Female'}',
            style: TextStyle(fontSize: 17),
          ),
        ],
      ),
    );
  }

  Widget buttonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            LocaleKeys.sign_up_page_back_button.tr,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            UserModel user = UserModel();
            _controller.addUser(user);
          },
          child: Text(
            LocaleKeys.sign_up_page_confirm_button.tr,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }

  SignUpController get _controller => Get.find<SignUpController>();
}
