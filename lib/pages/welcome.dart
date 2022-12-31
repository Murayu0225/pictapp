import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>{
  double? _deviceHeight, _deviceWidth;

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
                _welcomeImage(),
                _title(),
                _button(),
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _welcomeImage () {
    return Column(
      children: [
        Image(
          image: const AssetImage('assets/welcome.gif'),
          height: _deviceHeight! * 0.3,
        ),
      ],
    );
  }
  Widget _title() {
    return Column(
      children: [
        Text(
          'PICT APP',
          style: TextStyle(
            fontSize: _deviceHeight! * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'ようこそ！プラクティカルICTの\nクライアントアプリです',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: _deviceHeight! * 0.02,
          ),
        ),
      ],
    );
  }
  Widget _button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _loginButton(),
        _signupButton(),
      ],
    );
  }
  Widget _loginButton() {
    return Column(

      children: [
        Text(
          'アカウントを',
          style: TextStyle(
            fontSize: _deviceHeight! * 0.015,
            fontWeight: FontWeight.w600,
          ),
        ),
        ElevatedButton(
        // width: _deviceWidth! * 0.8,
        // height: _deviceHeight! * 0.07,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff007CB5),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.06, vertical: _deviceHeight! * 0.008),
        ),
        child: Text(
          '新規登録',
          style: TextStyle(
            fontSize: _deviceHeight! * 0.025,
          ),
        ),
        onPressed: () => Navigator.pushNamed(context, 'signup'),
      ),
      ],
    );
  }
  Widget _signupButton() {
    return Column(

      children: [
        Text(
          '既存のアカウントで',
          style: TextStyle(
            fontSize: _deviceHeight! * 0.015,
            fontWeight: FontWeight.w600,
          ),
        ),
        ElevatedButton(
          // width: _deviceWidth! * 0.8,
          // height: _deviceHeight! * 0.07,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff09B58E),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.06, vertical: _deviceHeight! * 0.008),
          ),
          child: Text(
            'ログイン',
            style: TextStyle(
              fontSize: _deviceHeight! * 0.025,
            ),
          ),
          onPressed: () => Navigator.pushNamed(context, 'signin'),
        ),
      ],
    );
  }
}
