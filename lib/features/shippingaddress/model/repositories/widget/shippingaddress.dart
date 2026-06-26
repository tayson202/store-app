import 'package:demo_app/controllers/address_controller.dart';
import 'package:demo_app/features/shippingaddress/model/address.dart';
import 'package:demo_app/features/shippingaddress/model/repositories/widget/addresscard.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Shippingaddress extends StatelessWidget {
  const Shippingaddress({super.key});

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    final AddressController addressController = Get.find<AddressController>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: isdark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          'shipping address',
          style: AppTextStyles.withColor(
            AppTextStyles.h3,
            isdark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => showaddaddressbottomsheet(context),
            icon: Icon(
              Icons.add_circle_outline,
              color: isdark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (addressController.addresses.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_off_outlined,
                  size: 80,
                  color: isdark ? Colors.grey[700] : Colors.grey[300],
                ),
                const SizedBox(height: 24),
                Text(
                  'no addresses found',
                  style: AppTextStyles.withColor(
                    AppTextStyles.h2,
                    isdark ? Colors.grey[400]! : Colors.grey[600]!,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'tap the add button at the top to add a new address',
                  style: AppTextStyles.withColor(
                    AppTextStyles.bodymid,
                    isdark ? Colors.grey[500]! : Colors.grey[500]!,
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: addressController.addresses.length,
          itemBuilder: (context, index) {
            final address = addressController.addresses[index];
            return GestureDetector(
              onTap: () {
                addressController.setDefaultAddress(address.id);
                Get.snackbar(
                  'Default Address Changed',
                  '${address.label} is now your default address.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Theme.of(context).primaryColor,
                  colorText: Colors.white,
                  margin: const EdgeInsets.all(16),
                  borderRadius: 12,
                );
              },
              child: Addresscard(
                address: address,
                onedit: () => showeditaddressbottomsheet(context, address),
                ondelete: () => showdeleteconfirmation(context, address.id),
              ),
            );
          },
        );
      }),
    );
  }

  Widget buildaddresscard(BuildContext context, int index) {
    final AddressController addressController = Get.find<AddressController>();
    final addr = addressController.addresses[index];
    return Addresscard(
      address: addr,
      onedit: () => showeditaddressbottomsheet(context, addr),
      ondelete: () => showdeleteconfirmation(context, addr.id),
    );
  }

  void showeditaddressbottomsheet(BuildContext context, Address address) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    final AddressController addressController = Get.find<AddressController>();

    final labelController = TextEditingController(text: address.label);
    final addressControllerField = TextEditingController(text: address.fulladdress);
    final cityController = TextEditingController(text: address.city);
    final stateController = TextEditingController(text: address.state);
    final zipController = TextEditingController(text: address.zipcode);
    bool isDefaultValue = address.isdefault;

    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setStateSheet) => Container(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'edit address',
                      style: AppTextStyles.withColor(
                        AppTextStyles.h3,
                        Theme.of(context).textTheme.bodyLarge!.color!,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.close,
                        color: isdark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                buildtextfield(
                  context,
                  'label(e.g.home,office)',
                  Icons.label_outline,
                  controller: labelController,
                ),
                const SizedBox(height: 16),
                buildtextfield(
                  context,
                  'full address',
                  Icons.location_on_outlined,
                  controller: addressControllerField,
                ),
                const SizedBox(height: 16),
                buildtextfield(
                  context,
                  'city ',
                  Icons.location_city_outlined,
                  controller: cityController,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: buildtextfield(
                        context,
                        'state',
                        Icons.map_outlined,
                        controller: stateController,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: buildtextfield(
                        context,
                        'zipcode',
                        Icons.pin_outlined,
                        controller: zipController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  title: const Text("Set as Default Address"),
                  value: isDefaultValue,
                  onChanged: (val) {
                    setStateSheet(() {
                      isDefaultValue = val ?? false;
                    });
                  },
                  activeColor: Theme.of(context).primaryColor,
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final updated = Address(
                        id: address.id,
                        label: labelController.text.trim(),
                        fulladdress: addressControllerField.text.trim(),
                        city: cityController.text.trim(),
                        state: stateController.text.trim(),
                        zipcode: zipController.text.trim(),
                        isdefault: isDefaultValue,
                        type: labelController.text.trim().toLowerCase() == 'office'
                            ? Addresstype.office
                            : Addresstype.home,
                      );
                      addressController.updateAddress(updated);
                      Get.back();
                      Get.snackbar(
                        'Address Updated',
                        'Your changes have been saved.',
                        snackPosition: SnackPosition.BOTTOM,
                        margin: const EdgeInsets.all(16),
                        borderRadius: 12,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'update address',
                      style: AppTextStyles.withColor(
                        AppTextStyles.buttonmid,
                        Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  void showdeleteconfirmation(BuildContext context, String id) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    final AddressController addressController = Get.find<AddressController>();
    Get.dialog(
      AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_outline,
                color: Colors.red,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'delete address',
              style: AppTextStyles.withColor(
                AppTextStyles.h3,
                Theme.of(context).textTheme.bodyLarge!.color!,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'r u sure u want to delete this address',
              textAlign: TextAlign.center,
              style: AppTextStyles.withColor(
                AppTextStyles.bodymid,
                isdark ? Colors.grey[400]! : Colors.grey[600]!,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(
                        color: isdark ? Colors.grey[700]! : Colors.grey[300]!,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'cancel',
                      style: AppTextStyles.withColor(
                        AppTextStyles.buttonmid,
                        Theme.of(context).textTheme.bodyLarge!.color!,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      addressController.deleteAddress(id);
                      Get.back();
                      Get.snackbar(
                        'Address Deleted',
                        'Address removed from shipping details.',
                        snackPosition: SnackPosition.BOTTOM,
                        margin: const EdgeInsets.all(16),
                        borderRadius: 12,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'delete',
                      style: AppTextStyles.withColor(
                        AppTextStyles.buttonmid,
                        Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      barrierColor: Colors.black54,
    );
  }

  Widget buildtextfield(
    BuildContext context,
    String label,
    IconData icon, {
    required TextEditingController controller,
  }) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isdark ? Colors.grey[700]! : Colors.grey[300]!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isdark ? Colors.grey[700]! : Colors.grey[300]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  void showaddaddressbottomsheet(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    final AddressController addressController = Get.find<AddressController>();

    final labelController = TextEditingController();
    final addressControllerField = TextEditingController();
    final cityController = TextEditingController();
    final stateController = TextEditingController();
    final zipController = TextEditingController();
    bool isDefaultValue = false;

    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setStateSheet) => Container(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'add new address',
                      style: AppTextStyles.withColor(
                        AppTextStyles.h3,
                        Theme.of(context).textTheme.bodyLarge!.color!,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.close,
                        color: isdark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                buildtextfield(
                  context,
                  'label(e.g.,home,office)',
                  Icons.label_outline,
                  controller: labelController,
                ),
                const SizedBox(height: 16),
                buildtextfield(
                  context,
                  'full address',
                  Icons.location_on_outlined,
                  controller: addressControllerField,
                ),
                const SizedBox(height: 16),
                buildtextfield(
                  context,
                  'city',
                  Icons.location_city_outlined,
                  controller: cityController,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: buildtextfield(
                        context,
                        'state',
                        Icons.map_outlined,
                        controller: stateController,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: buildtextfield(
                        context,
                        'zipcode',
                        Icons.pin_outlined,
                        controller: zipController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  title: const Text("Set as Default Address"),
                  value: isDefaultValue,
                  onChanged: (val) {
                    setStateSheet(() {
                      isDefaultValue = val ?? false;
                    });
                  },
                  activeColor: Theme.of(context).primaryColor,
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final newAddress = Address(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        label: labelController.text.trim(),
                        fulladdress: addressControllerField.text.trim(),
                        city: cityController.text.trim(),
                        state: stateController.text.trim(),
                        zipcode: zipController.text.trim(),
                        isdefault: isDefaultValue,
                        type: labelController.text.trim().toLowerCase() == 'office'
                            ? Addresstype.office
                            : Addresstype.home,
                      );
                      addressController.addAddress(newAddress);
                      Get.back();
                      Get.snackbar(
                        'Address Added',
                        'New address saved to profile.',
                        snackPosition: SnackPosition.BOTTOM,
                        margin: const EdgeInsets.all(16),
                        borderRadius: 12,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'save address',
                      style: AppTextStyles.withColor(
                        AppTextStyles.buttonmid,
                        Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
