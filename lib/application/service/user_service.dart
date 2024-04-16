import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:veeektor/application/constants/http_backpoints.dart';
import 'package:veeektor/application/repository/api/api_repository.dart';
import 'package:veeektor/model/response/log_response.dart';
import 'package:veeektor/model/user.dart';

class UserService {
  ApiRepository _api;

  UserService({required ApiRepository apiRepository}) : _api = apiRepository;

  Future<User?> getUserData() async {
    Response response;
    try {
      response = await _api.dio.get(HttpBackpoints.userUrl);
      return User.fromJson(json.decode(response.data));
    } catch (e) {
      return null;
    }
  }

  Future<LogResponse> logout() async {
    Response response;
    try {
      response = await _api.dio.post(HttpBackpoints.logoutUrl);
      return LogResponse(statusCode: 200);
    } on DioException catch (error) {
      return LogResponse.withError(statusCode: error.response!.statusCode!, errorMessage: "token not provided");
    }
  }
}
