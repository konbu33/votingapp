import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication_service.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Widget emailField() {
      return TextFormField(
        controller: emailController,
      );
    }

    Widget passwordField() {
      return TextFormField(
        controller: passwordController,
      );
    }

    Widget submitField() {
      Future<void> onPressed() async {
        await context.read<AuthenticationService>().signIn(
            emailController.text.trim(), passwordController.text.trim());
      }

      return ElevatedButton(onPressed: onPressed, child: const Text("submit"));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("SignIn Page"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/signuppage');
            },
            child: Text(
              "Sign Up",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          emailField(),
          passwordField(),
          const SizedBox(
            height: 50,
          ),
          submitField(),
        ],
      ),
    );
  }
}
