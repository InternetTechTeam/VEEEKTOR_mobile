class MyResponse {
  final int statusCode;
  final String errorMessage;
  final dynamic body;

  MyResponse({required this.body, required this.statusCode})
      : errorMessage = "";

  MyResponse.withError({required this.errorMessage, required this.statusCode})
      : body = null;
}

class LogResponse {
  final int statusCode;
  final String? errorMessage;

  LogResponse({required this.statusCode}) : errorMessage = null;

  LogResponse.withError({required this.statusCode, required this.errorMessage});
}
