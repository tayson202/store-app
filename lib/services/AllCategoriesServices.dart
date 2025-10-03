import 'package:demo_app/helper/api.dart';

class Allcategoriesservices {
  Future<List<dynamic>> getAllcategories() async {
    List<dynamic> data = await api().get(
      Url: 'https://fakestoreapi.com/products/categories',
    );

    return data;
  }
}
