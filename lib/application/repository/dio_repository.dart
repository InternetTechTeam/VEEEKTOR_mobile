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

      Response response = await _dio.post(
        path,
        options: Options(headers: defaultHeaders),
        data: json.encode(body),
      );
      response.data = json.decode(response.data);

      print(response.data);
      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<String?> refreshJWT() async {
    print("refreshJWT func is called");
    final accessToken =
        SharedPrefsRepository.get<String>(StorageKeys.accessTokenKey);
    print("access token is $accessToken");
    if (accessToken == null) {
      return null;
    }
    final refreshToken =
        SharedPrefsRepository.get<String>(StorageKeys.refreshTokenKey);
    print("refresh token is $refreshToken");
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

      response.data = json.decode(response.data);
      print("response: ${response.data}");
      SharedPrefsRepository.setString(
          StorageKeys.refreshTokenKey, response.data["refresh_token"]);
      SharedPrefsRepository.setString(
          StorageKeys.accessTokenKey, response.data["access_token"]);

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

      return {
        "Authorization": "Bearer $accessToken",
      };
    } catch (e) {
      rethrow;
    }
  }
}
