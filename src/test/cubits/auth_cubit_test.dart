
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_app/cubits/auth_cubit.dart';
import 'package:com.example.simple_app/cubits/auth_state.dart';
import 'package:com.example.simple_app/models/user_model.dart';

class MockUserModel extends Mock implements UserModel {}

void main() {
	group('AuthCubit', () {
		late AuthCubit authCubit;
		late MockUserModel mockUser;

		setUp(() {
			mockUser = MockUserModel();
			authCubit = AuthCubit();
		});

		tearDown(() {
			authCubit.close();
		});

		group('login', () {
			blocTest<AuthCubit, AuthState>(
				'emits [AuthLoading, AuthAuthenticated] when login is successful',
				build: () => authCubit,
				act: (cubit) => cubit.login('test@example.com', 'password123'),
				expect: () => [
					AuthLoading(),
					AuthAuthenticated(UserModel(email: 'test@example.com', password: 'password123')),
				],
			);

			blocTest<AuthCubit, AuthState>(
				'emits [AuthLoading, AuthError] when login fails',
				build: () => authCubit,
				act: (cubit) => cubit.login('wrong@example.com', 'wrongpassword'),
				expect: () => [
					AuthLoading(),
					AuthError('Login failed'),
				],
			);
		});

		group('logout', () {
			blocTest<AuthCubit, AuthState>(
				'emits [AuthLoading, AuthUnauthenticated] when logout is called',
				build: () => authCubit,
				act: (cubit) => cubit.logout(),
				expect: () => [
					AuthLoading(),
					AuthUnauthenticated(),
				],
			);
		});
	});
}
