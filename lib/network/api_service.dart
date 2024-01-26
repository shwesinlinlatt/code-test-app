import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static Dio getApiHandler({String token = '', bool isFormData = false}) {
    BaseOptions options = BaseOptions(
      baseUrl: "https://test-api.69503293-6-20230119143944.webstarterz.com/api/v1/",
    );

    options.headers["Authorization"] = "Bearer $token";
    options.headers["Accept"] = "application/json";

    isFormData ? options.headers['Content-Type'] = 'multipart/form-data' : null;

    Dio dio = Dio(options);
    dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      )
    ]);

    return dio;
  }
}
