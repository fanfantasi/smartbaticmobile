import 'package:chat_apps/constanta/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'splashscreen_controller.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  SplashscreenController splashController = Get.put(SplashscreenController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
      ),
      child: Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          body: Column(
            children: [
              Expanded(
                flex: 4,
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 186,
                    height: 48.0,
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: splashController.version.value != '' &&
                      splashController.buildNumber.value != '',
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Text(
                      AppString.nameapps +
                          splashController.version.value +
                          ' (' +
                          splashController.buildNumber.value +
                          ')',
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
