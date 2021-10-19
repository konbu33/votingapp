import 'package:flutter/material.dart';
import 'namemodel.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditPage extends StatelessWidget {
  const EditPage({Key? key, required this.docId}) : super(key: key);

  final String docId;
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    Widget nameField(String docId) {
      void getName() async {
        nameController.text = await context.read<NameModel>().getName(docId);
      }

      getName();

      print("EditPage docId : $docId");
      return TextFormField(
        controller: nameController,
        decoration: InputDecoration(labelText: "名前"),
      );
    }

    Widget submitButton() {
      void onPressed() async {
        String name = nameController.text;
        String uid = await context.read<User?>()!.uid;
        print(
            "submit on.: ${nameController.text}, uid : ${uid}, docId : ${docId}");
        final res = context.read<NameModel>().updateName(docId, name, uid);
        print("res updateName : ${res}");
        Navigator.of(context).pop();
      }

      return ElevatedButton(onPressed: onPressed, child: Text("Submit"));
    }

    Widget returnButton() {
      void onPressed() {
        Navigator.of(context).pop();
      }

      return ElevatedButton(onPressed: onPressed, child: Text("戻る"));
    }

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Edit Page"),
          Flexible(child: nameField(docId)),
          submitButton(),
          returnButton(),
        ],
      ),
    );
  }
}
