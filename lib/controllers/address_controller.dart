import 'dart:convert';
import 'package:demo_app/features/shippingaddress/model/address.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AddressController extends GetxController {
  final _storage = GetStorage();
  final _storageKey = 'shipping_addresses';
  final RxList<Address> addresses = <Address>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadAddresses();
  }

  void _loadAddresses() {
    try {
      final storedData = _storage.read<String>(_storageKey);
      if (storedData != null) {
        final List<dynamic> decoded = jsonDecode(storedData);
        addresses.assignAll(
          decoded.map((item) => Address.fromJson(item as Map<String, dynamic>)).toList(),
        );
      } else {
        // Seed default addresses
        addresses.assignAll([
          const Address(
            id: '1',
            label: 'home',
            fulladdress: '123 main street',
            city: 'ismailia',
            state: 'ism',
            zipcode: '461611',
            isdefault: true,
            type: Addresstype.home,
          ),
          const Address(
            id: '2',
            label: 'office',
            fulladdress: '657 main street',
            city: 'cairo',
            state: 'cairo',
            zipcode: '465411',
            isdefault: false,
            type: Addresstype.office,
          ),
        ]);
        _saveAddresses();
      }
    } catch (e) {
      Get.log("Error loading addresses: $e");
    }
  }

  void _saveAddresses() {
    try {
      final String encoded = jsonEncode(addresses.map((item) => item.toJson()).toList());
      _storage.write(_storageKey, encoded);
    } catch (e) {
      Get.log("Error saving addresses: $e");
    }
  }

  void addAddress(Address address) {
    if (address.isdefault) {
      // Clear previous default
      for (int i = 0; i < addresses.length; i++) {
        if (addresses[i].isdefault) {
          addresses[i] = _copyWith(addresses[i], isdefault: false);
        }
      }
    }
    addresses.add(address);
    _saveAddresses();
  }

  void updateAddress(Address address) {
    final index = addresses.indexWhere((item) => item.id == address.id);
    if (index != -1) {
      if (address.isdefault) {
        for (int i = 0; i < addresses.length; i++) {
          if (addresses[i].isdefault && i != index) {
            addresses[i] = _copyWith(addresses[i], isdefault: false);
          }
        }
      }
      addresses[index] = address;
      addresses.refresh();
      _saveAddresses();
    }
  }

  void deleteAddress(String id) {
    final index = addresses.indexWhere((item) => item.id == id);
    if (index != -1) {
      final bool wasDefault = addresses[index].isdefault;
      addresses.removeAt(index);
      if (wasDefault && addresses.isNotEmpty) {
        addresses[0] = _copyWith(addresses[0], isdefault: true);
      }
      _saveAddresses();
    }
  }

  void setDefaultAddress(String id) {
    for (int i = 0; i < addresses.length; i++) {
      if (addresses[i].id == id) {
        addresses[i] = _copyWith(addresses[i], isdefault: true);
      } else if (addresses[i].isdefault) {
        addresses[i] = _copyWith(addresses[i], isdefault: false);
      }
    }
    addresses.refresh();
    _saveAddresses();
  }

  Address? get defaultAddress {
    return addresses.firstWhereOrNull((a) => a.isdefault) ?? (addresses.isNotEmpty ? addresses.first : null);
  }

  // Copy helper since Address class model variables are final and const constructor is used.
  Address _copyWith(
    Address original, {
    String? label,
    String? fulladdress,
    String? city,
    String? state,
    String? zipcode,
    bool? isdefault,
    Addresstype? type,
  }) {
    return Address(
      id: original.id,
      label: label ?? original.label,
      fulladdress: fulladdress ?? original.fulladdress,
      city: city ?? original.city,
      state: state ?? original.state,
      zipcode: zipcode ?? original.zipcode,
      isdefault: isdefault ?? original.isdefault,
      type: type ?? original.type,
    );
  }
}
