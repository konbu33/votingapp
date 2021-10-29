import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:votingapp/model/votinghistorymodel.dart';
import 'model/authentication_service.dart';
import 'signinpage.dart';
import 'signuppage.dart';
import 'votingpage/votingpage.dart';
import 'model/usermodel.dart';
import 'model/namemodel.dart';
import 'votingpage/recreatevotelist.dart';

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
        ChangeNotifierProvider(create: (_) => UserModel()),
        Provider(create: (_) => NameModel(FirebaseFirestore.instance)),
        StreamProvider(
            create: (_) => context.read<NameModel>().getNames,
            initialData: null),
        ChangeNotifierProvider(create: (_) => VotingHistoryModel()),
        StreamProvider(
            create: (context) =>
                context.read<VotingHistoryModel>().getVotingHistory,
            initialData: null),
        FutureProvider(
            create: (context) => context.read<UserModel>().getUsers(),
            initialData: null),
        Provider(create: (_) => ReCreateVoteList()),
      ],
      child: MaterialApp(
          title: "Voting App",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'NotoSansJP',
            // fontFamily: 'NotoSerifJP',
            // fontFamily: 'Hiragino Kaku Gothic ProN',
          ),
          home: const AuthWrapper(),
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
