import 'package:flutter/material.dart';
import '../model/authentication_service.dart';
import 'package:provider/provider.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onPressed() {
      context.read<AuthenticationService>().signOut();
    }

    return TextButton(
      onPressed: onPressed,
      child: const Text(
        "ログアウト",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
