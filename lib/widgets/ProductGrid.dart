import 'package:demo_app/controllers/product.dart';
import 'package:demo_app/widgets/productcard.dart';
import 'package:flutter/material.dart';

class Productgrid extends StatelessWidget {
  const Productgrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () {},
          child: Productcard(product: product),
        );
      },
    );
  }
}
