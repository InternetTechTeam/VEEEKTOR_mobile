import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:veeektor/application/constants/http_backpoints.dart';
import 'package:veeektor/application/repository/api/api_repository.dart';
import 'package:veeektor/model/educational_eviroment.dart';
import 'package:veeektor/model/response/response.dart';

class EducationalEnvsService {
  final ApiRepository _api;

  EducationalEnvsService({required ApiRepository apiRepository})
      : _api = apiRepository;

  Future<MyResponse> getEducationalEnvs() async {
    Response response;
    try {
      response = await _api.dio.get(HttpBackpoints.getEducationalEnvsUrl);

      response.data = json.decode(response.data);
      return MyResponse(
        statusCode: 200,
        body: List<EducationalEnviroment>.from(
          response.data.map((i) => EducationalEnviroment.fromJson(i)),
        ),
      );
    } on DioException catch (error) {
      String message;
      switch (error.response!.statusCode) {
        case 500:
          message = "В данный момент сервис недоступен";
          break;
        default:
          message = "Что-то пошло не так";
          break;
      }

      return MyResponse.withError(statusCode: 0, errorMessage: message);
    }
  }

  Future<MyResponse> getEducationalEnvById({required int id}) async {
    Response response;

    try {
      response =
          await _api.dio.get("${HttpBackpoints.getEducationalEnvById}$id");
      response.data = json.decode(response.data);

      return MyResponse(
          statusCode: 200, body: EducationalEnviroment.fromJson(response.data));
    } catch (e) {
      return MyResponse(statusCode: 0);
    }
  }
}
