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
import 'ztemp_showcurrentvote.dart';
import 'ztemp_showuserlist.dart';
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
          // constraints:
          // BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Flexible(child: ShowCurrentVote()),
              // Flexible(child: ShowUserList()),
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




      //   child: Stack(
      //     alignment: AlignmentDirectional(1, -8),
      //     children: [
      //       TextFormField(
      //         controller: nameController,
      //         style: TextStyle(color: Colors.white, fontSize: 18),
      //         decoration: const InputDecoration(
      //           labelText: "名前候補を追加",
      //           labelStyle: TextStyle(color: Colors.white),
      //           enabledBorder: UnderlineInputBorder(
      //               borderSide: BorderSide(color: Colors.white)),
      //           focusedBorder: UnderlineInputBorder(
      //               borderSide: BorderSide(color: Colors.white)),
      //         ),
      //       ),
      //       Container(
      //         // color: Colors.yellow,
      //         child: ElevatedButton(
      //           onPressed: () async {
      //             String uid = context.read<User?>()!.uid;
      //             print("uid: $uid, name : ${nameController.text}");
      //             final res = await context
      //                 .read<NameModel>()
      //                 .addName(uid, nameController.text);
      //             nameController.clear();
      //             // print("res addName : $res");
      //           },
      //           child: const Icon(Icons.add, color: Colors.white),
      //           style: ElevatedButton.styleFrom(
      //             minimumSize: Size(55, 55),
      //             shape: CircleBorder(
      //               side: BorderSide(
      //                   color: Colors.white,
      //                   width: 3.0,
      //                   style: BorderStyle.solid),
      //             ),
      //             elevation: 3,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // );
