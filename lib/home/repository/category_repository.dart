import 'package:dio/dio.dart';
import 'package:ploff_app/core/server_error.dart';
import 'package:ploff_app/home/data/model/category_response.dart';

class CategoryRepository {
  final dio = Dio()
    ..options = BaseOptions(
      contentType: 'application/json',
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      connectTimeout: const Duration(
        seconds: 300,
      ),
      headers: {"Shipper" : "d4b1658f-3271-4973-8591-98a82939a664"}

    )
    ..interceptors.addAll(
      [
        LogInterceptor(responseBody: true, requestBody: true),
      ],
    );

  Future<CategoryResponse> getCategory() async {
    try {
      final response = await dio.get(
        'https://test.customer.api.delever.uz/v1/category',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return CategoryResponse.fromJson(response.data);
      }
      throw ServerException.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromJson(e.response?.data);
    } on FormatException {
      throw ServerException(message: 'Something is error');
    }
  }
}
