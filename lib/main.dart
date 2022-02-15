import 'package:flutter/material.dart';
import 'pages/login_in.dart';


void main() async{
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '四级单词记忆利器',
      theme: new ThemeData(
        primaryIconTheme: const IconThemeData(color: Colors.white),
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.cyan[300],
      ),
      debugShowCheckedModeBanner: false,
      home: LogininPage(),
    );
  }
}
