import 'package:dio/dio.dart';
import 'package:veeektor/application/constants/http_backpoints.dart';
import 'package:veeektor/application/repository/api/middleware.dart';
import 'package:veeektor/application/repository/api/token_repository.dart';

class ApiRepository {
  final TokenRepository tokenRepository;
  final Dio dio = Dio(BaseOptions(
    baseUrl: HttpBackpoints.baseUrl,
    contentType: "application/json",
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
  ));

  ApiRepository({required this.tokenRepository}) {
    dio.interceptors.add(Middleware(
      dio: dio,
      tokenRepository: tokenRepository,
    ));
  }
}
