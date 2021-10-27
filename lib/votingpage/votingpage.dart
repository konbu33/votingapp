import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:votingapp/model/usermodel.dart';
import 'package:votingapp/model/votinghistorymodel.dart';
import '../model/namemodel.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signoutbutton.dart';
import 'namelistview.dart';
import 'namefield.dart';
import 'recreatevotelist.dart';

class VotingPage extends StatelessWidget {
  const VotingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ReCreateVoteList>().reCreateVoteList(
        context.read<UserModel>(), context.read<VotingHistoryModel>());

    return Scaffold(
      appBar: AppBar(
        title: const Text("名前候補一覧"),
        actions: const [
          SignOutButton(),
        ],
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: NameListView()),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String uid = context.read<User?>()!.uid;
          String newName = context.read<NameModel>().newNameController.text;
          print("uid : ${uid}, newName : ${newName}");
          context.read<NameModel>().addName(uid, newName);
          context.read<NameModel>().newNameController.clear();
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 6.0,
        shape: const AutomaticNotchedShape(
          RoundedRectangleBorder(),
          StadiumBorder(
            side: BorderSide(),
          ),
        ),
        color: Theme.of(context).primaryColor,
        child: Container(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.3),
            child: const NameField()),
      ),
    );
  }
}
