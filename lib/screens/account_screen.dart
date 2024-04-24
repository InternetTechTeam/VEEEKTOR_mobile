import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/profile_card/profile_card_cubit.dart';
import 'package:veeektor/application/bloc/user_bloc/user_bloc.dart';
import 'package:veeektor/application/repository/api/api_repository.dart';
import 'package:veeektor/application/service/department_service.dart';
import 'package:veeektor/application/service/educational_envs_service.dart';
import 'package:veeektor/model/status.dart';
import 'package:veeektor/model/user.dart';

class AccoutScreen extends StatelessWidget {
  const AccoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Аккаунт"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileCard(
                  user: state.user!,
                ),
                TextButton(
                    onPressed: () {
                      BlocProvider.of<UserBloc>(context)
                          .add(UserEvent.logout());
                    },
                    child: Text("Logout")),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  User user;

  ProfileCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        color: Colors.lightBlueAccent.shade100,
        child: InkResponse(
          containedInkWell: true,
          child: Container(
            padding: EdgeInsets.all(20),
            child: MultiRepositoryProvider(
              providers: [
                RepositoryProvider(
                  create: (context) => EducationalEnvsService(
                    apiRepository:
                        RepositoryProvider.of<ApiRepository>(context),
                  ),
                ),
                RepositoryProvider(
                  create: (context) => DepartmentService(
                    apiRepository:
                        RepositoryProvider.of<ApiRepository>(context),
                  ),
                ),
              ],
              child: BlocProvider(
                create: (context) => ProfileCardCubit(
                  educationalEnvsService:
                      RepositoryProvider.of<EducationalEnvsService>(context),
                  departmentService:
                      RepositoryProvider.of<DepartmentService>(context),
                  user: user,
                )..loading(),
                child: BlocBuilder<ProfileCardCubit, ProfileCardState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    switch (state.status) {
                      case Status.success:
                        return Row(
                          children: [
                            Icon(
                              Icons.account_circle,
                              size: 60,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${user.surname} ${user.name} ${user.patronymic}",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(user.role.toString()),
                                Text("Кафедра ${state.department!.name}"),
                                Text("Организация ${state.env!.name}"),
                              ],
                            ),
                          ],
                        );
                      case Status.failure:
                        return Center(
                          child: Text("Ошибка загрузки данных"),
                        );
                      default:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
