
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_app/screens/home_screen.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		testWidgets('displays logout button', (WidgetTester tester) async {
			// Build HomeScreen
			await tester.pumpWidget(
				MaterialApp(
					home: HomeScreen(),
				),
			);

			// Verify if Logout button is displayed
			expect(find.text('Logout'), findsOneWidget);
		});
	});

	group('AuthCubit Tests', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		blocTest<MockAuthCubit, AuthState>(
			'emits [Unauthenticated] when logout is called',
			build: () => mockAuthCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [isA<Unauthenticated>()],
		);
	});
}
