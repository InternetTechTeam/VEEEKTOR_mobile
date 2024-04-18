import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:veeektor/application/constants/http_backpoints.dart';
import 'package:veeektor/application/repository/api/token_repository.dart';

class Middleware extends Interceptor {
  final Dio _dio;
  final TokenRepository _tokenRepository;

  Middleware({required Dio dio, required TokenRepository tokenRepository})
      : _dio = dio,
        _tokenRepository = tokenRepository;

  Future<bool> _refreshToken() async {
    String? refresh = _tokenRepository.getRefreshToken();
    if (refresh == null) {
      return false;
    }
    try {
      var params = {
        "refresh_token": refresh,
      };

      final Dio dio = Dio(BaseOptions(
        baseUrl: HttpBackpoints.baseUrl,
        contentType: "application/json",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ));

      Response response =
          await dio.post(HttpBackpoints.refreshUrl, data: json.encode(params));

      response.data = json.decode(response.data);

      return await _tokenRepository.saveTokensInStorage(
          access: response.data["access_token"],
          refresh: response.data["refresh_token"]);
    } catch (error) {
      rethrow;
    }
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!HttpBackpoints.needToken.contains(options.path)) {
      return super.onRequest(options, handler);
    }

    if (_tokenRepository.isTokenExpired()) {
      try {
        bool result = await _refreshToken();
      } catch (error) {
        print("Middleware: failed to refresh token: $error");
        handler.reject(DioException(
            requestOptions: options,
            response: Response(
              data: {},
              requestOptions: options,
              statusCode: 401,
            )));
      }
    }
    String? access = _tokenRepository.getAccessToken();
    options.headers["Authorization"] = "Bearer $access";

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.response!.statusCode) {
      case 401:
        // TODO: impliment logout
        break;
      default:
        break;
    }
    super.onError(err, handler);
  }
}
