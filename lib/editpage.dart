import 'package:flutter/material.dart';
import 'model/namemodel.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditPage extends StatelessWidget {
  const EditPage({Key? key, required this.docId}) : super(key: key);

  final String docId;
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController nameYomiController = TextEditingController();

    Widget nameField(String docId) {
      void getName() async {
        final res = await context.read<NameModel>().getName(docId);
        nameController.text = res["data"]["name"];
      }

      getName();

      print("EditPage docId : $docId");
      return TextFormField(
        controller: nameController,
        decoration: InputDecoration(labelText: "名前"),
      );
    }

    Widget nameYomiField(String docId) {
      void getNameYomi() async {
        final res = await context.read<NameModel>().getName(docId);
        nameYomiController.text = res["data"]["nameYomi"];
      }

      getNameYomi();

      print("EditPage docId : $docId");
      return TextFormField(
        controller: nameYomiController,
        decoration: InputDecoration(labelText: "読み方"),
      );
    }

    Widget submitButton() {
      void onPressed() async {
        String name = nameController.text;
        String nameYomi = nameYomiController.text;
        String uid = await context.read<User?>()!.uid;
        print(
            "submit on.: ${nameController.text}, uid : ${uid}, docId : ${docId}");
        final res =
            context.read<NameModel>().updateName(docId, name, nameYomi, uid);
        print("res updateName : ${res}");
        Navigator.of(context).pop();
      }

      return Container(
        constraints: BoxConstraints(minWidth: double.infinity),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text("保存"),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      );
    }

    Widget returnButton() {
      void onPressed() {
        Navigator.of(context).pop();
      }

      return Container(
        constraints: BoxConstraints(minWidth: double.infinity),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text("戻る"),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      );
    }

    return Center(
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 70),
            Text(
              "名前を編集",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 130),
            Flexible(child: nameField(docId)),
            Flexible(child: nameYomiField(docId)),
            SizedBox(height: 30),
            submitButton(),
            SizedBox(height: 200),
            returnButton(),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
