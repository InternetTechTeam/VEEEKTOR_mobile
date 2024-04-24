import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:veeektor/application/constants/http_backpoints.dart';
import 'package:veeektor/application/repository/api/api_repository.dart';
import 'package:veeektor/model/department_model.dart';
import 'package:veeektor/model/response/response.dart';

class DepartmentService {
  final ApiRepository _api;

  DepartmentService({required ApiRepository apiRepository})
      : _api = apiRepository;

  Future<MyResponse> getDepartmentsByEnvId({required int id}) async {
    Response response;
    try {
      response =
          await _api.dio.get("${HttpBackpoints.getDepartmentsByEnvIdUrl}$id");

      response.data = json.decode(response.data);
      print("${response.data}");
      return MyResponse(
        statusCode: 200,
        body: List<DepartmentModel>.from(
          response.data.map((i) => DepartmentModel.fromJson(i)),
        ),
      );
    } on DioException catch (error) {
      String message;
      switch (error.response!.statusCode) {
        case 400:
          message = "Некорректная организация";
        case 500:
          message = "В данный момент сервис недоступен";
          break;
        default:
          message = "Что-то пошло не так";
          break;
      }
      print(message);
      return MyResponse.withError(statusCode: 0, errorMessage: message);
    }
  }

  Future<MyResponse> getDepartmentById({required int id}) async {
    Response response;
    try {
      response = await _api.dio.get("${HttpBackpoints.getDepartmentById}$id");
      response.data = json.decode(response.data);

      return MyResponse(statusCode: 200, body: DepartmentModel.fromJson(response.data));
    } on DioException catch (error) {
      return MyResponse.withError(statusCode: error.response!.statusCode!, errorMessage: error.message);
    }
  }
}
