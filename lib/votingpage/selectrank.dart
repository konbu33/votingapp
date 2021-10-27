import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:votingapp/model/votinghistorymodel.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:votingapp/votingpage/recreatevotelist.dart';
import '../model/usermodel.dart';
import '../model/votinghistorymodel.dart';

class SelectRank extends StatelessWidget {
  const SelectRank({Key? key, this.snapshot}) : super(key: key);

  final snapshot;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: DropdownButton(
        items: const [
          DropdownMenuItem(
            child: Text(""),
            value: "",
          ),
          DropdownMenuItem(
            child: Text("第1候補"),
            value: "1",
          ),
          DropdownMenuItem(
            child: Text("第2候補"),
            value: "2",
          ),
          DropdownMenuItem(
            child: Text("第3候補"),
            value: "3",
          ),
        ],
        value: "",
        onChanged: (value) async {
          context.read<VotingHistoryModel>().setSelectRankNum =
              value.toString();
          final user = context.read<User?>();
          String uid = "";
          if (user == null) {
            uid = "isNull.";
          } else {
            uid = user.uid;
          }
          String nameId = snapshot.id;
          print(
              "uid: ${uid}, nameId: ${nameId}, selectRankNum: ${context.read<VotingHistoryModel>().getSelectRankNum}");

          List<UserModelInfo> _currentUserModelInfo = context
              .read<UserModel>()
              .userList
              .where((element) => element.userModelInfo["uid"] == uid)
              .toList();

          String photoUrl =
              _currentUserModelInfo.first.userModelInfo["photoUrl"];

          final res = await context
              .read<VotingHistoryModel>()
              .addVotingHisotry(uid, nameId, value.toString(), photoUrl);

          print("res: ${res.toString()}");

          context.read<ReCreateVoteList>().reCreateVoteList(
                context.read<UserModel>(),
                context.read<VotingHistoryModel>(),
              );
        },
      ),
      title: Text("${snapshot.get("name")}"),
      subtitle: Text("${snapshot.get("nameYomi")}"),
      selectedTileColor: Colors.grey,
      hoverColor: Colors.grey,
    );
  }
}
