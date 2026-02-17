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
}
