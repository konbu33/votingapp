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
      );
    }

    Widget passwordField() {
      return TextFormField(
        controller: passwordController,
      );
    }

    Widget submitField() {
      Future<void> addUser() async {
        final firebaseuser = context.read<User?>();
        final String? uid = firebaseuser?.uid;
        final String? email = firebaseuser?.email;
        final res = await context.read<UserModel>().addUser(uid, email);
        print("res : $res");
      }

      Future<void> onPressed() async {
        final res = await context.read<AuthenticationService>().signUp(
            emailController.text.trim(), passwordController.text.trim());
        print("res: $res");

        addUser();
        Navigator.of(context).pop();

        // final firebaseuser = context.watch<User?>();
        // final firebaseuser =
        // context.watch<AuthenticationService>().authStateChanges;
        // print("firebaseuser sign up: $firebaseuser");

        // if (firebaseuser != null) {
        // Navigator.of(context).pushNamed('votingpage');
        // }
      }

      return ElevatedButton(onPressed: onPressed, child: const Text("submit"));
    }

    // context.watch<User?>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp Page"),
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
