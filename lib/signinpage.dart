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
        decoration: const InputDecoration(labelText: "メールアドレス"),
        autofocus: true,
      );
    }

    Widget passwordField() {
      return TextFormField(
        controller: passwordController,
        decoration: const InputDecoration(labelText: "パスワード"),
        obscureText: true,
      );
    }

    Widget submitField() {
      Future<void> onPressed() async {
        await context.read<AuthenticationService>().signIn(
            emailController.text.trim(), passwordController.text.trim());
      }

      return Container(
        constraints: BoxConstraints(minWidth: double.infinity),
        child: ElevatedButton(
          onPressed: onPressed,
          child: const Text("ログイン"),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      );
    }

    Widget signUpButton() {
      void onPressed() {
        Navigator.of(context).pushNamed('/signuppage');
      }

      return TextButton(
          onPressed: onPressed,
          child: const Text(
            "新規登録",
            style: TextStyle(color: Colors.white),
          ));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("ログイン"),
        actions: [signUpButton()],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            emailField(),
            passwordField(),
            const SizedBox(
              height: 50,
            ),
            submitField(),
          ],
        ),
      ),
    );
  }
}
