part of 'auth_page_bloc.dart';

class AuthPageState {
  AuthPageState({
    required this.state,
    required this.activePage,
  });

  AuthState state;
  AuthPage activePage;

  factory AuthPageState.initial() => AuthPageState(
        activePage: AuthPage.signIn,
        state: AuthState.nun,
      );

  AuthPageState copyWith({
    AuthState? state,
    AuthPage? activePage,
  }) =>
      AuthPageState(
        state: state ?? this.state,
        activePage: activePage ?? this.activePage,
      );

  List<Object> get props => [state, activePage];
}

enum AuthState { loading, failure, nun }

enum AuthPage { signIn, signUp }
