import 'package:demo_app/MODELS/Product_model.dart';
import 'package:demo_app/services/getAllProductsServices.dart';
import 'package:demo_app/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  static String id = 'home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart, color: Colors.black),
          ),
        ],
        backgroundColor: Colors.indigo,
        elevation: 0,
        centerTitle: true,
        title: Text('GyMuNiTy', style: TextStyle(color: Colors.black)),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 60),
        child: FutureBuilder<List<ProductModel>>(
          future: Allproductsservices().GetAllProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ProductModel>? products = snapshot.data;
              return GridView.builder(
                itemCount: products!.length,
                clipBehavior: Clip.none,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 50,
                ),
                itemBuilder: (context, index) {
                  return customcard(product: products[index]);
                },
              );
            } else {
              return Center(child: CircleAvatar());
            }
          },
        ),
      ),
    );
  }
}

/*class customcard extends StatelessWidget {
  const customcard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 120,
          width: 220,
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
                    "CREATINE",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(r"$255", style: TextStyle(fontSize: 16)),
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
          top: -65,
          child: Image.network(
            'https://m.media-amazon.com/images/I/61tjQ5vDhwL._AC_SL1200_.jpg',
            height: 100,
          ),
        ),
      ],
    );
  }
}*/
