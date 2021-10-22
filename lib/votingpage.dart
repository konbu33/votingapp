import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'namemodel.dart';
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
        bool isSelected = false;

        return Slidable(
          actionExtentRatio: 0.2,
          // actionPane: SlidableBehindActionPane(),
          // actionPane: SlidableDrawerActionPane(),
          // actionPane: SlidableStrechActionPane(),
          actionPane: const SlidableScrollActionPane(),
          actions: [
            IconSlideAction(
              caption: "編集",
              color: Colors.green,
              icon: Icons.edit,
              onTap: () {
                // print("edit onTap: ${snapshot.id}");
                showModalBottomSheet(
                  // barrierColor: Colors.white.withOpacity(0.9),
                  backgroundColor: Colors.white.withOpacity(0),
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.only(
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
                // print("delete onTap: ${snapshot.id}");
                final res =
                    await context.read<NameModel>().delName(snapshot.id);
                // print("res : ${res}");
              },
            ),
          ],
          child: ListTile(
            title: Text("${snapshot.get("name")}"),
            subtitle: Text("${snapshot.get("nameYomi")}"),
            selectedTileColor: Colors.grey,
            // selected: isSelected,
            // focusColor: Colors.grey,
            hoverColor: Colors.grey,

            // onTap: () {
            // isSelected = !isSelected;
            // },
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

    // return FutureBuilder(
    //     future: FirebaseFirestore.instance.collection('names').get(),
    //     builder:
    //         (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //       if (snapshot.hasData) {
    //         return _listViewBuilder(snapshot.data!.docs);
    //       } else {
    //         return Text("no data.");
    //       }
    //     });

    Widget nameField() {
      // TextEditingController nameController = TextEditingController();

      return Container(
        height: MediaQuery.of(context).size.height * 0.08,
        child: TextFormField(
          controller: context.read<NameModel>().newNameController,
          style: TextStyle(color: Colors.white, fontSize: 18),
          decoration: const InputDecoration(
            labelText: "名前候補を追加",
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
          ),
        ),
      );

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
    }

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
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: nameListView()),
              // SizedBox(height: 20),
              // nameField(),
              // SizedBox(height: 70),
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
        child: Icon(Icons.add),
        // backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 6.0,
        shape: AutomaticNotchedShape(
          RoundedRectangleBorder(),
          StadiumBorder(
            side: BorderSide(),
          ),
        ),
        color: Theme.of(context).primaryColor,
        child: Container(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
            // color: Colors.amber,
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.3),
            child: nameField()),
      ),
    );
  }
}

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onPressed() {
      context.read<AuthenticationService>().signOut();
      // print("Sign Out.");
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
