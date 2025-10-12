import 'package:demo_app/MODELS/Product_model.dart';
import 'package:demo_app/helper/api.dart';

class CategorisService {
  Future<List<ProductModel>> getCategorisProducts({
    required String categoryname,
  }) async {
    // ignore: missing_required_param
    List<dynamic> data = await api().get(
      Url: 'https://fakestoreapi.com/products/category/$categoryname',
    );

    List<ProductModel> productslist = [];
    for (int i = 0; i < data.length; i++) {
      productslist.add(ProductModel.formjson(data[i]));
    }
    return productslist;
  }
}
