import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:veeektor/application/constants/http_backpoints.dart';
import 'package:veeektor/application/repository/api/api_repository.dart';
import 'package:veeektor/model/course.dart';
import 'package:veeektor/model/response/response.dart';

class CoursesService {
  final ApiRepository _api;

  CoursesService({required ApiRepository apiRepository}) : _api = apiRepository;

  Future<MyResponse> getUserCources() async {
    try {
      Response response = await _api.dio.get(
        HttpBackpoints.getUserCourcesUrl,
      );

      response.data = json.decode(response.data);
      print(response.data);
      return MyResponse(
        statusCode: response.statusCode!,
        body: List<Course>.from(response.data.map((i) => Course.fromJson(i))),
      );
    } on DioException catch (error) {
      switch (error.response!.statusCode) {
        case 404:
          return MyResponse(statusCode: 200, body: null);
        default:
          return MyResponse.withError(
            statusCode: error.response!.statusCode!,
            errorMessage: error.message,
          );
      }
    }
  }

  Future<MyResponse> getCourseById({required int id}) async {
    Response response;
    print("${HttpBackpoints.getCourseByIdUrl}$id");
    try {
      response = await _api.dio.get("${HttpBackpoints.getCourseByIdUrl}$id",
          options: Options(
            headers: {
              "needToken": true,
            },
          ));
      response.data = json.decode(response.data);

      return MyResponse(statusCode: response.statusCode!, body: response.data);
    } catch (e) {
      return MyResponse.withError(statusCode: 0, errorMessage: e.toString());
    }
  }
}
