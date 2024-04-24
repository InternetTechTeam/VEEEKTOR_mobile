import 'package:veeektor/model/role.dart';

class User {
  int id;
  Role role;
  int depId;
  String email;
  String name;
  String patronymic;
  String surname;

  User({
    required this.id,
    required this.role,
    required this.depId,
    required this.email,
    required this.name,
    required this.patronymic,
    required this.surname,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] as int,
        role: Role(id: json["role_id"] as int),
        depId: json["dep_id"] as int,
        email: json["email"] as String,
        name: json["name"] as String,
        patronymic: json["patronymic"] as String,
        surname: json["surname"] as String,
      );
}
