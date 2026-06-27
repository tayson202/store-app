import 'package:demo_app/features/seller/models/seller_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SellerController extends GetxController {
  final _storage = GetStorage();

  final Rx<SellerModel?> sellerProfile = Rx<SellerModel?>(null);
  final RxList<String> selectedCategories = <String>[].obs;
  final RxInt currentTabIndex = 0.obs;

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

  @override
  void onInit() {
    super.onInit();
    _loadProfile();
  }

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
