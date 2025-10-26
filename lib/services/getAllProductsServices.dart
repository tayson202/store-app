import 'package:demo_app/MODELS/Product_model.dart';
import 'package:demo_app/helper/api.dart';

class Allproductsservices {
  // ignore: non_constant_identifier_names
  Future<List<ProductModel>> GetAllProducts() async {
    // ignore: missing_required_param
    List<dynamic> data = await Api().get(
      Url: 'https://fakestoreapi.com/products',
    );
    List<ProductModel> productslist = [];
    for (int i = 0; i < data.length; i++) {
      productslist.add(ProductModel.formjson(data[i]));
    }
    return productslist;
  }
}
