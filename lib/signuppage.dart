import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votingapp/usermodel.dart';
import 'authentication_service.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

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
      Future<void> addUser() async {
        final firebaseuser = context.read<User?>();
        final String? uid = firebaseuser?.uid;
        final String? email = firebaseuser?.email;
        print("uid : $uid, email : $email");

        if (uid != null) {
          final res = await context.read<UserModel>().addUser(uid, email);
          print("res addUser : $res");
        }
      }

      Future<void> onPressed() async {
        final res = await context.read<AuthenticationService>().signUp(
            emailController.text.trim(), passwordController.text.trim());
        print("res signUp: $res");

        addUser();
        Navigator.of(context).pop();
      }

      return Container(
        constraints: BoxConstraints(minWidth: double.infinity),
        child: ElevatedButton(
          onPressed: onPressed,
          child: const Text("新規登録"),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("新規登録")),
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
