class EducationalEnviroment {
  int id;
  String name;

  EducationalEnviroment({
    required this.id,
    required this.name,
  });

  factory EducationalEnviroment.fromJson(Map<String, dynamic> json) =>
      EducationalEnviroment(
        id: json["id"] as int,
        name: json["name"] as String,
      );
}
