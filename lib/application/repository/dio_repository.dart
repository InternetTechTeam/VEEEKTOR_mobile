import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:veeektor/application/constants/http_constants.dart';
import 'package:veeektor/application/constants/storage_keys.dart';
import 'package:veeektor/application/models/error/token_expired.dart';
import 'package:veeektor/application/repository/shared_prefs_repository.dart';

class DioRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: HttpConstants.baseURL,
      contentType: "application/json",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    ),
  );

  DioRepository();

  Future<Response> post({
    required String path,
    Map<String, dynamic>? headers,
    required Map<String, dynamic> body,
  }) async {
    try {
      final defaultHeaders = await getEssentialHeaders();
      defaultHeaders.addAll(headers ?? {});

      print(defaultHeaders);
      Response response = await _dio.post(
        path,
        options: Options(headers: defaultHeaders),
        data: json.encode(body),
      );
      print("add response");
      if (response.data != "") {
        response.data = json.decode(response.data);
      }
      if (response.data == null) {
        print("response is empty");
      } else {
        print(response.data);
      }
      return response;
    } catch (e) {
      print("catch exeption in post func");
      print(e);
      rethrow;
    }
  }

  Future<String?> refreshJWT() async {
    print("refreshJWT func is called");
    final accessToken =
        SharedPrefsRepository.get<String>(StorageKeys.accessTokenKey);
    if (accessToken == null) {
      return null;
    }
    final refreshToken =
        SharedPrefsRepository.get<String>(StorageKeys.refreshTokenKey);
    if (!Jwt.isExpired(accessToken)) {
      return accessToken;
    }

    var params = {
      "refresh_token": refreshToken,
    };
    try {
      Response response = await _dio.post(
        HttpConstants.refreshURL,
        data: json.encode(params),
      );
      print("smth of refreshJWT");
      response.data = json.decode(response.data);
      SharedPrefsRepository.setString(
          StorageKeys.refreshTokenKey, response.data["refresh_token"]);
      SharedPrefsRepository.setString(
          StorageKeys.accessTokenKey, response.data["access_token"]);

      print("refresh JWT is ending");
      return response.data["access_token"];
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          print("$e");
          final res =
              await SharedPrefsRepository.remove(StorageKeys.accessTokenKey);
          print("delete access token in refreshJWT func is $res");
          await SharedPrefsRepository.remove(StorageKeys.refreshTokenKey);
          break;
      }
      return null;
    } catch (e) {
      print("catch error in func refresh JWT");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getEssentialHeaders() async {
    String? accessToken =
        SharedPrefsRepository.get<String>(StorageKeys.accessTokenKey);
    if (accessToken == null) {
      return {};
    }
    try {
      accessToken = await refreshJWT();
      if (accessToken == null) {
        throw TokenExpiredException;
      }
      print("I'll added a headers");
      return {
        "Authorization": "Bearer $accessToken",
      };
    } catch (e) {
      print("catch exception in func getEssentialHeaders");
      rethrow;
    }
  }
}
