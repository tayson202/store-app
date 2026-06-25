class Product {
  final String name;
  final String category;
  final double price;
  final double? oldprice;
  final String imageurl;
  final bool isfavorite;
  final String description;

  const Product({
    required this.category,
    required this.description,
    required this.imageurl,
    required this.isfavorite,
    required this.name,
    required this.oldprice,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'price': price,
      'oldprice': oldprice,
      'imageurl': imageurl,
      'isfavorite': isfavorite,
      'description': description,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String,
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      oldprice: json['oldprice'] != null ? (json['oldprice'] as num).toDouble() : null,
      imageurl: json['imageurl'] as String,
      isfavorite: json['isfavorite'] as bool? ?? false,
      description: json['description'] as String,
    );
  }
}

final List<Product> products = [
  const Product(
    name: 'skelton',
    category: 'creatine',
    price: 1000.00,
    oldprice: 1100.00,
    imageurl: 'asset/OIP.webp',
    description: 'product1',
    isfavorite: true,
  ),
  const Product(
    name: 'onerow',
    category: 'creatine',
    price: 900.00,
    oldprice: 1200.00,
    imageurl: 'asset/OIP (1).webp',
    description: 'product2',
    isfavorite: true,
  ),
  const Product(
    name: 'muscleseed',
    category: 'protine',
    price: 1300.00,
    oldprice: 1700.00,
    imageurl: 'asset/OIP (1).webp',
    description: 'product3',
    isfavorite: true,
  ),
  const Product(
    name: 'mavinpants ',
    category: 'pants',
    price: 800.00,
    oldprice: 1000.00,
    imageurl: 'asset/OIP.webp',
    description: 'product4',
    isfavorite: true,
  ),
];
