import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Authcontroller extends GetxController {
  final _storage = GetStorage();
  final RxBool _isfirsttime = true.obs;
  final RxBool _isloggedin = false.obs;
  final RxString _role = 'buyer'.obs; // 'buyer' or 'seller'

  bool get isfirsttime => _isfirsttime.value;
  bool get isloggedin => _isloggedin.value;
  String get role => _role.value;
  bool get isSeller => _role.value == 'seller';

  @override
  void onInit() {
    super.onInit();
    _loadInitialstate();
  }

  void _loadInitialstate() {
    _isfirsttime.value = _storage.read('isfirsttime') ?? true;
    _isloggedin.value = _storage.read('isloggedin') ?? false;
    _role.value = _storage.read('role') ?? 'buyer';
  }

  void setFirstTimeDone() {
    _isfirsttime.value = false;
    _storage.write('isfirsttime', false);
  }

  void login({String role = 'buyer'}) {
    _isloggedin.value = true;
    _role.value = role;
    _storage.write('isloggedin', true);
    _storage.write('role', role);
  }

  void logout() {
    _isloggedin.value = false;
    _storage.write('isloggedin', false);
  }
}
