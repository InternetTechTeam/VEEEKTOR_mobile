class HttpBackpoints {
  static const String baseUrl = "http://134.209.230.107:8080/api/";
  static const String signInUrl = "users/signin";
  static const String signUpUrl = "users/signup";
  static const String refreshUrl = "auth/refresh";
  static const String logoutUrl = "auth/logout";
  static const String userUrl = "users";

  static const List<String> needToken = [
    userUrl,
  ];
}
