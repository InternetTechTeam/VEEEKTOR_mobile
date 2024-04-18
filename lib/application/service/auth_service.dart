import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:veeektor/application/constants/http_backpoints.dart';
import 'package:veeektor/application/repository/api/api_repository.dart';
import 'package:veeektor/application/repository/api/token_repository.dart';
import 'package:veeektor/model/auth_form_model.dart';
import 'package:veeektor/model/educational_eviroment.dart';
import 'package:veeektor/model/response/log_response.dart';
import 'package:veeektor/model/response/response.dart';

class AuthService {
  final ApiRepository _api;
  final TokenRepository _tokenRepository;

  AuthService(
      {required ApiRepository apiRepository,
      required TokenRepository tokenRepository})
      : _api = apiRepository,
        _tokenRepository = tokenRepository;

  Future<LogResponse> signIn(IAuthFormModel authForm) async {
    var params = authForm.toJson();
    Response response;
    try {
      response = await _api.dio
          .post(HttpBackpoints.signInUrl, data: json.encode(params));

      response.data = json.decode(response.data);

      bool saved = await _tokenRepository.saveTokensInStorage(
        access: response.data["access_token"],
        refresh: response.data["refresh_token"],
      );
      if (saved) {
        return LogResponse(statusCode: 200);
      }

      return LogResponse.withError(
          statusCode: 0, errorMessage: "Ошибка сохранения токена");
    } on DioException catch (error) {
      String message;
      switch (error.response?.statusCode) {
        case null:
          message = "Что-то пошло не так, проверьте подключение к интернету";
          break;
        case 400:
          message = "Неправильно заполненные поля";
          break;
        case 404:
          message = "Пользователь не найден";
          break;
        case 405:
          message = "only POST allowed";
          break;
        default:
          message = "Непредвиденная ошибка...";
          break;
      }

      return LogResponse.withError(
          statusCode: error.response?.statusCode ?? 0, errorMessage: message);
    }
  }

  Future<LogResponse> signUp(IAuthFormModel authForm) async {
    var params = authForm.toJson();
    Response response;
    try {
      response = await _api.dio
          .post(HttpBackpoints.signUpUrl, data: json.encode(params));

      return LogResponse(statusCode: 200);
    } on DioException catch (error) {
      String message;
      switch (error.response?.statusCode) {
        case null:
          message = "Что-то пошло не так, проверьте подключение к интернету";
          break;
        case 400:
          message = "Неправильно заполненные поля";
          break;
        case 404:
          message = "Пользователь не найден";
          break;
        case 405:
          message = "only POST allowed";
          break;
        default:
          message = "Непредвиденная ошибка...";
          break;
      }

      return LogResponse.withError(
          statusCode: error.response?.statusCode ?? 0, errorMessage: message);
    }
  }
}