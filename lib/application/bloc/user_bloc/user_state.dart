part of 'user_bloc.dart';

class UserState {
  User? user;
  UserStatus status;
  UserState({this.user, required this.status});

  factory UserState.initial() => UserState(user: null, status: UserStatus.nun);

  UserState copyWith({User? user, UserStatus? status}) => UserState(
        user: user ?? this.user,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [user];
}

enum UserStatus { nun, logged, notLogged }
