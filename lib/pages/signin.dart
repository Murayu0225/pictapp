import 'package:flutter/material.dart';
import 'package:pictapp/pages/signup.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>{
  double? _deviceHeight, _deviceWidth;
  String _username = '';
  String _usernickname = '';
  String _password = '';
  String _repassword = '';
  bool isVisible = false;

  final _formKey = GlobalKey<FormState>();

  void toggleShowPassword () {
    setState(() {
      isVisible = !isVisible;
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
                  _alreadyHaveAccount(),
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
          'お帰りなさい！',
          style: TextStyle(
            fontSize: _deviceWidth! * 0.1,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'ログインしましょう',
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '必須項目です';
                } else if (value.length < 6) {
                  return '6文字以上です';
                } else if (value.length > 16) {
                  return '20文字以下です';
                } else if (value.contains(' ')) {
                  return 'スペースは使用できません';
                } else if (value.contains(RegExp(r'<>[-/:-[-`{-~]'))) {
                  return '記号は@と!のみ使用できます';
                } else if (!RegExp(r'^[A-Za-z0-9!@]*$').hasMatch(value)) {
                  return '英語・数字・!・@のみ使用できます';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(isVisible? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      toggleShowPassword();
                    },
                  ),
                  labelText: "パスワード"
              ),
              obscureText: !isVisible,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '必須項目です';
                } else if (value.length < 8) {
                  return 'パスワードは8文字以上です';
                } else if (value.length > 16) {
                  return 'パスワードは16文字以下です';
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
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
                backgroundColor: const Color(0xff09B58E),
                foregroundColor: Colors.white,
                elevation: 10,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('データ確認作業開始')),
                  );
                }
              },
              child: const Text('ログイン'),
            ),
          ]),
    );
  }
  Widget _alreadyHaveAccount () {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "アカウントをお持ちでない方は",
          style: TextStyle(color: Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) {
                  return const SignUpPage();
                },
              ),
            );
          },
          child: const Text(
            "新規登録",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
