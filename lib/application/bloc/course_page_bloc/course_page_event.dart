part of 'course_page_bloc.dart';

@immutable
sealed class CoursePageEvent {
  const CoursePageEvent();
  factory CoursePageEvent.loadingmarkdown() => _LoadingMarkdown();
}

class _LoadingMarkdown extends CoursePageEvent {}
