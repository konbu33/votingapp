import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:votingapp/model/votinghistorymodel.dart';
import '../model/namemodel.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../editpage.dart';
import 'votetag.dart';
import 'selectrank.dart';

class NameListView extends StatelessWidget {
  const NameListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> createVoteTagList(String nameId) {
      final _currentVoteList = context
          .watch<VotingHistoryModel>()
          .currentVoteList
          .map((e) => e.voteInfo)
          .toList();

      final a = _currentVoteList
          .where((element) => element["nameId"] == nameId)
          .toList();
      if (a.length != 0) {
        return a
            .map((e) =>
                VoteTag(imageAsset: e["photoUrl"], rankNum: e["selectRankNum"]))
            .toList();
      }

      return [
        Text(""),
      ];
    }

    Widget nameListView() {
      Widget _listItem(QueryDocumentSnapshot snapshot) {
        return Slidable(
          actionExtentRatio: 0.2,
          actionPane: const SlidableScrollActionPane(),
          actions: [
            IconSlideAction(
              caption: "編集",
              color: Colors.green,
              icon: Icons.edit,
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.white.withOpacity(0),
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: EditPage(docId: snapshot.id),
                  ),
                );
              },
            ),
          ],
          secondaryActions: [
            IconSlideAction(
              caption: "削除",
              color: Colors.orange,
              icon: Icons.delete,
              onTap: () async {
                final res =
                    await context.read<NameModel>().delName(snapshot.id);
              },
            ),
          ],
          child: Row(
            children: [
              Flexible(child: SelectRank(snapshot: snapshot)),
              Wrap(
                children: createVoteTagList(snapshot.id),
              ),
            ],
          ),
        );
      }

      Widget _listView(List<QueryDocumentSnapshot> snapshot) {
        return ListView.separated(
          itemBuilder: (context, index) {
            return _listItem(snapshot[index]);
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: snapshot.length,
        );
      }

      return StreamBuilder(
          stream: context.read<NameModel>().getNames,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState != ConnectionState.active) {
              return const CircularProgressIndicator();
            }

            QuerySnapshot querySnapshot = snapshot.data as QuerySnapshot;
            if (querySnapshot.docs == null) {
              print("querySnapshot is null.");
            }
            return _listView(querySnapshot.docs);
          });
    }

    return nameListView();
  }
}
