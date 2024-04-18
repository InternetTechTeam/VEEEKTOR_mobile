import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/sign_up_page_bloc/sign_up_page_bloc.dart';
import 'package:veeektor/application/repository/api/api_repository.dart';
import 'package:veeektor/application/service/auth_service.dart';
import 'package:veeektor/application/service/department_service.dart';
import 'package:veeektor/application/service/educational_envs_service.dart';
import 'package:veeektor/model/status.dart';
import 'package:veeektor/screens/auth/sign_up/sign_up_stepper.dart';
import 'package:veeektor/widgets/loading_indicator_dialog.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({
    super.key,
  });

  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Регистрация"),
        centerTitle: true,
      ),
      body: RepositoryProvider(
        create: (context) => AuthService(
          apiRepository: RepositoryProvider.of<ApiRepository>(context),
        ),
        child: BlocProvider(
          create: (context) => SignUpPageBloc(
            authService: RepositoryProvider.of<AuthService>(context),
            departmentService:
                RepositoryProvider.of<DepartmentService>(context),
            educationalEnvsService:
                RepositoryProvider.of<EducationalEnvsService>(context),
          )..add(SignUpPageEvent.loadingEnvs()),
          child: BlocListener<SignUpPageBloc, SignUpPageState>(
            listenWhen: (previous, current) =>
                previous.pageStatus != current.pageStatus,
            listener: (BuildContext context, SignUpPageState state) {
              if (state.pageStatus != Status.loading) {
                LoadingIndicatorDialog.dismiss();
              }
              switch (state.pageStatus) {
                case Status.failure:
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Error"),
                      content:
                          Text(state.errorMessage ?? "Непредвиденная ошибка"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                            },
                            child: Text("OK")),
                      ],
                    ),
                  );
                  break;
                case Status.loading:
                  LoadingIndicatorDialog.show(context);
                  break;
                default:
                  break;
              }
            },
            child: SignUpStepper(),
          ),
        ),
      ),
    );
  }
}
