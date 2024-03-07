import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/authefication_bloc/authefication_bloc.dart';
import 'package:veeektor/application/models/progress_dialog.dart';
import 'package:veeektor/application/services/authefication_service.dart';
import 'package:veeektor/application/utils/storage_util.dart';
import 'package:veeektor/screens/auth/registrated_screen.dart';
import 'package:veeektor/screens/auth/sign_in_screen.dart';
import 'package:veeektor/screens/splash_screen.dart';
import 'package:veeektor/theme.dart';
import 'package:veeektor/widgets/bottom_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageUtil.init();
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
        return BlocListener<AutheficationBloc, AutheficationState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status != AutheficationStatus.loading) {
              LoadingIndicatorDialog.dismiss();
            }
            switch (state.status) {
              case AutheficationStatus.autheficated:
                _navigatorKey.currentState!
                    .pushAndRemoveUntil(BottomBar.route(), (route) => false);
                break;
              case AutheficationStatus.notAutheficated:
                _navigatorKey.currentState!
                    .pushAndRemoveUntil(SignInScreen.route(), (route) => false);
                break;
              case AutheficationStatus.registrated:
                _navigatorKey.currentState!.pushAndRemoveUntil(RegistratedScreen.route(), (route) => false);
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
