
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/auth_state.dart';

class LoginScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		final authCubit = context.read<AuthCubit>();
		final emailController = TextEditingController();
		final passwordController = TextEditingController();

		return Scaffold(
			appBar: AppBar(
				title: Text('Login'),
			),
			body: BlocListener<AuthCubit, AuthState>(
				listener: (context, state) {
					if (state is AuthStateFailure) {
						ScaffoldMessenger.of(context).showSnackBar(
							SnackBar(content: Text(state.errorMessage)),
						);
					}
				},
				child: Padding(
					padding: const EdgeInsets.all(16.0),
					child: Column(
						children: [
							TextField(
								controller: emailController,
								decoration: InputDecoration(labelText: 'Email'),
							),
							TextField(
								controller: passwordController,
								decoration: InputDecoration(labelText: 'Password'),
								obscureText: true,
							),
							SizedBox(height: 20),
							ElevatedButton(
								onPressed: () {
									authCubit.login(emailController.text, passwordController.text);
								},
								child: Text('Login'),
							),
						],
					),
				),
			),
		);
	}
}
