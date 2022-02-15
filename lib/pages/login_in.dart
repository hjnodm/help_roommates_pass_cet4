import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:helproommatespasscet4/model/constant.dart';
import 'dart:async';
import 'home_page.dart';

class LogininPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LogininPage> {
  final accountEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  bool _isShowPwd = false;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _normalFont = const TextStyle(fontSize: 18);
  bool _isEnableLogin = false;

  @override
  void initState() {
    _prefs.then((prefs) {
      accountEditingController.text =
          prefs.getString(Constant.uesrName) ?? null;
      passwordEditingController.text =
          prefs.getString(Constant.passwordKey) ?? null;
      _checkUserInput();
    });
    super.initState();
  }

  Widget _buildTowidget() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset('assets/img/svg.png'),
        ],
      ),
    );
  }

  Widget _buildAccountEditTextField() {
    return TextFormField(
      controller: accountEditingController,
      onChanged: (text) {
        _checkUserInput();
      },
      decoration: InputDecoration(
        focusColor: Colors.lightGreen,
        labelText: "写下一些激励自己的话吧",
        labelStyle: TextStyle(color: Colors.blueAccent),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildPWEditTextField() {
    return TextFormField(
      controller: passwordEditingController,
      onChanged: (text) {
        _checkUserInput();
      },
      obscureText: !_isShowPwd,
      decoration: InputDecoration(
        labelText: "密码",
        labelStyle: TextStyle(color: Colors.blueAccent),
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.grey,
        ),
        // 是否显示密码
        suffixIcon: IconButton(
          icon: Icon((_isShowPwd) ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _isShowPwd = !_isShowPwd;
            });
          },
        ),
      ),
    );
  }

  _buildButton() {
    return ButtonStyle(
        textStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 18, color: Colors.white)),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.focused) &&
                !states.contains(MaterialState.pressed)) {
              //获取焦点时的颜色
              return Colors.blue;
            } else if (states.contains(MaterialState.pressed)) {
              //按下时的颜色
              return Colors.deepPurple;
            }
            //默认状态使用灰色
            return Colors.grey;
          },
        ),
        shape: MaterialStateProperty.all(StadiumBorder(
            side: BorderSide(
          //设置 界面效果
          style: BorderStyle.solid,
          color: Color(0xffC0C0C0),
        )))); //圆角弧度);
  }

  Widget _buildLoginButton() {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        child: Text('开启今日的学习', style: _normalFont),
        style: _buildButton(),
        onPressed: _getLoginButtonPressed(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          '四级必过利器',
          style: TextStyle(
            color: Colors.white, //设置字体颜色
            fontSize: 20, //设置字体大小
          ),
        ),
        centerTitle: true,
//          backgroundColor: Colors.blueAccent,//设置导航背景颜色
      ),
      backgroundColor: Colors.blueAccent,
      body: Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          child: Column(
            children: <Widget>[
              _buildTowidget(),
              Padding(padding: EdgeInsets.only(top: 10)),
              Center(
                  child: Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
//                      child: Form(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          width: 270,
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _buildAccountEditTextField(),
                              _buildPWEditTextField(),
                              Container(
                                height: 20,
                              ),
                              _buildLoginButton(),
                            ],
                          ),
                        ),
                      ))),
            ],
          )),
    );
  }

  _getLoginButtonPressed() {
    if (!_isEnableLogin) return null;
    return () async {
      Navigator.of(context).pop();
      Navigator.push(
          context, MaterialPageRoute(builder: (Context) => HomePage()));
    };
  }

  void _checkUserInput() {
    if (accountEditingController.text.isEmpty ||
        passwordEditingController.text.isEmpty) {
      _isEnableLogin = false;
    } else {
      _isEnableLogin = true;
    }
    setState(() {});
  }
}
