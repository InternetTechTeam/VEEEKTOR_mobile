import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/auth_page_bloc/auth_page_bloc.dart';
import 'package:veeektor/application/bloc/authefication_bloc/authefication_bloc.dart';
import 'package:veeektor/application/services/authefication_service.dart';
import 'package:veeektor/application/models/progress_dialog.dart';
import 'package:veeektor/screens/auth/sign_in_screen.dart';
import 'package:veeektor/screens/auth/sign_up_screen.dart';

class AuthorizationWidget extends StatelessWidget {
  const AuthorizationWidget({super.key});

  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => const AuthorizationWidget(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthPageBloc(
          autheficationBloc: BlocProvider.of<AutheficationBloc>(context),
          autheficationService:
              RepositoryProvider.of<AutheficationService>(context),
        )..add(AuthPageEvent.showSignInScreen()),
        child: Scaffold(
          body: BlocListener<AuthPageBloc, AuthPageState>(
            listenWhen: (previous, current) => previous.state != current.state,
            listener: (context, state) {
              if (state.state == AuthState.loading) {
                LoadingIndicatorDialog.show(context);
              } else {
                LoadingIndicatorDialog.dismiss();
              }
              if (state.state == AuthState.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Error"),
                  ),
                );
              }
            },
            child: BlocBuilder<AuthPageBloc, AuthPageState>(
              builder: (context, state) {
                if (state.activePage == AuthPage.signIn)
                  return const SignInScreen();
                if (state.activePage == AuthPage.signUp)
                  return const SignUpScreen();

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
