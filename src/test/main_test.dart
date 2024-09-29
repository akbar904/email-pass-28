
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/main.dart';

void main() {
	group('Main:', () {
		testWidgets('MyApp has a MaterialApp', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());

			// Verify if MyApp contains a MaterialApp
			expect(find.byType(MaterialApp), findsOneWidget);
		});

		testWidgets('MyApp initializes with LoginScreen', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());

			// Verify if the initial screen is LoginScreen
			expect(find.text('Login'), findsOneWidget);
		});
	});
}
