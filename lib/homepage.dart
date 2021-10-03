import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // CollectionReference _dogs = FirebaseFirestore.instance.collection('dogs');

  Widget _body() {
    // return FutureBuilder(
    //   future: _dogs.doc('jiro').get(),
    //   builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       Map<String, dynamic> data =
    //           snapshot.data!.data() as Map<String, dynamic>;
    //       return Text("${data['name']}, ${data['votes']}");
    //     }
    //     return Text("other");
    //   },
    // );

    Stream<QuerySnapshot> _dogsStream =
        FirebaseFirestore.instance.collection('dogs').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _dogsStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("hasError!");
        }
        // if (!snapshot.hasData) return const LinearProgressIndicator();
        // return Container(child: Text(snapshot.data!.docs.map()));
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading..");
        }
        return _list(snapshot.data!.docs);
      },
    );
  }

  Widget _list(List<DocumentSnapshot> snapList) {
    // return ListView.separated(
    return ListView.builder(
      itemBuilder: (context, i) {
        return _listItem(snapList[i]);
      },
      // separatorBuilder: (context, i) {
      //   return const Divider();
      // },
      itemCount: snapList.length,
      padding: const EdgeInsets.all(18),
    );
  }

  Widget _listItem(DocumentSnapshot snap) {
    Map<String, dynamic> data = snap.data() as Map<String, dynamic>;

    void _addVote() {
      setState(() {
        // data["votes"] += 1;
        snap.reference.update({"votes": FieldValue.increment(1)});
      });
    }

    Widget _listTile() {
      return ListTile(
        title: Text(data["name"]),
        trailing: Text(data["votes"].toString()),
        // tileColor: Colors.cyan,
        onTap: _addVote,
      );
    }

    return Padding(
      // padding: const EdgeInsets.all(0),
      padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 18.0),
      // padding: const EdgeInsets.fromLTRB(60, 20, 50, 20),

      child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: _listTile()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voting App"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }
}
