part of 'user_bloc.dart';

class UserEvent {
  UserEvent();

  factory UserEvent.runApp() => _RunAppEvent();
  factory UserEvent.logged() => _UserLoggedEvent();
  factory UserEvent.userDataChanged({required User user}) =>
      _UserDataChangedEvent(user: user);
  factory UserEvent.logout() => _UserLogoutEvent();
}

class _RunAppEvent extends UserEvent {}

class _UserLoggedEvent extends UserEvent {}

class _UserDataChangedEvent extends UserEvent {
  User user;

  _UserDataChangedEvent({required this.user});
}

class _UserLogoutEvent extends UserEvent {}
