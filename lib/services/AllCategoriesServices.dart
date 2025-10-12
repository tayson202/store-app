import 'package:demo_app/helper/api.dart';

class Allcategoriesservices {
  Future<List<dynamic>> getAllcategories() async {
    // ignore: missing_required_param
    List<dynamic> data = await api().get(
      Url: 'https://fakestoreapi.com/products/categories',
    );

    return data;
  }
}
