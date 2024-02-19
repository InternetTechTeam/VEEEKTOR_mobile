part of 'authefication_bloc.dart';

class AutheficationState {
  AutheficationState({required this.status});

  AutheficationStatus status;

  factory AutheficationState.initial() =>
      AutheficationState(status: AutheficationStatus.nun);

  AutheficationState copyWith({AutheficationStatus? status}) =>
      AutheficationState(status: status ?? this.status);

  @override
  List<Object> get props => [status];
}

enum AutheficationStatus { autheficated, notAutheficated, loading, nun }
