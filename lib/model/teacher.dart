class Teacher {
  String name;
  String patronymic;
  String surname;
  String department;

  Teacher({
    required this.name,
    required this.patronymic,
    required this.surname,
    required this.department,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        name: json["name"] as String,
        patronymic: json["patronymic"] as String,
        surname: json["surname"] as String,
        department: json["department"] as String,
      );
}
