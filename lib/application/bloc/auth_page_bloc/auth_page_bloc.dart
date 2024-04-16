import 'package:bloc/bloc.dart';
import 'package:veeektor/application/service/auth_service.dart';
import 'package:veeektor/model/auth_form_model.dart';
import 'package:veeektor/model/response/log_response.dart';
import 'package:veeektor/model/status.dart';

part 'auth_page_event.dart';
part 'auth_page_state.dart';

class AuthPageBloc extends Bloc<AuthPageEvent, AuthPageState> {
  final AuthService _authService;

  AuthPageBloc({required AuthService authService})
      : _authService = authService,
        super(AuthPageState.initial()) {
    on<_SignInEvent>(_signIn);
  }

  _signIn(_SignInEvent event, Emitter<AuthPageState> emit) async {
    emit(state.copyWith(status: Status.loading));

    LogResponse res = await _authService.signIn(event.form);
    if (res.statusCode == 200) {
      emit(state.copyWith(status: Status.success));
    } else {
      emit(state.copyWith(
          status: Status.failure, errorMessage: res.errorMessage));
    }
  }
}
