import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:veeektor/application/service/department_service.dart';
import 'package:veeektor/application/service/educational_envs_service.dart';
import 'package:veeektor/model/department_model.dart';
import 'package:veeektor/model/educational_eviroment.dart';
import 'package:veeektor/model/response/response.dart';
import 'package:veeektor/model/status.dart';
import 'package:veeektor/model/user.dart';

part 'profile_card_state.dart';

class ProfileCardCubit extends Cubit<ProfileCardState> {
  final EducationalEnvsService _educationalEnvsService;
  final DepartmentService _departmentService;

  ProfileCardCubit(
      {required EducationalEnvsService educationalEnvsService,
      required DepartmentService departmentService,
      required User user})
      : _departmentService = departmentService,
        _educationalEnvsService = educationalEnvsService,
        super(ProfileCardState.initial(user: user));

  Future loading() async {
    emit(state.copyWith(status: Status.loading));

    MyResponse depResponse =
        await _departmentService.getDepartmentById(id: state.user.depId);

    if (depResponse.statusCode == 200) {
      MyResponse envResponse = await _educationalEnvsService
          .getEducationalEnvById(id: depResponse.body.envId);
      if (envResponse.statusCode == 200) {
        emit(state.copyWith(
          status: Status.success,
          department: depResponse.body,
          env: envResponse.body,
        ));
        return;
      }
    }

    emit(state.copyWith(status: Status.failure));
  }
}
