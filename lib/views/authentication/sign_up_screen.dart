import 'package:final_project/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:final_project/controllers/sign_up_controller.dart';
import 'package:final_project/views/authentication/second_sign_up_screen.dart';

class SignUpScreen extends StatelessWidget {

  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    final _pageColor = Colors.pink;
    // Get.lazyPut<SignUpController>(() => SignUpController());

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: signUpScreenBody(_screenSize, _pageColor),
    );
  }

  Widget signUpScreenBody(Size _screenSize, MaterialColor _pageColor) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: _screenSize.width,
          height: _screenSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              signUpIcon(_screenSize, _pageColor),
              signUpForm(_screenSize, _pageColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget signUpForm(Size _screenSize, MaterialColor _pageColor) {
    return Container(
      height: _screenSize.height * 0.75,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _pageColor.shade50,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(56),
          topLeft: Radius.circular(56),
        ),
      ),
      child: Obx(() =>  signUpFormBody()),
    );
  }

  Widget signUpFormBody() {
    return Form(
      key: signUpFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 16),
          usernameField(),
          SizedBox(height: 16),
          passwordField(),
          SizedBox(height: 16),
          passwordConfirmField(),
          SizedBox(height: 16),
          fullNameField(),
          SizedBox(height: 16),
          emailField(),
          SizedBox(height: 16),
          phoneField(),
          SizedBox(height: 16),
          buttonRow(),
          SizedBox(height: 16),
        ],
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

  TextFormField usernameField() {
    return TextFormField(
      controller: _controller.userNameController,
      validator: (String value) {
        if (value.isEmpty) {
          return LocaleKeys.sign_up_page_empty_username.tr;
        } else {
          return null;
        }
      },
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15),
        isDense: true,
        hintText: LocaleKeys.sign_up_page_username.tr,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  TextFormField passwordField() {
    return TextFormField(
      controller: _controller.passController,
      validator: (String value) {
        if (value.isEmpty) {
          return LocaleKeys.sign_up_page_empty_password.tr;
        } else if (value.length < 6) {
          return 'password must be more than 6';
        } else {
          return null;
        }
      },
      style: TextStyle(fontSize: 20),
      obscureText: (!_controller.isPasswordShow.value),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15),
        isDense: true,
        hintText: LocaleKeys.sign_up_page_password.tr,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        suffixIcon: IconButton(
          icon: (!_controller.isPasswordShow.value)
              ? Icon(
            Icons.visibility_off,
            color: Color(0xff707070),
          )
              : Icon(
            Icons.visibility,
            color: Color(0xff707070),
          ),
          onPressed: () {
            _controller.isPasswordShow.value =
            (!_controller.isPasswordShow.value);
          },
        ),
      ),
    );
  }

  TextFormField passwordConfirmField() {
    return TextFormField(
      controller: _controller.passConfirmController,
      validator: (String value) {
        if (value.isEmpty) {
          return LocaleKeys.sign_up_page_empty_password.tr;
        } else if (value.length < 6) {
          return LocaleKeys.sign_up_page_password_length.tr;
        } else if(value != _controller.passController.text) {
          return LocaleKeys.sign_up_page_password_match.tr;
        } else {
          return null;
        }
      },
      style: TextStyle(fontSize: 20),
      obscureText: (!_controller.isPasswordConfirmShow.value),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15),
        isDense: true,
        hintText: LocaleKeys.sign_up_page_confirm_password.tr,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        suffixIcon: IconButton(
          icon: (!_controller.isPasswordConfirmShow.value)
              ? Icon(
            Icons.visibility_off,
            color: Color(0xff707070),
          )
              : Icon(
            Icons.visibility,
            color: Color(0xff707070),
          ),
          onPressed: () {
            _controller.isPasswordConfirmShow.value =
            (!_controller.isPasswordConfirmShow.value);
          },
        ),
      ),
    );
  }

  TextFormField fullNameField() {
    return TextFormField(
      controller: _controller.fullNameController,
      validator: (String value) {
        if (value.isEmpty) {
          return LocaleKeys.sign_up_page_empty_full_name.tr;
        } else {
          return null;
        }
      },
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15),
        isDense: true,
        hintText: LocaleKeys.sign_up_page_full_name.tr,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  TextFormField emailField() {
    return TextFormField(
      controller: _controller.emailController,
      validator: (String value) {
        if (value.isEmpty) {
          return LocaleKeys.sign_up_page_empty_email.tr;
        } else {
          return null;
        }
      },
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15),
        isDense: true,
        hintText: LocaleKeys.sign_up_page_email.tr,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  TextFormField phoneField() {
    return TextFormField(
      controller: _controller.phoneController,
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return LocaleKeys.sign_up_page_empty_phone.tr;
        } else {
          return null;
        }
      },
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15),
        isDense: true,
        hintText: LocaleKeys.sign_up_page_phone_number.tr,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget buttonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            if (signUpFormKey.currentState.validate()) {
              Get.to(() => SecondSignUpScreen());
            }
          },
          child: Text(
            LocaleKeys.sign_up_page_next_button.tr,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),

      ],
    );
  }

  // SignUpController get _controller => Get.find<SignUpController>();
  final _controller = Get.put(SignUpController());

}
