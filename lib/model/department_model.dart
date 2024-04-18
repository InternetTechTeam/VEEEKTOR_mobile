class DepartmentModel {
  int id;
  String name;
  int envId;

  DepartmentModel({required this.id, required this.name, required this.envId});

  factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
      DepartmentModel(
        id: json["id"] as int,
        name: json["name"] as String,
        envId: json["env_id"] as int,
      );
}
