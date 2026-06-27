class SellerModel {
  String name;
  String email;
  String shopName;
  String phone;
  String address;
  String description;
  List<String> categories;
  String? photoUrl;

  SellerModel({
    required this.name,
    required this.email,
    required this.shopName,
    required this.phone,
    required this.address,
    required this.description,
    required this.categories,
    this.photoUrl,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'shopName': shopName,
        'phone': phone,
        'address': address,
        'description': description,
        'categories': categories,
        'photoUrl': photoUrl,
      };

  factory SellerModel.fromMap(Map<String, dynamic> map) => SellerModel(
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        shopName: map['shopName'] ?? '',
        phone: map['phone'] ?? '',
        address: map['address'] ?? '',
        description: map['description'] ?? '',
        categories: List<String>.from(map['categories'] ?? []),
        photoUrl: map['photoUrl'],
      );
}
