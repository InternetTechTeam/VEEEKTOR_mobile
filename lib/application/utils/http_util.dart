import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:veeektor/application/constants/http_constants.dart';
import 'package:veeektor/application/constants/storage_keys.dart';
import 'package:veeektor/application/utils/storage_util.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  late final Dio dio;

  factory HttpUtil() => _instance;

  HttpUtil._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: HttpConstants.baseURL,
        contentType: "application/json",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );
  }

  Future<String?> middleware() async {
    final storage = StorageUtil();

    if (!storage.contains(StorageKeys.accessTokenKey)) {
      return null;
    }

    var token = storage.load<String>(StorageKeys.accessTokenKey);
    if (token == null) {
      return null;
    }

    if (Jwt.isExpired(token)) {
      token = await _refreshJWT(token);
    }

    return token;
  }

  Future<String?> _refreshJWT(String accessToken) async {
    final storage = StorageUtil();

    if (!storage.contains(StorageKeys.refreshTokenKey)) {
      return null;
    }

    var token = storage.load(StorageKeys.refreshTokenKey);
    if (token == null) {
      return null;
    }

    var params = {
      "refresh_token": token,
    };
    try {
      Response response = await dio.post(
        HttpConstants.refreshURL,
        data: json.encode(params),
      );

      print("${response.data}\n${response.statusCode}");
      storage.save(StorageKeys.accessTokenKey, response.data["access_token"]);
      storage.save(StorageKeys.refreshTokenKey, response.data["refresh_token"]);
    } catch (e) {
      print("$e");
      return null;
    }

    return accessToken;
  }
}
