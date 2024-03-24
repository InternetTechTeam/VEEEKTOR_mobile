import 'package:dio/dio.dart';
import 'package:veeektor/application/bloc/sign_up/sign_up_bloc.dart';
import 'package:veeektor/application/constants/http_constants.dart';
import 'package:veeektor/application/constants/storage_keys.dart';
import 'package:veeektor/application/models/error/token_expired.dart';
import 'package:veeektor/application/models/response/response_model.dart';
import 'package:veeektor/application/repository/dio_repository.dart';
import 'package:veeektor/application/repository/shared_prefs_repository.dart';

class AuthService {
  final DioRepository _dio;
  AuthService({
    required DioRepository dioRepository,
  }) : _dio = dioRepository;

  Future<bool> isLogged() async {
    print("isLogged func is called");
    try {
      final String? result = await _dio.refreshJWT();
      print("refreshJWT func returned $result");
      if (result != null) {
        return true;
      } else {
        return false;
      }
    } on TokenExpiredException {
      await logout();
      return false;
    }
  }

  Future<LogResponse> signIn(String login, String password) async {
    var params = {
      "email": login,
      "password": password,
    };

    Response response;

    try {
      response = await _dio.post(
        path: HttpConstants.signInURL,
        body: params,
      );
      print("${response.data}");
      var res = await SharedPrefsRepository.setString(
          StorageKeys.accessTokenKey, response.data["access_token"]);
      print("save access token: $res");
      res = await SharedPrefsRepository.setString(
          StorageKeys.refreshTokenKey, response.data["refresh_token"]);
      print("save refresh token: $res");
      return LogResponse(statusCode: response.statusCode!);
    } on DioException catch (e) {
      String message;
      switch (e.response?.statusCode) {
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
          statusCode: e.response?.statusCode ?? 0, errorMessage: message);
    } on TokenExpiredException {
      await logout();
      return LogResponse.withError(statusCode: 0, errorMessage: "Ошибка токена, попробуйте снова");
    } catch (e) {
      print(e);
      return LogResponse.withError(statusCode: 0, errorMessage: e.toString());
    }
  }

  Future<LogResponse> signUp({
    required SignUpEvent signUpEvent,
  }) async {
    var params = {
      "name": signUpEvent.name,
      "surname": signUpEvent.surname,
      "patronymic": signUpEvent.patronymic,
      "email": signUpEvent.email,
      "password": signUpEvent.password,
    };

    try {
      Response response =
          await _dio.post(path: HttpConstants.signUpURL, body: params);

      var res = await SharedPrefsRepository.setString(
          StorageKeys.accessTokenKey, response.data["access_token"]);
      print("save access token: $res");
      res = await SharedPrefsRepository.setString(
          StorageKeys.refreshTokenKey, response.data["refresh_token"]);
      print("save refresh token: $res");
      return LogResponse(statusCode: response.statusCode!);
    } on DioException catch (e) {
      String message;
      switch (e.response?.statusCode) {
        case 400:
          message = "Неправильно заполенные поля";
          break;
        case 409:
          message = "Пользователь с таким емейлом уже существует";
          break;
        default:
          message = "Непредвиденная ошибка";
          break;
      }

      return LogResponse.withError(
          statusCode: e.response?.statusCode ?? 0, errorMessage: message);
    } catch (e) {
      print(e);
      return LogResponse.withError(statusCode: 0, errorMessage: e.toString());
    }
  }

  Future logout() async {
    final refreshToken =
        SharedPrefsRepository.get<String>(StorageKeys.refreshTokenKey);
    var params = {
      "refresh_token": refreshToken,
    };

    try {
      Response response = await _dio.post(
        path: HttpConstants.logoutURL,
        body: params,
      );

      final res = await SharedPrefsRepository.remove(StorageKeys.accessTokenKey);
      print("delete access token is $res");
      await SharedPrefsRepository.remove(StorageKeys.refreshTokenKey);
    } catch (e) {
      print(e);
      return;
    }
  }
}
