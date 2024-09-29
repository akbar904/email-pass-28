
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_app/screens/login_screen.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

// Mock classes
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginScreen Widget Tests', () {
		testWidgets('displays email and password fields and login button', (WidgetTester tester) async {
			// Build the LoginScreen widget.
			await tester.pumpWidget(MaterialApp(home: LoginScreen()));

			// Verify the email and password TextFields and the login button.
			expect(find.byType(TextField), findsNWidgets(2));
			expect(find.byType(ElevatedButton), findsOneWidget);
			expect(find.text('Login'), findsOneWidget);
		});

		testWidgets('shows error message when login fails', (WidgetTester tester) async {
			final mockAuthCubit = MockAuthCubit();

			// When the login fails, the state should be AuthState.failure
			whenListen(
				mockAuthCubit,
				Stream.fromIterable([AuthState.failure('Invalid credentials')]),
				initialState: AuthState.initial(),
			);

			// Build the LoginScreen widget with the mocked AuthCubit.
			await tester.pumpWidget(
				BlocProvider.value(
					value: mockAuthCubit,
					child: MaterialApp(home: LoginScreen()),
				),
			);

			// Verify that the error message is displayed.
			await tester.pump(); // Rebuild the widget with the new state.
			expect(find.text('Invalid credentials'), findsOneWidget);
		});
	});

	group('AuthCubit Tests', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		blocTest<MockAuthCubit, AuthState>(
			'emits [AuthState.loading(), AuthState.authenticated()] when login is successful',
			build: () => mockAuthCubit,
			act: (cubit) {
				when(() => mockAuthCubit.login('test@example.com', 'password'))
					.thenAnswer((_) async => cubit.emit(AuthState.authenticated()));
				cubit.login('test@example.com', 'password');
			},
			expect: () => [
				AuthState.loading(),
				AuthState.authenticated(),
			],
		);

		blocTest<MockAuthCubit, AuthState>(
			'emits [AuthState.loading(), AuthState.failure()] when login fails',
			build: () => mockAuthCubit,
			act: (cubit) {
				when(() => mockAuthCubit.login('wrong@example.com', 'wrongpassword'))
					.thenAnswer((_) async => cubit.emit(AuthState.failure('Invalid credentials')));
				cubit.login('wrong@example.com', 'wrongpassword');
			},
			expect: () => [
				AuthState.loading(),
				AuthState.failure('Invalid credentials'),
			],
		);
	});
}
