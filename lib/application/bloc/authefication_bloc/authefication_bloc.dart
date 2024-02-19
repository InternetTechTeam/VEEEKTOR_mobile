import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:veeektor/application/services/authefication_service.dart';

part 'authefication_event.dart';
part 'authefication_state.dart';

class AutheficationBloc extends Bloc<AutheficationEvent, AutheficationState> {
  final AutheficationService _autheficationService;

  AutheficationBloc({required AutheficationService autheficationService})
      : _autheficationService = autheficationService,
        super(AutheficationState.initial()) {
    on<_InitializeEvent>(_initialize);
    on<_AuthorizedEvent>(_authorized);
    on<_LogOutEvent>(_logOut);
  }

  Future _initialize(
      _InitializeEvent event, Emitter<AutheficationState> emit) async {
    emit(state.copyWith(status: AutheficationStatus.loading));
    await Future.delayed(Duration(seconds: 3));
    emit(state.copyWith(status: AutheficationStatus.notAutheficated));
  }

  Future _authorized(
      _AuthorizedEvent event, Emitter<AutheficationState> emit) async {
    emit(state.copyWith(status: AutheficationStatus.autheficated));
  }

  Future _logOut(_LogOutEvent event, Emitter<AutheficationState> emit) async {
    emit(state.copyWith(status: AutheficationStatus.loading));
    await Future.delayed(Duration(seconds: 2));
    emit(state.copyWith(status: AutheficationStatus.notAutheficated));
  }
}
