# 概要

本アプリは、子供の名前候補を登録して、人気投票できるようにすることで、子供の名前の決定を支援するためのアプリです。

# 使用方法

子供の名前候補など、アプリで利用するデータの格納先として、Firebase を利用します。
そのため、事前に Firebase でプロジェクトを作成し、本アプリと連携する必要があります。

1. 下記ファイルを配置します。ただし、※1 は、xcode を開いてファイルを削除、追加しないと認識されません。Finder から配置しても認識されません。

   - ios/Runner/GoogleService-Info.plist ※1
   - android/app/google-services.json

2. Android Studio、Visual Studio Code で開き、ios, android のエミュレータを指定して、デバッグ実行します。

以上
