import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/authefication_bloc/authefication_bloc.dart';
import 'package:veeektor/application/services/authefication_service.dart';
import 'package:veeektor/screens/home_screen.dart';
import 'package:veeektor/widgets/authorization_widget.dart';
import 'package:veeektor/theme.dart';
import 'package:veeektor/widgets/bottom_bar.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AutheficationService>(
          create: (context) => AutheficationService(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AutheficationBloc>(
            create: (context) => AutheficationBloc(
                autheficationService:
                    RepositoryProvider.of<AutheficationService>(context))
              ..add(AutheficationEvent.intialize()),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VEEEKTOR',
      theme: appTheme,
      home: BlocBuilder<AutheficationBloc, AutheficationState>(
        builder: (context, state) {
          if (state is NotAutheficatedState) {
            return const AuthorizationWidget();
          }
          return const HomeScreen();
        },
      ),
    );
  }
}