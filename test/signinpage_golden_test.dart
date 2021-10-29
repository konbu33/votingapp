import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:votingapp/signinpage.dart';

void main() {
  setUpAll(() async {
    void loadFontNotoSansJP() async {
      final fontFile = File('assets/fonts/NotoSansJP-Regular.otf');
      expect(fontFile.existsSync(), true);
      final fontData = await fontFile.readAsBytes();
      final fontLoader = FontLoader('NotoSansJP');
      fontLoader.addFont(Future.value(ByteData.view(fontData.buffer)));
      await fontLoader.load();
    }

    void loadFontNotoSerifJP() async {
      final fontFile = File('assets/fonts/NotoSerifJP-Regular.otf');
      expect(fontFile.existsSync(), true);
      final fontData = await fontFile.readAsBytes();
      final fontLoader = FontLoader('NotoSerifJP');
      fontLoader.addFont(Future.value(ByteData.view(fontData.buffer)));
      await fontLoader.load();
    }

    await loadAppFonts();
    loadFontNotoSansJP();
    loadFontNotoSerifJP();
  });

  testGoldens("表示文字テスト", (tester) async {
    // Size size = Size(414, 896);
    Device iphone11 = Device(name: "iphone11", size: Device.iphone11.size);

    await tester.pumpWidgetBuilder(const MaterialApp(home: SignInPage()),
        surfaceSize: iphone11.size);
    expect(find.text('ログイン'), findsNWidgets(2));
    expect(find.text('新規登録'), findsNWidgets(1));
    expect(find.text('メールアドレス'), findsNWidgets(1));
    expect(find.text('パスワード'), findsNWidgets(1));
    await screenMatchesGolden(tester, 'signInPage');
  });
}
