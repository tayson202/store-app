import 'dart:ffi';

class ProductModel {
  final int id;
  final String title;
  final Double price;
  final String decreption;
  final String image;
  final RatingModel rating;

  ProductModel({
    required this.id,
    required this.decreption,
    required this.image,
    required this.price,
    required this.title,
    required this.rating,
  });

  factory ProductModel.formjson(jsonData) {
    return ProductModel(
      id: jsonData['id'],
      decreption: jsonData['description'],
      image: jsonData['image'],
      price: jsonData['price'],
      title: jsonData['title'],
      rating: RatingModel.fromjson(jsonData['rating']),
    );
  }
}

class RatingModel {
  final Double rate;
  final int count;
  RatingModel({required this.rate, required this.count});
  factory RatingModel.fromjson(jsonData) {
    return RatingModel(rate: jsonData['rate'], count: jsonData['count']);
  }
}
