import 'package:flutter/material.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  double? _deviceHeight, _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    final Object? userNickName = ModalRoute.of(context)?.settings.arguments;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                  _title(
                    userNickName: userNickName,
                  ),
                  _button(),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
  Widget _title({Object? userNickName}) {
    return Column(
      children: [
        Text(
          '$userNickNameさん、\n本アプリは以上になります',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: _deviceHeight ! * 0.02,
          ),
        )
      ],
    );
  }
  Widget _button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _homePageButton(),
        _licensePageButton(),
      ],
    );
  }
  Widget _homePageButton() {
    return Column(

      children: [
        Text(
          '最初の画面に',
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
            '　戻る　',
            style: TextStyle(
              fontSize: _deviceHeight! * 0.025,
            ),
          ),
          onPressed: () => Navigator.pushNamed(context, 'welcome'),
        ),
      ],
    );
  }
  Widget _licensePageButton() {
    return Column(

      children: [
        Text(
          'ライセンスを',
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
            '閲覧する',
            style: TextStyle(
              fontSize: _deviceHeight! * 0.025,
            ),
          ),
          onPressed: () => Navigator.pushNamed(context, 'license'),
        ),
      ],
    );
  }
}
