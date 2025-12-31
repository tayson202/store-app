import 'package:demo_app/controllers/authcontroller.dart';
import 'package:demo_app/controllers/navigation_controller.dart';
import 'package:demo_app/controllers/themecontroll.dart';
import 'package:demo_app/view/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  Get.put(Themecontroll());
  Get.put(Authcontroller());
  Get.put(NavigationController());
  runApp(const StoreApp());
}

/*void main() {
  runApp(const StoreApp());
}*/

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Themecontroll themeController = Get.find<Themecontroll>();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "gymunity",
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeController.theme,
      defaultTransition: Transition.fade,
      home: Splashscreen(),
      /*routes: {
        Home.id: (context) => Home(),
        UpdatePage.id: (context) => UpdatePage(),
      },
      initialRoute: Home.id,*/
    );
  }
}
