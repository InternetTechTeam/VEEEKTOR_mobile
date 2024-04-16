abstract class IAuthFormModel {
  Map<String, dynamic> toJson();
}

class SignInFormModel extends IAuthFormModel {
  String email;
  String password;

  SignInFormModel({required this.email, required this.password});

  @override
  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}

class SignUpFormModel extends IAuthFormModel {
  String email;
  String password;
  String name;
  String surname;
  String patronymic;
  int depId;

  SignUpFormModel({
    required this.email,
    required this.password,
    required this.name,
    required this.patronymic,
    required this.surname,
    required this.depId,
  });

  @override
  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "name": name,
        "surname": surname,
        "patronymic": patronymic,
        "dep_id": depId,
      };
}
