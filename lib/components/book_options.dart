import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectBook extends StatefulWidget {
  final SharedPreferences prefs;
  SelectBook({Key key,this.prefs}) : super(key:key);

  @override
  SelectBookState createState() =>  SelectBookState();
}

class SelectBookState extends State<SelectBook> {
  int level;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState((){
      level = widget.prefs.getInt('level');
    });
  }

  @override
  Widget build(BuildContext context){
    return  Scaffold(
      appBar:  AppBar(
        elevation: 0.0,
        title:  Text('选择单词书'),
      ),
      body:  Container(
        padding: const EdgeInsets.all(16.0),
        child:  Column(
          children: <Widget>[
             RadioListTile(
              activeColor: Colors.blueGrey,
              title: const Text('四级词汇(上)'),
              value: 1,
              groupValue: level,
              onChanged: (int value) { setState(() {
                level = value;
                widget.prefs.setInt('level', value);
              }); },
            ),
             RadioListTile(
              activeColor: Colors.blueGrey,
              title: const Text('四级词汇(下)'),
              value: 2,
              groupValue: level,
              onChanged: (int value) { setState(() {
                level = value;
                widget.prefs.setInt('level', value);
              }); },
            ),
          ],
        ),
      )
    );
  }
}