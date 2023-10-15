import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_bloc_event.dart';
part 'authentication_bloc_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationBlocEvent, AuthenticationBlocState> {
  final UserRepository userRepository;
	late final StreamSubscription<User?> _userSubscription;

	AuthenticationBloc({
		required this.userRepository
	}) : super(const AuthenticationBlocState.unknown()) {
    _userSubscription = userRepository.user.listen((user) {
			add(AuthenticationUserChanged(user));
		});
		on<AuthenticationUserChanged>((event, emit) {
			if(event.user != null) {
				emit(AuthenticationBlocState.authenticated(event.user!));
			} else {
				emit(const AuthenticationBlocState.unauthenticated());
			}
		});
  }
	
	@override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}