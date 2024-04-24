part of 'profile_card_cubit.dart';

class ProfileCardState {
  Status status;
  User user;
  EducationalEnviroment? env;
  DepartmentModel? department;

  ProfileCardState({
    required this.status,
    required this.user,
    required this.env,
    required this.department,
  });

  factory ProfileCardState.initial({required User user}) => ProfileCardState(
        status: Status.nun,
        user: user,
        env: null,
        department: null,
      );

  ProfileCardState copyWith({
    Status? status,
    User? user,
    EducationalEnviroment? env,
    DepartmentModel? department,
  }) =>
      ProfileCardState(
        status: status ?? this.status,
        user: user ?? this.user,
        env: env ?? this.env,
        department: department ?? this.department,
      );
}
