import 'package:demo_app/MODELS/Product_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class customcard extends StatelessWidget {
  customcard({Key? key, required this.product}) : super(key: key);
  ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 40,
                color: Colors.blueGrey,
                spreadRadius: 0,
                offset: Offset(10, 10),
              ),
            ],
          ),
          child: Card(
            elevation: 10,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title.substring(0, 6),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        r"$"
                        "${product.price.toString()}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Icon(Icons.favorite, color: Colors.red),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 25,
          top: -60,
          child: Image.network(product.image, width: 100, height: 100),
        ),
      ],
    );
  }
}
