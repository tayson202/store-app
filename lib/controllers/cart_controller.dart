import 'dart:convert';
import 'package:demo_app/controllers/product.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartItem {
  final Product product;
  int quantity;
  final String size;

  CartItem({
    required this.product,
    this.quantity = 1,
    required this.size,
  });

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
      'size': size,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'] as int,
      size: json['size'] as String,
    );
  }
}

class CartController extends GetxController {
  final _storage = GetStorage();
  final _storageKey = 'cart_items';
  final RxList<CartItem> cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadCart();
  }

  void _loadCart() {
    try {
      final storedData = _storage.read<String>(_storageKey);
      if (storedData != null) {
        final List<dynamic> decoded = jsonDecode(storedData);
        cartItems.assignAll(
          decoded.map((item) => CartItem.fromJson(item as Map<String, dynamic>)).toList(),
        );
      }
    } catch (e) {
      Get.log("Error loading cart: $e");
    }
  }

  void _saveCart() {
    try {
      final String encoded = jsonEncode(cartItems.map((item) => item.toJson()).toList());
      _storage.write(_storageKey, encoded);
    } catch (e) {
      Get.log("Error saving cart: $e");
    }
  }

  void addProduct(Product product, String size) {
    final existingIndex = cartItems.indexWhere(
      (item) => item.product.name == product.name && item.size == size,
    );

    if (existingIndex != -1) {
      cartItems[existingIndex].quantity += 1;
      cartItems.refresh();
    } else {
      cartItems.add(CartItem(product: product, quantity: 1, size: size));
    }
    _saveCart();
  }

  void removeProduct(Product product, String size) {
    cartItems.removeWhere(
      (item) => item.product.name == product.name && item.size == size,
    );
    _saveCart();
  }

  void decreaseQuantity(Product product, String size) {
    final existingIndex = cartItems.indexWhere(
      (item) => item.product.name == product.name && item.size == size,
    );

    if (existingIndex != -1) {
      if (cartItems[existingIndex].quantity > 1) {
        cartItems[existingIndex].quantity -= 1;
        cartItems.refresh();
        _saveCart();
      } else {
        removeProduct(product, size);
      }
    }
  }

  void clearCart() {
    cartItems.clear();
    _saveCart();
  }

  double get totalAmount {
    double total = 0.0;
    for (var item in cartItems) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  int get totalItemsCount {
    int count = 0;
    for (var item in cartItems) {
      count += item.quantity;
    }
    return count;
  }
}
