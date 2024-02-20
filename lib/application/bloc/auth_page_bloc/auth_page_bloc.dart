import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:veeektor/application/bloc/authefication_bloc/authefication_bloc.dart';
import 'package:veeektor/application/services/authefication_service.dart';

part 'auth_page_event.dart';
part 'auth_page_state.dart';

class AuthPageBloc extends Bloc<AuthPageEvent, AuthPageState> {
  final AutheficationBloc _autheficationBloc;
  final AutheficationService _autheficationService;

  AuthPageBloc(
      {required AutheficationBloc autheficationBloc,
      required AutheficationService autheficationService})
      : _autheficationBloc = autheficationBloc,
        _autheficationService = autheficationService,
        super(AuthPageState.initial()) {
    on<_SignInEvent>(_signIn);
    on<_SignUpEvent>(_signUp);
    on<_ShowSignInScreenEvent>(_showSignInScreen);
    on<_ShowSignUpScreenEvent>(_showSignUpScreen);
  }

  Future _signIn(_SignInEvent event, Emitter<AuthPageState> emit) async {
    emit(state.copyWith(state: AuthState.loading));
    await Future.delayed(Duration(seconds: 3));
    //_autheficationBloc.add(AutheficationEvent.authorized());
    emit(state.copyWith(state: AuthState.failure, errorMessage: "email: ${event.email} password: ${event.password}"));
  }

  Future _signUp(_SignUpEvent event, Emitter<AuthPageState> emit) async {
    emit(state.copyWith(state: AuthState.loading));
    await Future.delayed(Duration(seconds: 3)); 
    _autheficationBloc.add(AutheficationEvent.authorized());

    emit(state.copyWith(state: AuthState.nun, activePage: AuthPage.signIn));
  }

  Future _showSignInScreen(
      _ShowSignInScreenEvent event, Emitter<AuthPageState> emit) async {
    emit(state.copyWith(activePage: AuthPage.signIn));
  }

  Future _showSignUpScreen(
      _ShowSignUpScreenEvent event, Emitter<AuthPageState> emit) async {
    emit(state.copyWith(activePage: AuthPage.signUp));
  }
}
