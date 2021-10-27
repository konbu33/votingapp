import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../model/namemodel.dart';
import 'package:provider/provider.dart';

class NameField extends StatelessWidget {
  const NameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget nameField() {
      return Container(
        height: MediaQuery.of(context).size.height * 0.08,
        child: TextFormField(
          controller: context.read<NameModel>().newNameController,
          style: const TextStyle(color: Colors.white, fontSize: 18),
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
    }

    return nameField();
  }
}
