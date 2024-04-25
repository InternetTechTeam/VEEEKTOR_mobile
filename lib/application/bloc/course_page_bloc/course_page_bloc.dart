import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:veeektor/application/service/courses_service.dart';
import 'package:veeektor/model/course.dart';
import 'package:veeektor/model/response/response.dart';
import 'package:veeektor/model/status.dart';

part 'course_page_event.dart';
part 'course_page_state.dart';

class CoursePageBloc extends Bloc<CoursePageEvent, CoursePageState> {
  final CoursesService _coursesService;

  CoursePageBloc(
      {required CoursesService coursesService, required Course course})
      : _coursesService = coursesService,
        super(CoursePageState.initial(course: course)) {
    on<_LoadingMarkdown>(_loadingMarkdown);
  }

  _loadingMarkdown(
      _LoadingMarkdown event, Emitter<CoursePageState> emit) async {
    emit(state.copyWith(status: Status.loading));

    MyResponse response =
        await _coursesService.getCourseById(id: state.course.id);

    if (response.statusCode == 200) {
      emit(state.copyWith(
          status: Status.success, markdown: response.body["markdown"]));
    } else {
      emit(state.copyWith(
        status: Status.failure,
        errorMessage: response.errorMessage,
      ));
    }
  }
}
