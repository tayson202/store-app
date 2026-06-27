import 'package:demo_app/features/seller/models/seller_model.dart';
import 'package:demo_app/controllers/product.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SellerController extends GetxController {
  final _storage = GetStorage();

  final Rx<SellerModel?> sellerProfile = Rx<SellerModel?>(null);
  final RxList<String> selectedCategories = <String>[].obs;
  final RxInt currentTabIndex = 0.obs;
  final RxList<Product> myProducts = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadProfile();
    _loadMyProducts();
  }

  void _loadMyProducts() {
    // Load some mock products for the seller initially if none saved
    final stored = _storage.read('myProducts');
    if (stored != null) {
      final List list = stored;
      myProducts.assignAll(list.map((item) => Product.fromJson(Map<String, dynamic>.from(item))).toList());
    } else {
      // Seed with some of the global products
      myProducts.assignAll(products.take(2).toList());
      _saveMyProductsToStorage();
    }
  }

  void _saveMyProductsToStorage() {
    _storage.write('myProducts', myProducts.map((p) => p.toJson()).toList());
  }

  void addProduct(Product product) {
    myProducts.add(product);
    // Also add to global list if it's not already there
    if (!products.any((p) => p.name == product.name)) {
      products.add(product);
    }
    _saveMyProductsToStorage();
  }

  void updateProduct(int index, Product updated) {
    if (index >= 0 && index < myProducts.length) {
      final oldProduct = myProducts[index];
      myProducts[index] = updated;

      // Update in global list too
      final gIdx = products.indexWhere((p) => p.name == oldProduct.name);
      if (gIdx != -1) {
        products[gIdx] = updated;
      }
      _saveMyProductsToStorage();
    }
  }

  void deleteProduct(Product product) {
    myProducts.removeWhere((p) => p.name == product.name);
    products.removeWhere((p) => p.name == product.name);
    _saveMyProductsToStorage();
  }

  static const List<String> availableCategories = [
    'Electronics',
    'Clothing & Fashion',
    'Food & Drinks',
    'Beauty & Care',
    'Home & Living',
    'Sports & Outdoors',
    'Toys & Games',
    'Books & Stationery',
    'Automotive',
    'Health & Wellness',
    'Jewelry & Accessories',
    'Other',
  ];

  void _loadProfile() {
    final data = _storage.read('sellerProfile');
    if (data != null) {
      sellerProfile.value = SellerModel.fromMap(Map<String, dynamic>.from(data));
      selectedCategories.assignAll(sellerProfile.value!.categories);
    }
  }

  void saveProfile(SellerModel model) {
    sellerProfile.value = model;
    _storage.write('sellerProfile', model.toMap());
  }

  void toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  bool isCategorySelected(String category) =>
      selectedCategories.contains(category);

  void changeTab(int index) => currentTabIndex.value = index;
}
