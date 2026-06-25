import 'dart:convert';
import 'package:demo_app/controllers/cart_controller.dart';
import 'package:demo_app/controllers/product.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WishlistController extends GetxController {
  final _storage = GetStorage();
  final _storageKey = 'wishlist_items';
  
  // Track favorite product names for efficient lookup/storage
  final RxList<String> favoriteProductNames = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadWishlist();
  }

  void _loadWishlist() {
    try {
      final storedData = _storage.read<String>(_storageKey);
      if (storedData != null) {
        final List<dynamic> decoded = jsonDecode(storedData);
        favoriteProductNames.assignAll(decoded.cast<String>());
      }
    } catch (e) {
      Get.log("Error loading wishlist: $e");
    }
  }

  void _saveWishlist() {
    try {
      final String encoded = jsonEncode(favoriteProductNames.toList());
      _storage.write(_storageKey, encoded);
    } catch (e) {
      Get.log("Error saving wishlist: $e");
    }
  }

  bool isFavorite(Product product) {
    return favoriteProductNames.contains(product.name);
  }

  void toggleFavorite(Product product) {
    if (favoriteProductNames.contains(product.name)) {
      favoriteProductNames.remove(product.name);
    } else {
      favoriteProductNames.add(product.name);
    }
    _saveWishlist();
  }

  void clearWishlist() {
    favoriteProductNames.clear();
    _saveWishlist();
  }

  void addAllToCart(CartController cartController) {
    for (var productName in favoriteProductNames) {
      // Find product in local list
      final product = products.firstWhereOrNull((p) => p.name == productName);
      if (product != null) {
        cartController.addProduct(product, 'M'); // default size 'M'
      }
    }
    clearWishlist();
  }
}
