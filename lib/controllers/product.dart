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
