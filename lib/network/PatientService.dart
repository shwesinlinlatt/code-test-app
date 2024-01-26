import 'package:union/cache.dart';
import 'package:dio/dio.dart';

import 'api_service.dart';

class PatientService {
  static bool auth = true;

  static Future<Response?> getPatients(String? queryString) async {
    try {
      final token = await Cache.getToken();
      Response response = await ApiService.getApiHandler(token: token ?? '')
          .get('volunteer-patients?$queryString');
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  static Future<Response?> syncData(
      var data) async {
    try {
      String? token = await Cache.getToken();
      Response response = await ApiService.getApiHandler(token: token ?? '')
          .post('patients-sync',
              data: data);
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

}
