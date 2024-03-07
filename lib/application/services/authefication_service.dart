import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:veeektor/application/constants/http_constants.dart';
import 'package:veeektor/application/constants/storage_keys.dart';
import 'package:veeektor/application/models/response/response_model.dart';
import 'package:veeektor/application/utils/http_util.dart';
import 'package:veeektor/application/utils/storage_util.dart';

class AutheficationService {
  final HttpUtil _httpUtil = HttpUtil();
  final StorageUtil _storageUtil = StorageUtil();

  Future<bool> isLogged() async {
    final token = await _httpUtil.middleware();

    if (token == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<LogResponse> signIn(String login, String password) async {
    var params = {
      "email": login,
      "password": password,
    };
    try {
      Response response = await _httpUtil.dio.post(
        HttpConstants.signInURL,
        data: json.encode(params),
      );
      if (response.statusCode == 200) {
        print("${response.data}");
        _storageUtil.save<String>(StorageKeys.accessTokenKey, response.data["access_token"]);
        print("trying to save");
        _storageUtil.save<String>(StorageKeys.refreshTokenKey, response.data["refresh_token"]);
        return LogResponse(statusCode: 200);
      } else {
        return LogResponse.withError(
            statusCode: response.statusCode!,
            errorMessage: "${response.statusCode}");
      }
    } catch (e) {
      return LogResponse.withError(statusCode: 0, errorMessage: "$e");
    }
  }

  Future<LogResponse> signUp({
    required String name,
    required String surname,
    required String patronymic,
    required String email,
    required String password,
  }) async {
    var params = {
      "name": name,
      "surname": surname,
      "patronymic": patronymic,
      "email": email,
      "password": password,
      "role_id": 1,
    };

    try {
      Response response = await _httpUtil.dio.post(
        HttpConstants.signUpURL,
        data: json.encode(params),
      );
      if (response.statusCode == 200) {
        return LogResponse(statusCode: 200);
      } else {
        return LogResponse.withError(
            statusCode: response.statusCode!, errorMessage: "eeror");
      }
    } catch (e) {
      print("$e");
      return LogResponse.withError(statusCode: 0, errorMessage: "$e");
    }
  }

  Future logOut() async {
    await _storageUtil.remove(StorageKeys.accessTokenKey);
    await _storageUtil.remove(StorageKeys.refreshTokenKey);
  }
}
