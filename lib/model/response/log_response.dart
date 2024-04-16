class LogResponse {
  int statusCode;
  String? errorMessage;

  LogResponse({required this.statusCode}) : errorMessage = null;

  LogResponse.withError({required this.statusCode, required this.errorMessage});
}
