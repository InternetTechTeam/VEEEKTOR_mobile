// role_id
// 1 -- student
// 2 -- teacher
// 3 -- admin

class Role {
  final int id;

  Role({required this.id});

  @override
  String toString() {
    String result;
    switch (id) {
      case 1:
        result = "Студент";
        break;
      case 2:
        result = "Преподаватель";
        break;
      case 3:
        result = "Администратор";
        break;
      default:
        result = "";
    }
    return result;
  }
}
