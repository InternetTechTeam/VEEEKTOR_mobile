import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:veeektor/application/bloc/auth/auth_bloc.dart';
import 'package:veeektor/application/models/response/response_model.dart';
import 'package:veeektor/application/services/auth_service.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthService _authService;
  final AuthBloc _authBloc;

  SignUpBloc({required AuthService authService, required AuthBloc authBloc})
      : _authService = authService,
        _authBloc = authBloc,
        super(SignUpState.initial()) {
    on<SignUpEvent>((event, emit) async {
      emit(state.copyWith(status: SignUpStatus.loading));
      LogResponse res = await _authService.signUp(signUpEvent: event);
      if (res.statusCode == 200) {
        emit(state.copyWith(status: SignUpStatus.success));
        _authBloc.add(AuthEvent.logged());
      } else {
        emit(state.copyWith(
          status: SignUpStatus.failure,
          errorMessage: "Ошибка ${res.statusCode}: ${res.errorMessage}",
        ));
      }
    });
  }
}
