
import 'dart:convert';

class UserModel {
	final String email;
	final String password;

	UserModel({
		required this.email,
		required this.password,
	});

	Map<String, dynamic> toJson() {
		return {
			'email': email,
			'password': password,
		};
	}

	factory UserModel.fromJson(Map<String, dynamic> json) {
		return UserModel(
			email: json['email'],
			password: json['password'],
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(this, other)) return true;

		return other is UserModel &&
			other.email == email &&
			other.password == password;
	}

	@override
	int get hashCode => email.hashCode ^ password.hashCode;
}
