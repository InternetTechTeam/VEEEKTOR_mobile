part of 'course_page_bloc.dart';

class CoursePageState {
  Status status;
  Course course;
  String? markdown;
  String? errorMessage;

  CoursePageState(
      {required this.course,
      required this.status,
      this.markdown,
      this.errorMessage});

  factory CoursePageState.initial({required Course course}) => CoursePageState(
        course: course,
        status: Status.nun,
        markdown: null,
        errorMessage: null,
      );

  CoursePageState copyWith({
    Course? course,
    Status? status,
    String? markdown,
    String? errorMessage,
  }) =>
      CoursePageState(
        course: course ?? this.course,
        status: status ?? this.status,
        markdown: markdown ?? this.markdown,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [status];
}
