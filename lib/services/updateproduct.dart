/*import 'package:demo_app/MODELS/Product_model.dart';
import 'package:demo_app/helper/api.dart';

class Updateproduct {
  Future<ProductModel> updateProduct({
    required int id,
    required String title,
    required String prices,
    required String desc,
    required String image,
    required String category,
  }) async {
    // ignore: missing_required_param
    Map<String, dynamic> data = await Api().post(
      url: 'https://fakestoreapi.com/products/$id', // <-- include id here
      body: {
        'title': title,
        'price': prices,
        'description': desc,
        'image': image,
        'category': category,
      },
    );

    return ProductModel.formjson(data);
  }
}*/
