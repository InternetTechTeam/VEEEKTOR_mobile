import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/auth/auth_bloc.dart';
import 'package:veeektor/application/bloc/sign_in/sign_in_bloc.dart';
import 'package:veeektor/application/bloc/sign_up/sign_up_bloc.dart';
import 'package:veeektor/application/constants/storage_keys.dart';
import 'package:veeektor/application/repository/dio_repository.dart';
import 'package:veeektor/application/repository/shared_prefs_repository.dart';
import 'package:veeektor/application/services/auth_service.dart';
import 'package:veeektor/screens/auth/sign_in_screen.dart';
import 'package:veeektor/screens/splash_screen.dart';
import 'package:veeektor/theme.dart';
import 'package:veeektor/widgets/bottom_bar.dart';

void main() async {
  print("app started!");
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsRepository.init();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DioRepository(),
        ),
        RepositoryProvider<AuthService>(
          create: (context) => AuthService(
            dioRepository: RepositoryProvider.of<DioRepository>(context),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authService: RepositoryProvider.of<AuthService>(context),
            )..add(AuthEvent.init()),
          ),
          BlocProvider(
            create: (context) => SignInBloc(
              authBloc: BlocProvider.of<AuthBloc>(context),
              authService: RepositoryProvider.of<AuthService>(context),
            ),
          ),
          BlocProvider(
            create: (context) => SignUpBloc(
                authService: RepositoryProvider.of<AuthService>(context),
                authBloc: BlocProvider.of<AuthBloc>(context)),
          ),
        ],
        child: App(),
      ),
    ),
  );
}

class App extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VEEEKTOR',
      theme: appTheme,
      navigatorKey: _navigatorKey,
      builder: (context, _) {
        return BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            switch (state.status) {
              case AuthStatus.autheficated:
                print(
                    "usert autheficated, token is ${SharedPrefsRepository.get<String>(StorageKeys.accessTokenKey)}");
                _navigatorKey.currentState!
                    .pushAndRemoveUntil(BottomBar.route(), (route) => false);
                break;
              case AuthStatus.notAutheficated:
                _navigatorKey.currentState!
                    .pushAndRemoveUntil(SignInScreen.route(), (route) => false);
                break;
              default:
                break;
            }
          },
          child: _,
        );
      },
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (_) => SplashScreen.route(),
    );
  }
}
