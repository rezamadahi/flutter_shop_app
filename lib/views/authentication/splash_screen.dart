import 'package:final_project/controllers/splash_controller.dart';
import 'package:final_project/views/product/products_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    delayTimer();
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<SplashController>(() => SplashController());
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: splashScreenBody());
  }

  Widget splashScreenBody() {
    return SafeArea(
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.centerLeft,
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 80),
                  child: Image.asset('assets/images/welcome.png'),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ),
            )
          ],
        ),
      );
  }

  Future<void> delayTimer() async {
    await Future.delayed(Duration(seconds: 6));
    final box = GetStorage();
    if(box.read("userId") != null){
      Get.off(ProductsListScreen());
    }else{
      _controller.isAdminExist();
    }
  }

  SplashController get _controller => Get.find<SplashController>();

}
