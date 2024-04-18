part of 'home_screen_bloc.dart';

class HomeScreenState {
  List<Course>? courses;
  Status status;
  String? errorMessage;

  HomeScreenState({
    this.courses,
    required this.status,
    this.errorMessage,
  });

  factory HomeScreenState.intial() => HomeScreenState(
        courses: null,
        status: Status.nun,
        errorMessage: null,
      );

  HomeScreenState copyWith({
    List<Course>? courses,
    Status? status,
    String? errorMessage,
  }) =>
      HomeScreenState(
        courses: courses ?? this.courses,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [status];
}
