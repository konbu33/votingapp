import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'authentication_service.dart';
import 'signinpage.dart';
import 'signuppage.dart';
import 'votingpage.dart';
import 'usermodel.dart';
import 'namemodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          title: "Voting App",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: AuthWrapper(),
          routes: <String, WidgetBuilder>{
            "/votingpage": (context) => VotingPage(),
            "/signinpage": (context) => SignInPage(),
            "/signuppage": (context) => SignUpPage(),
          }),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseuser = context.watch<User?>();
    print("firebaseuser: $firebaseuser");

    if (firebaseuser != null) {
      return const VotingPage();
    }
    return const SignInPage();
  }
}
