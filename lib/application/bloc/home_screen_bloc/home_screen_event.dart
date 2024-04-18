part of 'home_screen_bloc.dart';

class HomeScreenEvent {
  HomeScreenEvent();

  factory HomeScreenEvent.loadingCources() => _LoadingCourcesEvent();
}

class _LoadingCourcesEvent extends HomeScreenEvent {}
