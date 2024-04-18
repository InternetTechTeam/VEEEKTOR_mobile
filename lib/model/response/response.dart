class MyResponse {
  int statusCode;
  dynamic body;
  String? errorMessage;

  MyResponse({required this.statusCode, this.body}) : errorMessage = null;

  MyResponse.withError({required this.statusCode, this.errorMessage})
      : body = null;
}
