
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_app/models/user_model.dart';

void main() {
	group('UserModel', () {
		group('serialization', () {
			test('should convert UserModel to JSON', () {
				final user = UserModel(email: 'test@example.com', password: 'password123');
				final json = user.toJson();
				expect(json, {
					'email': 'test@example.com',
					'password': 'password123',
				});
			});

			test('should create UserModel from JSON', () {
				final json = {
					'email': 'test@example.com',
					'password': 'password123',
				};
				final user = UserModel.fromJson(json);
				expect(user.email, 'test@example.com');
				expect(user.password, 'password123');
			});
		});

		group('equality & hashCode', () {
			test('should consider two UserModel instances equal if they have the same email and password', () {
				final user1 = UserModel(email: 'test@example.com', password: 'password123');
				final user2 = UserModel(email: 'test@example.com', password: 'password123');
				expect(user1, equals(user2));
			});

			test('should have the same hashCode for equal UserModel instances', () {
				final user1 = UserModel(email: 'test@example.com', password: 'password123');
				final user2 = UserModel(email: 'test@example.com', password: 'password123');
				expect(user1.hashCode, equals(user2.hashCode));
			});
		});
	});
}
