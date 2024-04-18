import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:veeektor/application/service/auth_service.dart';
import 'package:veeektor/application/service/department_service.dart';
import 'package:veeektor/application/service/educational_envs_service.dart';
import 'package:veeektor/model/auth_form_model.dart';
import 'package:veeektor/model/department_model.dart';
import 'package:veeektor/model/educational_eviroment.dart';
import 'package:veeektor/model/response/log_response.dart';
import 'package:veeektor/model/response/response.dart';
import 'package:veeektor/model/status.dart';

part 'sign_up_page_event.dart';
part 'sign_up_page_state.dart';

class SignUpPageBloc extends Bloc<SignUpPageEvent, SignUpPageState> {
  final AuthService _authService;
  final DepartmentService _departmentService;
  final EducationalEnvsService _educationalEnvsService;

  SignUpPageBloc({
    required AuthService authService,
    required DepartmentService departmentService,
    required EducationalEnvsService educationalEnvsService,
  })  : _authService = authService,
        _departmentService = departmentService,
        _educationalEnvsService = educationalEnvsService,
        super(SignUpPageState.initial()) {
    on<_LoadingEnvsEvent>(_loadingEnvs);
    on<_LoadingDepsEvent>(_loadingDeps);
  }

  _loadingEnvs(_LoadingEnvsEvent event, Emitter<SignUpPageState> emit) async {
    emit(state.copyWith(pageStatus: Status.loading));
    MyResponse response = await _educationalEnvsService.getEducationalEnvs();
    if (response.statusCode == 200) {
      emit(state.copyWith(pageStatus: Status.nun, enviroments: response.body));
    } else {
      emit(state.copyWith(
          pageStatus: Status.failure, errorMessage: response.errorMessage));
    }
  }

  _loadingDeps(_LoadingDepsEvent event, Emitter<SignUpPageState> emit) async {
    emit(state.copyWith(depDropdownMenuActive: false, loadingDeps: true));

    MyResponse response =
        await _departmentService.getDepartmentsByEnvId(id: event.envId);
    if (response.statusCode == 200) {
      emit(state.copyWith(
        depDropdownMenuActive: true,
        loadingDeps: false,
        departments: response.body,
      ));
    } else {
      emit(state.copyWith(
          pageStatus: Status.failure, errorMessage: response.errorMessage));
    }
  }
}
