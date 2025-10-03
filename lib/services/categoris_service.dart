import 'package:demo_app/MODELS/Product_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CategorisService {
  Future<List<ProductModel>> getCategorisProducts({
    required String categoryname,
  }) async {
    http.Response response = await http.get(
      Uri.parse('https://fakestoreapi.com/products/category/$categoryname'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<ProductModel> productslist = [];
      for (int i = 0; i < data.length; i++) {
        productslist.add(ProductModel.formjson(data[i]));
      }
      return productslist;
    } else {
      throw Exception("eror with status code${response.statusCode}");
    }
  }
}
