import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:veeektor/application/bloc/course_page_bloc/course_page_bloc.dart';
import 'package:veeektor/application/repository/api/api_repository.dart';
import 'package:veeektor/application/service/courses_service.dart';
import 'package:veeektor/model/course.dart';
import 'package:veeektor/model/status.dart';

class CourseScreen extends StatelessWidget {
  final Course course;
  const CourseScreen({super.key, required this.course});

  static Route<dynamic> route(Course course) => MaterialPageRoute(
        builder: (context) => CourseScreen(
          course: course,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.name),
        centerTitle: true,
      ),
      body: RepositoryProvider(
        create: (context) => CoursesService(
          apiRepository: RepositoryProvider.of<ApiRepository>(context),
        ),
        child: BlocProvider(
          create: (context) => CoursePageBloc(
            coursesService: RepositoryProvider.of<CoursesService>(context),
            course: course,
          )..add(CoursePageEvent.loadingmarkdown()),
          child: CourseForm(),
        ),
      ),
    );
  }
}

class CourseForm extends StatelessWidget {
  const CourseForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursePageBloc, CoursePageState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        switch (state.status) {
          case Status.failure:
            return Center(
              child: Text(state.errorMessage ?? "Что-то пошло не так..."),
            );
          case Status.success:
            return Markdown(data: state.markdown!);
          default:
            return Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
