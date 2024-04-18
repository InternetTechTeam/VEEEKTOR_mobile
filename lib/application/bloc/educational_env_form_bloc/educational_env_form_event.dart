part of 'educational_env_form_bloc.dart';

class EducationalEnvFormEvent {
  const EducationalEnvFormEvent();

  factory EducationalEnvFormEvent.loadEducationalEnvs() =>
      _LoadEducationalEnvsEvent();
  factory EducationalEnvFormEvent.loadDepartments({required int envId}) =>
      _LoadDepartmentsEvent(envId: envId);
}

class _LoadEducationalEnvsEvent extends EducationalEnvFormEvent {}

class _LoadDepartmentsEvent extends EducationalEnvFormEvent {
  int envId;

  _LoadDepartmentsEvent({required this.envId});
}
