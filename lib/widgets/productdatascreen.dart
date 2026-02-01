import 'package:demo_app/controllers/product.dart';
import 'package:demo_app/widgets/sizeselector.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class productdatascreen extends StatelessWidget {
  final Product product;
  const productdatascreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    final screenhight = screensize.height;
    final screenwidth = screensize.width;
    final isdark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: isdark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          'details',
          style: AppTextStyles.withColor(
            AppTextStyles.h3,
            isdark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                shareproduct(context, product.name, product.description),
            icon: Icon(
              Icons.share,
              color: isdark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    product.imageurl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 16,
                  right: 16,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      product.isfavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: product.isfavorite
                          ? Theme.of(context).primaryColor
                          : (isdark ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(screenwidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: AppTextStyles.withColor(
                            AppTextStyles.h2,
                            Theme.of(context).textTheme.headlineMedium!.color!,
                          ),
                        ),
                      ),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: AppTextStyles.withColor(
                          AppTextStyles.h2,
                          Theme.of(context).textTheme.headlineMedium!.color!,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    product.category,
                    style: AppTextStyles.withColor(
                      AppTextStyles.bodymid,
                      isdark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                  SizedBox(height: screenhight * 0.02),
                  Text(
                    'select size',
                    style: AppTextStyles.withColor(
                      AppTextStyles.labelmid,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                  SizedBox(height: screenhight * 0.01),
                  //size selector
                  const Sizeselector(),
                  SizedBox(height: screenhight * 0.02),
                  Text(
                    'description',
                    style: AppTextStyles.withColor(
                      AppTextStyles.labelmid,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                  SizedBox(height: screenhight * 0.01),
                  Text(
                    product.description,
                    style: AppTextStyles.withColor(
                      AppTextStyles.bodysmall,
                      isdark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenwidth * 0.04),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: screenhight * 0.02),
                    side: BorderSide(
                      color: isdark ? Colors.white : Colors.black,
                    ),
                  ),
                  child: Text(
                    'add to cart',
                    style: AppTextStyles.withColor(
                      AppTextStyles.buttonmid,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenwidth * 0.04),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: screenhight * 0.02),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    'buy now',
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
    );
  }
}

//share product
Future<void> shareproduct(
  BuildContext context,
  String productname,
  String description,
) async {
  final box = context.findRenderObject() as RenderBox?;
  const String shoplink = 'https://';
  final String sharemessage = '$description\n\nshop now at $shoplink';

  try {
    final ShareResult result = await Share.share(
      sharemessage,
      subject: productname,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );

    if (result.status == ShareResultStatus.success) {
      debugPrint('thank u 4 sharing');
    }
  } catch (e) {
    debugPrint('error sharing: $e');
  }
}
