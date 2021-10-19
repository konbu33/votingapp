import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:votingapp/authentication_service.dart';
import 'signinpage.dart';
import 'signuppage.dart';
import 'votingpage.dart';
import 'usermodel.dart';
import 'namemodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => AuthenticationService(FirebaseAuth.instance)),
        StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
            initialData: null),
        Provider(create: (_) => UserModel()),
        Provider(create: (_) => NameModel(FirebaseFirestore.instance)),
        StreamProvider(
            create: (_) => context.read<NameModel>().getNames,
            initialData: null),
      ],
      child: MaterialApp(
        home: const AuthWrapper(
            beforeSignedInPage: SignInPage(), afterSignedInPage: VotingPage()),
        routes: <String, WidgetBuilder>{
          "/votingpage": (context) => const AuthWrapper(
              beforeSignedInPage: SignInPage(),
              afterSignedInPage: VotingPage()),
          "/signinpage": (context) => const AuthWrapper(
              beforeSignedInPage: SignInPage(),
              afterSignedInPage: VotingPage()),
          // "/signuppage": (context) => const SignUpPage(),
          "/signuppage": (context) => const AuthWrapper(
              beforeSignedInPage: SignUpPage(),
              afterSignedInPage: VotingPage()),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper(
      {Key? key,
      required this.beforeSignedInPage,
      required this.afterSignedInPage})
      : super(key: key);

  final Widget beforeSignedInPage;
  final Widget afterSignedInPage;

  @override
  Widget build(BuildContext context) {
    // final firebaseuser = context.read<User?>();
    // context.watch<User?>();
    final firebaseuser = context.watch<User?>();

    print('firebaseuser: $firebaseuser');
    if (firebaseuser != null) return afterSignedInPage;
    return beforeSignedInPage;
  }
}
