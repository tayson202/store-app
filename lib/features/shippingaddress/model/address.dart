enum Addresstype { home, office, other }

class Address {
  final String id;
  final String label;
  final String fulladdress;
  final String city;
  final String state;
  final String zipcode;
  final bool isdefault;
  final Addresstype type;

  const Address({
    required this.id,
    required this.label,
    required this.fulladdress,
    required this.city,
    required this.state,
    required this.zipcode,
    this.isdefault = false,
    this.type = Addresstype.home,
  });
  String get typestring => type.name;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'fulladdress': fulladdress,
      'city': city,
      'state': state,
      'zipcode': zipcode,
      'isdefault': isdefault,
      'type': type.index,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as String,
      label: json['label'] as String,
      fulladdress: json['fulladdress'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipcode: json['zipcode'] as String,
      isdefault: json['isdefault'] as bool? ?? false,
      type: Addresstype.values[json['type'] as int? ?? 0],
    );
  }
}
