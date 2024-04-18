import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:veeektor/application/service/department_service.dart';
import 'package:veeektor/application/service/educational_envs_service.dart';
import 'package:veeektor/model/department_model.dart';
import 'package:veeektor/model/educational_eviroment.dart';
import 'package:veeektor/model/response/response.dart';
import 'package:veeektor/model/status.dart';

part 'educational_env_form_event.dart';
part 'educational_env_form_state.dart';

class EducationalEnvFormBloc
    extends Bloc<EducationalEnvFormEvent, EducationalEnvFormState> {
  final EducationalEnvsService _educationalEnvsService;
  final DepartmentService _departmentService;

  EducationalEnvFormBloc(
      {required EducationalEnvsService educationalEnvsService,
      required DepartmentService departmentService})
      : _educationalEnvsService = educationalEnvsService,
        _departmentService = departmentService,
        super(EducationalEnvFormState.initial()) {
    on<_LoadEducationalEnvsEvent>(_loadEducationalEnvs);
    on<_LoadDepartmentsEvent>(_loadDepartments);
  }

  _loadEducationalEnvs(EducationalEnvFormEvent event,
      Emitter<EducationalEnvFormState> emit) async {
    emit(state.copyWith(status: Status.loading));
    MyResponse response = await _educationalEnvsService.getEducationalEnvs();
    if (response.statusCode == 200) {
      emit(state.copyWith(
          status: Status.success, educationalEnvs: response.body));
    } else {
      emit(state.copyWith(status: Status.failure, errorMessage: "Мы умерли"));
    }
  }

  _loadDepartments(_LoadDepartmentsEvent event,
      Emitter<EducationalEnvFormState> emit) async {
    emit(state.copyWith(loadingDepartments: true));
    MyResponse response =
        await _departmentService.getDepartmentsByEnvId(id: event.envId);
        print("${response.body}");
    if (response.statusCode == 200) {
      emit(state.copyWith(
          loadingDepartments: false, departments: response.body));
    } else {
      emit(state.copyWith(
          status: Status.failure, errorMessage: response.errorMessage));
    }
  }
}
