import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../model/utils.dart';
import 'package:helproommatespasscet4/model/word.dart';

class Dictionary extends StatefulWidget {
  Dictionary({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return  DictionaryState();
  }
}

class DictionaryState extends State<Dictionary> {
  Word curWord;
  String word;
  String meaning;
  final TextEditingController controller =  TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      curWord = null;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _onChanged(e) {
    if (controller.text == '') {
      setState(() {
        curWord = null;
      });
    }
  }

  _onSubmit(e) async {
    final String val = controller.text;
    String temp = '百度翻译api密钥$val' + '百度翻译api密钥';
//    print(temp);
    String md5 = Md5Util.generateMd5(temp);
    final response = await get(
        'https://api.fanyi.baidu.com/api/trans/vip/translate?q=$val' +
            '&from=en&to=zh&appid=ncaa&salt=1435660288&sign=$md5');
    setState(() {
      if (val.isEmpty) {
        curWord = null;
      } else {
        curWord = _translateResponse(response);
      }
    });
  }

  _translateResponse(response) {
    try {
      var json = jsonDecode(response.body);
      print(json);
      print(json['trans_result']);
      word = json['trans_result'][0]['src'];
      meaning = json['trans_result'][0]['dst'];
    } catch (e) {
      return null;
    }
  }

  _getResult() {
    if (word == null) {
      return  Expanded(
          child:  Container(
        child:  Center(
          child:  Text(''),
        ),
      ));
    }
    else if (meaning == word) {
      return Container(
          margin: EdgeInsets.only(top: 20),
          child: Container(
            child: Center(
              child: Text(
                'Sorry, I can\'t help you.（＞人＜）',
                style: TextStyle(
                  color: Colors.black, //设置字体颜色
                  fontSize: 20, //设置字体大小
                ),
              ),
            ),
          ));
    }
    else {
      return Container(
          margin: EdgeInsets.only(top: 20),
          child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '查询单词：$word',
                    style: TextStyle(
                      color: Colors.black, //设置字体颜色
                      fontSize: 20, //设置字体大小
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(top: 15)),
                  Text(
                    '查询释意：$meaning',
                    style: TextStyle(
                      color: Colors.black, //设置字体颜色
                      fontSize: 20, //设置字体大小
                    ),
                  ),
                ]),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        resizeToAvoidBottomInset: false,
        appBar:  AppBar(
          elevation: 0.0,
          centerTitle: true,
          title:  Text('百度翻译快查词典'),
        ),
        body:  Container(
            child:  GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child:  Column(
            children: <Widget>[
               Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child:  TextField(
                  style:  TextStyle(fontSize: 22.0, color: Colors.black87),
                  decoration:  InputDecoration(
                      hintText: 'Input the word here...',
                      hintStyle: const TextStyle(fontSize: 16.0),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          _onSubmit(null);
                        },
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 8.0)),
                  controller: controller,
                  onChanged: _onChanged,
                  onSubmitted: _onSubmit,
                ),
              ),
              _getResult()
            ],
          ),
        )));
  }
}
