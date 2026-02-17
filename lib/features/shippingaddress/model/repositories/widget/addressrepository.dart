import 'package:demo_app/features/shippingaddress/model/address.dart';

class Addressrepository {
  List<Address> getaddress() {
    return const [
      Address(
        id: '1',
        label: 'home',
        fulladdress: '123 main street',
        city: 'ismailia',
        state: 'ism',
        zipcode: '461611',
        isdefault: true,
        type: Addresstype.home,
      ),
      Address(
        id: '2',
        label: 'office',
        fulladdress: '657 main street',
        city: 'cairo',
        state: 'cairo',
        zipcode: '465411',

        type: Addresstype.office,
      ),
    ];
  }

  Address? getdefaultaddress() {
    return getaddress().firstWhere(
      (Address) => Address.isdefault,
      orElse: () => getaddress().first,
    );
  }
}
