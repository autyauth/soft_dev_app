part of 'authentication_bloc_bloc.dart';

enum AuthenticationBlocStatus { authenticated, unauthenticated, unknown }

class AuthenticationBlocState extends Equatable {
  const AuthenticationBlocState._(
      {this.status = AuthenticationBlocStatus.unknown, 
      this.user
  });

  const AuthenticationBlocState.unknown() : this._();

  const AuthenticationBlocState.authenticated(User user)
      : this._(status: AuthenticationBlocStatus.authenticated, user: user
  );

  const AuthenticationBlocState.unauthenticated()
      : this._(status: AuthenticationBlocStatus.unauthenticated);

  final AuthenticationBlocStatus status;
  final User? user;

  @override
  List<Object?> get props => [status, user];
}
