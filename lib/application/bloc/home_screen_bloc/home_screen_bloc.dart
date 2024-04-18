import 'package:bloc/bloc.dart';
import 'package:veeektor/application/service/courses_service.dart';
import 'package:veeektor/model/course.dart';
import 'package:veeektor/model/response/response.dart';
import 'package:veeektor/model/status.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final CoursesService _coursesService;

  HomeScreenBloc({required CoursesService coursesService})
      : _coursesService = coursesService,
        super(HomeScreenState.intial()) {
    on<_LoadingCourcesEvent>(_loadingCources);
  }

  Future _loadingCources(
      _LoadingCourcesEvent event, Emitter<HomeScreenState> emit) async {
    emit(state.copyWith(status: Status.loading));
    MyResponse response = await _coursesService.getUserCources();
    if (response.statusCode == 200) {
      emit(state.copyWith(
        status: Status.success,
        courses: response.body,
      ));
    } else {
      emit(state.copyWith(
        status: Status.failure,
        errorMessage: response.errorMessage,
      ));
    }
  }
}
