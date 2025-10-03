import 'dart:convert';

import 'package:demo_app/MODELS/Product_model.dart';
import 'package:http/http.dart' as http;

class Allproductsservices {
  Future<List<ProductModel>> GetAllProducts() async {
    http.Response response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );

    List<dynamic> data = jsonDecode(response.body);
    List<ProductModel> productslist = [];
    for (int i = 0; i < data.length; i++) {
      productslist.add(ProductModel.formjson(data[i]));
    }
    return productslist;
  }
}
