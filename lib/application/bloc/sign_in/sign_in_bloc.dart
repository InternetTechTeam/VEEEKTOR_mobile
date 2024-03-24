import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:veeektor/application/bloc/auth/auth_bloc.dart';
import 'package:veeektor/application/models/response/response_model.dart';
import 'package:veeektor/application/services/auth_service.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthBloc _authBloc;
  final AuthService _authService;
  SignInBloc({required AuthBloc authBloc, required AuthService authService})
      : _authService = authService,
        _authBloc = authBloc,
        super(SignInState.initial()) {
    on<SignInEvent>((event, emit) async {
      emit(state.copyWith(status: SignInStatus.loading));
      LogResponse res = await _authService.signIn(event.login, event.password);
      if (res.statusCode == 200) {
        emit(state.copyWith(status: SignInStatus.success));
        _authBloc.add(AuthEvent.logged());
      } else {
        emit(state.copyWith(
          status: SignInStatus.failure,
          errorMessage: "Ошибка ${res.statusCode}: ${res.errorMessage}",
        ));
      }
    });
  }
}
