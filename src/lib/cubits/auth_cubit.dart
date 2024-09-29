
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_app/cubits/auth_state.dart';
import 'package:com.example.simple_app/models/user_model.dart';

class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(AuthUnauthenticated());

	void login(String email, String password) async {
		try {
			emit(AuthLoading());
			// Simulate network call
			await Future.delayed(Duration(seconds: 1));
			if (email == 'test@example.com' && password == 'password123') {
				emit(AuthAuthenticated(UserModel(email: email, password: password)));
			} else {
				emit(AuthError('Login failed'));
			}
		} catch (e) {
			emit(AuthError('An error occurred'));
		}
	}

	void logout() async {
		try {
			emit(AuthLoading());
			// Simulate network call
			await Future.delayed(Duration(seconds: 1));
			emit(AuthUnauthenticated());
		} catch (e) {
			emit(AuthError('An error occurred'));
		}
	}
}
