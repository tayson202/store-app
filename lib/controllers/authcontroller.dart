import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Authcontroller extends GetxController {
  final _storage = GetStorage();
  final RxBool _isfirsttime = true.obs;
  final RxBool _isloggedin = false.obs;
  bool get isfirsttime => _isfirsttime.value;
  bool get isloggedin => _isloggedin.value;
  @override
  void onInit() {
    super.onInit();
    _loadInitialstate();
  }

  void _loadInitialstate() {
    _isfirsttime.value = _storage.read('isfirsttime') ?? true;
    _isloggedin.value = _storage.read('isloggedin') ?? false;
  }

  void setFirstTimeDone() {
    _isfirsttime.value = false;
    _storage.write('isloggedin', true);
  }

  void login() {
    _isloggedin.value = false;
    _storage.write('isloggedin', false);
  }
}
