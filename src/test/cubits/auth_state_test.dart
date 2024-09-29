
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_app/cubits/auth_state.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('AuthState Cubit Tests', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		test('initial state is AuthInitial', () {
			expect(mockAuthCubit.state, AuthInitial());
		});

		blocTest<MockAuthCubit, AuthState>(
			'emits [AuthLoading, Authenticated] when login is successful',
			build: () => mockAuthCubit,
			act: (cubit) {
				when(() => cubit.login(any(), any())).thenAnswer((_) async {
					cubit.emit(AuthLoading());
					cubit.emit(Authenticated(UserModel(email: 'test@example.com')));
				});
				cubit.login('test@example.com', 'password');
			},
			expect: () => [AuthLoading(), Authenticated(UserModel(email: 'test@example.com'))],
		);

		blocTest<MockAuthCubit, AuthState>(
			'emits [AuthLoading, AuthError] when login fails',
			build: () => mockAuthCubit,
			act: (cubit) {
				when(() => cubit.login(any(), any())).thenAnswer((_) async {
					cubit.emit(AuthLoading());
					cubit.emit(AuthError('Login failed'));
				});
				cubit.login('test@example.com', 'wrong_password');
			},
			expect: () => [AuthLoading(), AuthError('Login failed')],
		);

		blocTest<MockAuthCubit, AuthState>(
			'emits [Unauthenticated] when logout is called',
			build: () => mockAuthCubit,
			act: (cubit) {
				when(() => cubit.logout()).thenAnswer((_) async {
					cubit.emit(Unauthenticated());
				});
				cubit.logout();
			},
			expect: () => [Unauthenticated()],
		);
	});
}
