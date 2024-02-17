import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/auth_page_bloc/auth_page_bloc.dart';
import 'package:veeektor/application/bloc/authefication_bloc/authefication_bloc.dart';
import 'package:veeektor/application/services/authefication_service.dart';
import 'package:veeektor/screens/auth/sign_in_screen.dart';
import 'package:veeektor/screens/auth/sign_up_screen.dart';

class AuthorizationWidget extends StatelessWidget {
  const AuthorizationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthPageBloc(
          autheficationBloc: BlocProvider.of<AutheficationBloc>(context),
          autheficationService:
              RepositoryProvider.of<AutheficationService>(context),
        )..add(AuthPageEvent.showSignInScreen()),
        child: BlocListener<AuthPageBloc, AuthPageState>(
          listener: (context, state) {
            if (state is AuthPageFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error"),
                ),
              );
              BlocProvider.of<AuthPageBloc>(context)
                  .add(AuthPageEvent.addPreviousState());
            }
          },
          child: BlocBuilder<AuthPageBloc, AuthPageState>(
            builder: (context, state) {
              if (state is AuthPageSignInState) return SignInScreen();
              if (state is AuthPageSignUpState) return SignUpScreen();

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
