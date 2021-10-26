import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/usermodel.dart';

class ShowUserList extends StatelessWidget {
  const ShowUserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget showUserList() {
      return FutureBuilder(
          future: context.read<UserModel>().getUsers(),
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: context.read<UserModel>().userList.length,
                itemBuilder: (context, index) {
                  final data = context.read<UserModel>().userList;
                  return Text("${data[index].userModelInfo["uid"]}");
                });
          });
    }

    return showUserList();
  }
}
