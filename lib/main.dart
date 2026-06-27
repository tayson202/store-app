import 'package:demo_app/controllers/address_controller.dart';
import 'package:demo_app/controllers/authcontroller.dart';
import 'package:demo_app/controllers/cart_controller.dart';
import 'package:demo_app/controllers/navigation_controller.dart';
import 'package:demo_app/controllers/themecontroll.dart';
import 'package:demo_app/controllers/wishlist_controller.dart';
import 'package:demo_app/features/seller/controllers/seller_controller.dart';
import 'package:demo_app/features/reels/data/datasources/reel_remote_datasource_mock.dart';
import 'package:demo_app/features/reels/data/repositories/reel_repository_impl.dart';
import 'package:demo_app/features/reels/domain/repositories/reel_repository.dart';
import 'package:demo_app/features/reels/presentation/controllers/reel_feed_controller.dart';
import 'package:demo_app/features/reels/presentation/controllers/reel_interaction_controller.dart';
import 'package:demo_app/features/reels/presentation/controllers/reel_upload_controller.dart';
import 'package:demo_app/view/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  Get.put(Themecontroll());
  Get.put(Authcontroller());
  Get.put(NavigationController());
  Get.put(WishlistController());
  Get.put(CartController());
  Get.put(AddressController());
  Get.put(SellerController());

  // Reels Clean Architecture DI Setup
  final reelRepo = ReelRepositoryImpl(ReelRemoteDatasourceMock());
  Get.put<ReelRepository>(reelRepo);
  Get.put(ReelFeedController(reelRepo));
  Get.put(ReelInteractionController(reelRepo));
  Get.put(ReelUploadController(reelRepo));

  runApp(const StoreApp());
}

/*void main() {
  runApp(const StoreApp());
}*/

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Themecontroll>(
      builder: (themeController) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "gymunity",
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeController.theme,
        defaultTransition: Transition.fade,
        home: Splashscreen(),
      ),
    );
  }
}
