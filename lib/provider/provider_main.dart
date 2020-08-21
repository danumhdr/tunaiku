import 'package:dio/dio.dart';
import 'package:tunaiku/model/model_main.dart';

class ProviderMain {
  final String _endpoint =
      "https://dev.farizdotid.com/api/daerahindonesia/provinsi";
  final Dio _dio = Dio();

  Future<MainModel> getUser() async {
    try {
      Response response = await _dio.get(_endpoint);
      print("object");
      print(response.data);
      return MainModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
}
