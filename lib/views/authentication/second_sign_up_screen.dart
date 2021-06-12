import 'package:final_project/models/user_model.dart';
import 'package:final_project/views/authentication/third_sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:final_project/controllers/sign_up_controller.dart';
import 'package:final_project/generated/locales.g.dart';

class SecondSignUpScreen extends StatelessWidget {

  final GlobalKey<FormState> secondSignUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    final _pageColor = Colors.pink;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: secondSignUpScreenBody(_screenSize, _pageColor),
    );
  }

  Widget secondSignUpScreenBody(Size _screenSize, MaterialColor _pageColor) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: _screenSize.width,
          height: _screenSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              signUpIcon(_screenSize, _pageColor),
              secondSignUpForm(_screenSize, _pageColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget secondSignUpForm(Size _screenSize, MaterialColor _pageColor) {
    return Container(
      height: _screenSize.height * 0.78,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _pageColor.shade50,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(56),
          topLeft: Radius.circular(56),
        ),
      ),
      child: Obx(() => secondSignUpFormBody()),
    );
  }

  Widget secondSignUpFormBody() {
    return Form(
      key: secondSignUpFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 16),
          addressField(),
          SizedBox(height: 16),
          gender(),
          SizedBox(height: 16),
          profileImage(),
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
                'Sign Up',
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

  TextFormField addressField() {
    return TextFormField(
      controller: _controller.addressController,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      minLines: 1,
      maxLines: 5,
      validator: (String value) {
        if (value.isEmpty) {
          return LocaleKeys.sign_up_page_empty_address.tr;
        } else {
          return null;
        }
      },
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(16),
        isDense: true,
        hintText: LocaleKeys.sign_up_page_address.tr,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget gender() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff707070), width: 1.0),
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            LocaleKeys.sign_up_page_gender.tr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Radio(
                value: Gender.Male,
                groupValue: _controller.gender.value,
                onChanged: (val) {
                  _controller.gender(val);
                },
              ),
              Text(LocaleKeys.sign_up_page_male.tr),
            ],
          ),
          Row(
            children: [
              Radio(
                  value: Gender.Female,
                  groupValue: _controller.gender.value,
                  onChanged: (val) {
                    _controller.gender(val);
                  }),
              Text(LocaleKeys.sign_up_page_female.tr),
            ],
          ),
        ],
      ),
    );
  }

  Widget profileImage() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff707070), width: 1.0),
        borderRadius: BorderRadius.circular(16.0),
      ),
      width: double.infinity,
      height: 150,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _controller.isImageLoaded.value
                ? CircleAvatar(
                    child: Image.asset('assets/images/avatar.png'),
                  )
                : (_controller.image == null
                    ? CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white60,
                        child: Icon(
                          Icons.person,
                          size: 48,
                          color: Colors.grey,
                        ),
                      )
                    : Image.file(_controller.image)),
          ),
          GestureDetector(
            child: Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              child: Icon(
                Icons.add,
                color: Colors.black,
                size: 30,
              ),
            ),
            onTap: () {
              _controller.getImage();
            },
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
            if (secondSignUpFormKey.currentState.validate()) {
              Get.to(() => ThirdSignUpScreen());
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
