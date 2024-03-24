import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:veeektor/application/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc({required AuthService authService})
      : _authService = authService,
        super(AuthState.initial()) {
    on<_InitAuthEvent>(_init);
    on<_UserLoggedAuthEvent>(_userLogged);
    on<_UserLogoutAuthEvent>(_userLogout);
  }

  Future _init(_InitAuthEvent event, Emitter<AuthState> emit) async {
    print("AuthBloc _init func is called");
    if (await _authService.isLogged()) {
      emit(state.copyWith(status: AuthStatus.autheficated));
    } else {
      emit(state.copyWith(status: AuthStatus.notAutheficated));
    }
  }

  Future _userLogged(
      _UserLoggedAuthEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.autheficated));
  }

  Future _userLogout(
      _UserLogoutAuthEvent event, Emitter<AuthState> emit) async {
    _authService.logout();
    emit(state.copyWith(status: AuthStatus.notAutheficated));
  }
} 
