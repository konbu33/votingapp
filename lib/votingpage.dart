import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:votingapp/namemodel.dart';
import 'authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'editpage.dart';

class VotingPage extends StatelessWidget {
  const VotingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget nameListView() {
      Widget _listItem(QueryDocumentSnapshot snapshot) {
        return Slidable(
          actionExtentRatio: 0.2,
          // actionPane: SlidableBehindActionPane(),
          // actionPane: SlidableDrawerActionPane(),
          // actionPane: SlidableStrechActionPane(),
          actionPane: const SlidableScrollActionPane(),
          actions: [
            IconSlideAction(
              caption: "edit",
              color: Colors.green,
              icon: Icons.edit,
              onTap: () {
                // print("edit onTap: ${snapshot.id}");
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => EditPage(docId: snapshot.id),
                );
              },
            ),
          ],
          secondaryActions: [
            IconSlideAction(
              caption: "delete",
              color: Colors.orange,
              icon: Icons.delete,
              onTap: () async {
                // print("delete onTap: ${snapshot.id}");
                final res =
                    await context.read<NameModel>().delName(snapshot.id);
                // print("res : ${res}");
              },
            ),
          ],
          child: ListTile(
            title: Text("${snapshot.get("name")}"),
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
          // stream: FirebaseFirestore.instance.collection('names').snapshots(),
          stream: context.watch<NameModel>().getNames,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState != ConnectionState.active) {
              return const CircularProgressIndicator();
            }
            return _listView(snapshot.data!.docs);
          });
    }

    Widget nameField() {
      TextEditingController nameController = TextEditingController();
      return Row(
        children: [
          Flexible(
            child: TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "名前候補を追加",
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              String uid = context.read<User?>()!.uid;
              // print("uid: $uid, name : ${nameController.text}");
              final res = await context
                  .read<NameModel>()
                  .addName(uid, nameController.text);
              nameController.clear();
              // print("res addName : $res");
            },
            icon: const Icon(Icons.add),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Voting Page"),
        actions: const [
          SignOut(),
        ],
      ),
      body: Column(
        children: [
          nameField(),
          Flexible(child: nameListView()),
        ],
      ),
    );
  }
}

class SignOut extends StatelessWidget {
  const SignOut({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    void onPressed() {
      context.read<AuthenticationService>().signOut();
      // print("Sign Out.");
    }

    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.logout),
    );
  }
}
