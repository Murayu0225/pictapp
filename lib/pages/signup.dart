import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pictapp/pages/signin.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});


  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>{
  double? _deviceHeight, _deviceWidth;
  String _username = '';
  String _usernickname = '';
  String _password = '';
  String _repassword = '';
  bool isVisible1 = false;
  bool isVisible2 = false;
  bool buttonDisable = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();

  void toggleShowPassword1 () {
    setState(() {
      isVisible1 = !isVisible1;
    });
  }

  void toggleShowPassword2 () {
    setState(() {
      isVisible2 = !isVisible2;
    });
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _title(),
                _signupForm(),
                _otherInfo(),
              ],
            ),
          ),
        ),
      )
    );
  }
  Widget _title() {
    return Column(
      children: [
        Text(
          'ようこそ！',
          style: TextStyle(
            fontSize: _deviceWidth! * 0.1,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'アカウントを作成しましょう',
          style: TextStyle(
            fontSize: _deviceWidth! * 0.05,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
  Widget _signupForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'ユーザー名',
            ),
            controller: usernameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '必須項目です';
              }  else if (value.endsWith("already-exists123")) {
                return 'このユーザー名は既に使われています';
              } else if (value.length < 6) {
                return '6文字以上で入力してください';
              } else if (value.length > 16) {
                return '20文字以下で入力してください';
              } else if (value.contains(' ')) {
                return 'スペースは使用できません';
              } else if (value.contains(RegExp(r'<>[-/:-[-`{-~]'))) {
                return '記号は@と!のみ使用できます';
              } else if (!RegExp(r'^[A-Za-z0-9!@]*$').hasMatch(value)) {
                return '英語・数字・!・@のみ使用できます';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _username = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(isVisible1? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    toggleShowPassword1();
                  },
                ),
                labelText: "パスワード"
            ),
            obscureText: !isVisible1,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '必須項目です';
              } else if (value.length < 8) {
                return 'パスワードは8文字以上で入力してください';
              } else if (value.length > 16) {
                return 'パスワードは16文字以下で入力してください';
              } else if (value != _repassword) {
                return 'パスワードが一致しません';
              } else if (value.contains(' ')) {
                return 'スペースは使用できません';
              } else if (!RegExp(r'^[A-Za-z0-9!@]*$').hasMatch(value)) {
                return '英語・数字・!・@のみ使用できます';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _password = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(isVisible2? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    toggleShowPassword2();
                  },
                ),
                labelText: "パスワード（確認）"
            ),
            obscureText: !isVisible2,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '必須項目です';
              } else if (value != _password) {
                return 'パスワードが一致しません';
              } else if (value.length < 8) {
                return 'パスワードは8文字以上で入力してください';
              } else if (value.length > 16) {
                return 'パスワードは16文字以下で入力してください';
              } else if (value.contains(' ')) {
                return 'スペースは使用できません';
              } else if (!RegExp(r'^[A-Za-z0-9!@]*$').hasMatch(value)) {
                return '英語・数字・!・@のみ使用できます';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _repassword = value;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'ニックネーム',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '必須項目です';
              } else if (value.length > 16) {
                return 'ニックネームは16文字以下で入力してください';
              } else if (value.length < 2) {
                return 'ニックネームは2文字以上で入力してください';
              } else if (value.contains(' ')) {
                return 'スペースは使用できません';
              } else if (!RegExp(r'^[A-Za-z0-9!@]|[\u3040-\u309F]|\u3000|[\u30A1-\u30FC]|[\u4E00-\u9FFF]*$').hasMatch(value)) {
                return '日本語・英語・数字・!・@のみ使用できます';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _usernickname = value;
              });
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: const Color(0xff007CB5),
              foregroundColor: Colors.white,
              elevation: 10,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: buttonDisable? null : () async {
              setState(() {
                buttonDisable = true;
              });
              if (_formKey.currentState!.validate()) {
                  await Future.delayed(const Duration(seconds: 1), () {
                  final url = Uri.parse('http://localhost:5000/signup');
                  final url2 = Uri.parse('http://localhost:5000/signup/auth');
                  Map<String, String> headers = {'content-type': 'application/json', 'charset': 'utf-8'};
                  http.post(url, headers: headers, body: json.encode({
                    'u': _username,
                    'n': _usernickname,
                  })).then((response) {
                    if (response.statusCode == 200) {
                      if (jsonDecode(response.body)['status'] == 200){
                        final salt = jsonDecode(response.body)['salt'] as String;
                        final hash = sha256.convert(utf8.encode(_password + salt)).toString();
                        http.post(url2, headers: headers, body: json.encode({
                          'u': _username,
                          'p': hash,
                        })).then((response2) {
                          if (response2.statusCode == 200) {
                            if (jsonDecode(response2.body)['status'] == 200){

                              String userNickname = jsonDecode(response2.body)['nickname'] as String;
                              Navigator.pushNamed(context, 'home', arguments: userNickname);

                            } else {
                              setState(() {
                                buttonDisable = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('新規登録失敗。開発者まで問い合わせください。(su010)')),
                              );
                            }
                          } else {
                            setState(() {
                              buttonDisable = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('新規登録失敗。開発者まで問い合わせください。(su020)')),
                            );
                          }
                        });
                      } else if (jsonDecode(response.body)['status'] == 409){
                        setState(() {
                          buttonDisable = false;
                        });
                        var realUserName = usernameController.text;
                        usernameController.text = '${usernameController.text}already-exists123';
                        _formKey.currentState?.validate();
                        usernameController.text = realUserName;
                      } else {
                        setState(() {
                          buttonDisable = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('新規登録失敗。開発者まで問い合わせください。(su030)')),
                        );
                      }
                    } else {
                      setState(() {
                        buttonDisable = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('新規登録失敗。ネットワークに接続されていません。(su040)')),
                      );
                    }
                  });
                });

              } else {
                setState(() {
                  buttonDisable = false;
                });
              }
            },
            child: const Text('新規登録'),
          ),
      ]),
    );
  }
  Widget _otherInfo () {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "アカウントをお持ちの方は",
          style: TextStyle(color: Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) {
                  return const SignInPage();
                },
              ),
            );
          },
          child: const Text(
            "ログイン",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
