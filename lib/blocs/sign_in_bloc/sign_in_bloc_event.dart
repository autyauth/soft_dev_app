part of 'sign_in_bloc_bloc.dart';

sealed class SignInBlocEvent extends Equatable {
  const SignInBlocEvent();

  @override
  List<Object> get props => [];
}

class SignInRequired extends SignInBlocEvent{
	final String email;
	final String password;

	const SignInRequired(this.email, this.password);
}

class SignOutRequired extends SignInBlocEvent{

	const SignOutRequired();
}