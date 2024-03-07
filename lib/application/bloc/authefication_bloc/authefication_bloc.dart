import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/models/response/response_model.dart';
import 'package:veeektor/application/services/authefication_service.dart';

part 'authefication_event.dart';
part 'authefication_state.dart';

class AutheficationBloc extends Bloc<AutheficationEvent, AutheficationState> {
  final AutheficationService _autheficationService;

  AutheficationBloc({required AutheficationService autheficationService})
      : _autheficationService = autheficationService,
        super(AutheficationState.initial()) {
    on<_InitializeEvent>(_initialize);
    on<_SignInEvent>(_signIn);
    on<_SignUpEvent>(_signUp);
    on<_LogOutEvent>(_logOut);
  }

  Future _initialize(
      _InitializeEvent event, Emitter<AutheficationState> emit) async {
    if (await _autheficationService.isLogged()) {
      emit(state.copyWith(status: AutheficationStatus.autheficated));
    } else {
      emit(state.copyWith(status: AutheficationStatus.notAutheficated));
    }
  }

  Future _signIn(_SignInEvent event, Emitter<AutheficationState> emit) async {
    emit(state.copyWith(status: AutheficationStatus.loading));
    LogResponse response =
        await _autheficationService.signIn(event.login, event.password);
    if (response.statusCode == 200) {
      emit(state.copyWith(
        status: AutheficationStatus.autheficated,
      ));
    } else {
      emit(state.copyWith(
        status: AutheficationStatus.error,
        errorMessage: response.errorMessage,
      ));
    }
  }

  Future _signUp(_SignUpEvent event, Emitter<AutheficationState> emit) async {
    emit(state.copyWith(status: AutheficationStatus.loading));
    LogResponse response = await _autheficationService.signUp(
      name: event.name,
      surname: event.surname,
      patronymic: event.patronymic,
      email: event.email,
      password: event.password,
    );
    if (response.statusCode == 200) {
      emit(state.copyWith(
        status: AutheficationStatus.registrated,
        login: event.email,
        password: event.password,
      ));
    } else {
      emit(state.copyWith(
        status: AutheficationStatus.error,
        errorMessage: response.errorMessage,
      ));
    }
  }

  Future _logOut(_LogOutEvent event, Emitter<AutheficationState> emit) async {
    emit(state.copyWith(status: AutheficationStatus.loading));
    await _autheficationService.logOut();
    emit(state.copyWith(status: AutheficationStatus.notAutheficated));
  }
}
