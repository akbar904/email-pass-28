
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
	final UserModel user;
	Authenticated(this.user);
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
	final String message;
	AuthError(this.message);
}

class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(AuthInitial());

	void login(String email, String password) async {
		try {
			emit(AuthLoading());
			// Simulate a login delay
			await Future.delayed(Duration(seconds: 2));
			if (email == 'test@example.com' && password == 'password') {
				emit(Authenticated(UserModel(email: email)));
			} else {
				emit(AuthError('Login failed'));
			}
		} catch (e) {
			emit(AuthError('An error occurred'));
		}
	}

	void logout() async {
		emit(Unauthenticated());
	}
}
