import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dummyData = [
    {"name": "Pochi", "votes": 0},
    {"name": "Taro", "votes": 0},
    {"name": "Jiro", "votes": 0},
    {"name": "Shiro", "votes": 0},
    {"name": "Hachi", "votes": 0},
  ];

  Widget _body() {
    return Container(
      // color: Colors.amber,
      child: _list(dummyData),
    );
  }

  Widget _list(List<Map<String, dynamic>> dataList) {
    // return ListView.separated(
    return ListView.builder(
      itemBuilder: (context, i) {
        return _listItem(dataList[i]);
      },
      // separatorBuilder: (context, i) {
      //   return const Divider();
      // },
      itemCount: dataList.length,
      padding: EdgeInsets.all(18),
    );
  }

  Widget _listItem(Map<String, dynamic> data) {
    void _addVote() {
      setState(() {
        data["votes"] += 1;
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
