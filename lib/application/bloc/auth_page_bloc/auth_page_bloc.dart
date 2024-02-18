import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:veeektor/application/bloc/authefication_bloc/authefication_bloc.dart';
import 'package:veeektor/application/services/authefication_service.dart';

part 'auth_page_event.dart';
part 'auth_page_state.dart';

class AuthPageBloc extends Bloc<AuthPageEvent, AuthPageState> {
  final AutheficationBloc _autheficationBloc;
  final AutheficationService _autheficationService;
  AuthPageState previousState = AuthPageState.intiial();

  AuthPageBloc({
    required AutheficationBloc autheficationBloc, 
    required AutheficationService autheficationService})
      : _autheficationBloc = autheficationBloc,
      _autheficationService = autheficationService,
        super(AuthPageInitial()) {
    on<_SignInEvent>(_signIn);
    on<_SignUpEvent>(_signUp);
    on<_ShowSignInScreenEvent>(_showSignInScreen);
    on<_ShowSignUpScreenEvent>(_showSignUpScreen);
    on<_AddPreviousStateEvent>(_addPreviousState);
  }

  Future _signIn(_SignInEvent event, Emitter<AuthPageState> emit) async {
    _autheficationBloc.add(AutheficationEvent.authorized());
    emit(AuthPageState.signIn());
  }

  Future _signUp(_SignUpEvent event, Emitter<AuthPageState> emit) async {
    _autheficationBloc.add(AutheficationEvent.authorized());
    emit(AuthPageState.signIn());
  }

  Future _showSignInScreen(
      _ShowSignInScreenEvent event, Emitter<AuthPageState> emit) async {
    emit(AuthPageState.signIn());
    previousState = AuthPageState.signIn();
  }

  Future _showSignUpScreen(
      _ShowSignUpScreenEvent event, Emitter<AuthPageState> emit) async {
    emit(AuthPageState.signUp());
    previousState = AuthPageState.signUp();
  }

  Future _addPreviousState(_AddPreviousStateEvent event, Emitter<AuthPageState> emit) async {
    emit(previousState);
  }
}
