import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:votingapp/model/votinghistorymodel.dart';
import 'package:provider/provider.dart';
import '../model/usermodel.dart';

class ShowCurrentVote extends StatelessWidget {
  const ShowCurrentVote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget showCurrentVote() {
      Widget _getCurrentVote(String uid, String rankNum) {
        return StreamBuilder(
          stream:
              context.read<VotingHistoryModel>().getCurrentVote(uid, rankNum),
          builder: (context, snapshot) {
            // if (snapshot.connectionState != ConnectionState.active)
            //   return CircularProgressIndicator();

            print("xxx : ${snapshot.connectionState}");
            if (!snapshot.hasData) return const CircularProgressIndicator();
            if (snapshot.hasError) return const Text("Error");

            // Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
            final data = snapshot.data as Vote;
            final currentVote = {
              "uid": data.voteInfo["uid"],
              "nameId": data.voteInfo["nameId"],
              "selectRankNm": data.voteInfo["selectRankNum"],
              // "uid": "uid",
              // "nameId": "nameId",
              // "selectRankNm": "selectRankNum",
            };
            return Text("te: ${currentVote.toString()}");
          },
        );
      }

      List<Map<String, dynamic>> _currentUserList = context
          .watch<UserModel>()
          .getLatestUserList
          .map((e) => e.userModelInfo)
          .toList();

      if (_currentUserList.length == 0) return CircularProgressIndicator();

      List<String> uidList = _currentUserList.map((element) {
        print("element hhhh: ${element["uid"]}");
        return element["uid"].toString();
      }).toList();

      // List<String> uidList = [
      //   "0GekrpJFODRYDCvkVB3CkXErSel2",
      //   "SvgYxYIFAebwG7BrtDyyLMt95KT2"
      // ];

      return ListView.separated(
          itemCount: uidList.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            return Column(children: [
              _getCurrentVote(uidList[index], "1"),
              _getCurrentVote(uidList[index], "2"),
              _getCurrentVote(uidList[index], "3"),
            ]);
          });
    }

    return showCurrentVote();
  }
}
