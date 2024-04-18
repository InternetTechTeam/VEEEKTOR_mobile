import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:veeektor/application/repository/api/api_repository.dart';
import 'package:veeektor/application/service/courses_service.dart';
import 'package:veeektor/model/status.dart';
import 'package:veeektor/screens/course_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Курсы"),
      ),
      body: RepositoryProvider(
        create: (context) => CoursesService(
          apiRepository: RepositoryProvider.of<ApiRepository>(context),
        ),
        child: BlocProvider(
          create: (context) => HomeScreenBloc(
            coursesService: RepositoryProvider.of<CoursesService>(context),
          )..add(HomeScreenEvent.loadingCources()),
          child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
            builder: (context, state) {
              switch (state.status) {
                case Status.success:
                  if (state.courses == null) {
                    return Center(
                      child: Text("У вас пока нет курсов"),
                    );
                  }
                  return ListView.separated(
                    itemCount: state.courses!.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      return InkResponse(
                        containedInkWell: true,
                        child: Text(state.courses![index].name),
                        onTap: () {
                          Navigator.push(context, CourseScreen.route());
                        },
                      );
                    },
                  );
                case Status.failure:
                  return Center(
                    child: Text("Ошибка ${state.errorMessage}"),
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
    );
  }
}
