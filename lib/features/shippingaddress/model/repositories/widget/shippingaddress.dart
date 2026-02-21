import 'package:demo_app/features/shippingaddress/model/address.dart';
import 'package:demo_app/features/shippingaddress/model/repositories/widget/addresscard.dart';
import 'package:demo_app/features/shippingaddress/model/repositories/widget/addressrepository.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Shippingaddress extends StatelessWidget {
  final Addressrepository repository = Addressrepository();
  Shippingaddress({super.key});

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
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
            onPressed: () => showaddaddressnottomsheets(context),
            icon: Icon(
              Icons.add_circle_outline,
              color: isdark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: repository.getaddress().length,
        itemBuilder: (context, index) => buildaddresscard(context, index),
      ),
    );
  }

  Widget buildaddresscard(BuildContext context, int index) {
    final Address = repository.getaddress()[index];
    return Addresscard(
      address: Address,
      onedit: () => showeditaddressbottomsheet(context, Address),
      ondelete: () => showdeleteconfirmation(context),
    );
  }

  void showeditaddressbottomsheet(BuildContext context, Address address) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
              initialvalue: address.label,
            ),
            const SizedBox(height: 16),
            buildtextfield(
              context,
              'full address',
              Icons.location_on_outlined,
              initialvalue: address.fulladdress,
            ),
            const SizedBox(height: 16),
            buildtextfield(
              context,
              'city ',
              Icons.location_city_outlined,
              initialvalue: address.city,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: buildtextfield(
                    context,
                    'state',
                    Icons.map_outlined,
                    initialvalue: address.state,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: buildtextfield(
                    context,
                    'zipcode',
                    Icons.pin_outlined,
                    initialvalue: address.zipcode,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
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
            const SizedBox(width: 16),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void showdeleteconfirmation(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
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
                color: Colors.red.withOpacity(0.1),
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
                      Get.back();
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
    String? initialvalue,
  }) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      initialValue: initialvalue,
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

  void showaddaddressnottomsheets(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
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
            ),
            const SizedBox(height: 16),
            buildtextfield(context, 'full address', Icons.location_on_outlined),
            const SizedBox(height: 16),
            buildtextfield(context, 'city', Icons.location_city_outlined),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: buildtextfield(context, 'state', Icons.map_outlined),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: buildtextfield(context, 'zipcode', Icons.pin_outlined),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
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
    );
  }
}
