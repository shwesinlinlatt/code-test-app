import 'package:dio/dio.dart';
import 'api_service.dart';

class AuthService {
  static Future<Response?> login(Map<String, dynamic> data) async {
    try {
      Response response =
          await ApiService.getApiHandler().post('volunteer-login', data: data);
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }
}
