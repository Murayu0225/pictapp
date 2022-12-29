import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PICT Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyAuthPage(),
    );
  }
}

class MyAuthPage extends StatefulWidget {
  @override
  _MyAuthPageState createState() => _MyAuthPageState();
}

class _MyAuthPageState extends State<MyAuthPage> {
  // 入力されたメールアドレス
  String newUserName = "";
  // 入力されたパスワード
  String newUserPassword = "";
  // 入力されたニックネーム
  String newNickName = "";
  // 入力されたメールアドレス（ログイン）
  String loginUserName = "";
  // 入力されたパスワード（ログイン）
  String loginUserPassword = "";
  // 登録・ログインに関する情報を表示
  String infoText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 30),
              TextFormField(
                // テキスト入力のラベルを設定
                decoration: InputDecoration(labelText: "ユーザー名（英数字のみ）"),
                onChanged: (String value) {
                  setState(() {
                    newUserName = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                // テキスト入力のラベルを設定
                decoration: InputDecoration(labelText: "ニックネーム（英数字のみ）"),
                onChanged: (String value) {
                  setState(() {
                    newNickName = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: "パスワード（英数字のみ）"),
                // パスワードが見えないようにする
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    newUserPassword = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  final res = await http.get(Uri.parse('http://127.0.0.1:5000/signup?u=$newUserName'));

                  if(res.statusCode == 200) {
                    var jsonData = jsonDecode(res.body);
                    if(jsonData['status'] == 200) {
                      var salt = jsonData['salt'];
                      var saltedPassword = salt + newUserPassword;
                      var hashedPassword = sha256.convert(utf8.encode(saltedPassword)).toString();
                      final res2 = await http.get(Uri.parse('http://127.0.0.1:5000/signup/auth?u=$newUserName&p=$hashedPassword&n=$newNickName'));
                      if (res2.statusCode == 200) {
                        var jsonData2 = jsonDecode(res2.body);
                        if(jsonData2['status'] == 200) {
                          setState(() {
                            infoText = "登録に成功しました";
                          });
                        } else {
                          setState(() {
                            infoText = "登録に失敗しました";
                          });
                        }
                      } else {
                        setState(() {
                          infoText = "登録に失敗しました";
                        });
                      }
                    }
                  } else {
                    setState(() {
                      infoText = "登録に失敗しました";
                    });
                  }
                },
                child: Text("ユーザー登録"),
              ),
              const SizedBox(height: 32),
              TextFormField(
                decoration: InputDecoration(labelText: "ユーザー名"),
                onChanged: (String value) {
                  setState(() {
                    loginUserName = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "パスワード"),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    loginUserPassword = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {},
                child: Text("ログイン"),
              ),
              const SizedBox(height: 8),
              Text(infoText),
            ],
          ),
        ),
      ),
    );
  }
}
