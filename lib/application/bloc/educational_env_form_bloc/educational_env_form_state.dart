part of 'educational_env_form_bloc.dart';

class EducationalEnvFormState {
  Status status;
  List<EducationalEnviroment> educationalEnvs;
  List<DepartmentModel> departments;
  bool loadingDepartments;
  String? errorMessage;

  EducationalEnvFormState({
    required this.status,
    required this.educationalEnvs,
    required this.departments,
    required this.loadingDepartments,
    this.errorMessage,
  });

  factory EducationalEnvFormState.initial() => EducationalEnvFormState(
        status: Status.nun,
        educationalEnvs: [],
        departments: [],
        loadingDepartments: false,
        errorMessage: null,
      );

  EducationalEnvFormState copyWith({
    Status? status,
    List<EducationalEnviroment>? educationalEnvs,
    List<DepartmentModel>? departments,
    bool? loadingDepartments,
    String? errorMessage,
  }) =>
      EducationalEnvFormState(
        status: status ?? this.status,
        educationalEnvs: educationalEnvs ?? this.educationalEnvs,
        departments: departments ?? this.departments,
        loadingDepartments: loadingDepartments ?? this.loadingDepartments,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [status, loadingDepartments];
}
