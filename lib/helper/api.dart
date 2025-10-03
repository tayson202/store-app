import 'package:http/http.dart' as http;

class api {
  Future<dynamic> get({required String Url}) async {
    http.Response response = await http.get(Uri.parse(Url));
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("eror with status code${response.statusCode}");
    }
  }
}
