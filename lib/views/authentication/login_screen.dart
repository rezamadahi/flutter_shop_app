import 'package:final_project/generated/locales.g.dart';
import 'package:final_project/views/authentication/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:final_project/controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Get.lazyPut<LoginController>(() => LoginController());
    Size _screenSize = MediaQuery.of(context).size;
    final _pageColor = Colors.pink;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: loginScreenBody(_screenSize, _pageColor),
    );
  }

  Widget loginScreenBody(Size _screenSize, MaterialColor _pageColor) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: _screenSize.width,
          height: _screenSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              loginIcon(_screenSize, _pageColor),
              Container(
                height: _screenSize.height * 0.65,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: _pageColor.shade50,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(56),
                    topLeft: Radius.circular(56),
                  ),
                ),
                child: Obx(() => loginForm()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginIcon(Size _screenSize, MaterialColor _pageColor) {
    return Container(
      height: _screenSize.height * 0.3,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
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
                LocaleKeys.login_page_login.tr,
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

  Widget loginForm() {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: <Widget>[
          SizedBox(height: 36),
          usernameField(),
          SizedBox(height: 16),
          passwordField(),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {},
            child: Text(
              LocaleKeys.login_page_forget_password.tr,
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 16,
              ),
            ),
          ),
          buttonRow(),
        ],
      ),
    );
  }

  Widget buttonRow() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: _controller.pageLoading()
                ? null
                : () {
                    if (formKey.currentState.validate()) {
                      _controller.userValidate(
                          _controller.userNameController.text.trim(),
                          _controller.passController.text.trim());
                    }
                  },
            child: Text(
              // 'Login'
              LocaleKeys.login_page_login.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => SignUpScreen());
            },
            child: Text(
              // 'Sign up'
              LocaleKeys.login_page_sign_up.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField passwordField() {
    return TextFormField(
      controller: _controller.passController,
      validator: (String value) {
        if (value.isEmpty) {
          return LocaleKeys.login_page_empty_password.tr;
        } else if (value.length < 6) {
          return LocaleKeys.login_page_password_length.tr;
        } else {
          return null;
        }
      },
      style: TextStyle(fontSize: 20),
      obscureText: (!_controller.isPasswordShow.value),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(15),
        hintText: LocaleKeys.login_page_password.tr,
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

  TextFormField usernameField() {
    return TextFormField(
      controller: _controller.userNameController,
      validator: (String value) {
        if (value.isEmpty) {
          return LocaleKeys.login_page_empty_username.tr;
        } else {
          return null;
        }
      },
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15),
        isDense: true,
        hintText: LocaleKeys.login_page_username.tr,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  // LoginController get _controller => Get.find<LoginController>();
  final _controller = Get.put(LoginController());
}
