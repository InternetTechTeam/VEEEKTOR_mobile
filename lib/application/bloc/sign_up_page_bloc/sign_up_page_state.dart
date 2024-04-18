part of 'sign_up_page_bloc.dart';

class SignUpPageState {
  Status pageStatus;
  bool loadingDeps;
  List<EducationalEnviroment> enviroments;
  List<DepartmentModel> departments;
  String? errorMessage;
  bool depDropdownMenuActive;

  SignUpPageState({
    required this.pageStatus,
    required this.loadingDeps,
    required this.departments,
    required this.enviroments,
    required this.errorMessage,
    required this.depDropdownMenuActive,
  });

  factory SignUpPageState.initial() => SignUpPageState(
        pageStatus: Status.nun,
        loadingDeps: false,
        departments: [],
        enviroments: [],
        errorMessage: null,
        depDropdownMenuActive: false,
      );

  SignUpPageState copyWith({
    Status? pageStatus,
    bool? loadingDeps,
    List<EducationalEnviroment>? enviroments,
    List<DepartmentModel>? departments,
    String? errorMessage,
    bool? depDropdownMenuActive,
  }) =>
      SignUpPageState(
        pageStatus: pageStatus ?? this.pageStatus,
        loadingDeps: loadingDeps ?? this.loadingDeps,
        departments: departments ?? this.departments,
        enviroments: enviroments ?? this.enviroments,
        errorMessage: errorMessage ?? this.errorMessage,
        depDropdownMenuActive:
            depDropdownMenuActive ?? this.depDropdownMenuActive,
      );
}
