import 'package:demo_app/MODELS/Product_model.dart';
import 'package:demo_app/helper/api.dart';

class Allproductsservices {
  Future<List<ProductModel>> GetAllProducts() async {
    List<dynamic> data = await api().get(
      Url: 'https://fakestoreapi.com/products',
    );
    List<ProductModel> productslist = [];
    for (int i = 0; i < data.length; i++) {
      productslist.add(ProductModel.formjson(data[i]));
    }
    return productslist;
  }
}
