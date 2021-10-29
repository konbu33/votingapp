import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:votingapp/signinpage.dart';

void main() {
  testWidgets("表示文字テスト", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignInPage()));
    await tester.pump();

    expect(find.text('ログイン'), findsNWidgets(2));
    expect(find.text('新規登録'), findsOneWidget);
    expect(find.text('メールアドレス'), findsOneWidget);
    expect(find.text('パスワード'), findsOneWidget);
  });
}
