import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/word_list.dart';

class WordList extends StatefulWidget {
  final SharedPreferences prefs;

  WordList({Key key, this.prefs}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WordListState();
  }
}

class WordListState extends State<WordList> {
  final style =
      TextStyle(fontSize: 24.0, height: 1.5, color: Colors.blueAccent);
  final decoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8.0),
    boxShadow: [
      BoxShadow(
          color: Colors.black45,
          offset: Offset.zero,
          blurRadius: 5.0,
          spreadRadius: 0.1)
    ],
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('单词列表'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        decoration: decoration,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => VocabularyList(
                                  prefs: widget.prefs,
                                  title: '所有单词',
                                  label: 'all'),
                            ));
                            super.dispose();
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(top: 120)),
                              Center(
                                child: Icon(Icons.cast_for_education,
                                    size: 50.0, color: Colors.lightBlueAccent),
                              ),
                              Center(
                                child: Text(
                                  '所有单词',
                                  textAlign: TextAlign.left,
                                  style: style,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 20.0, right: 10.0),
                        decoration: decoration,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VocabularyList(
                                        prefs: widget.prefs,
                                        title: '未学单词',
                                        label: 'unstudy')));
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(top: 120)),
                              Center(
                                child: Icon(Icons.local_library,
                                    size: 50.0, color: Colors.lightBlueAccent),
                              ),
                              Center(
                                child: Text(
                                  '未学单词',
                                  textAlign: TextAlign.left,
                                  style: style,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        decoration: decoration,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VocabularyList(
                                        prefs: widget.prefs,
                                        title: '正在学习',
                                        label: 'studying')));
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(top: 120)),
                              Center(
                                child: Icon(Icons.lightbulb,
                                    size: 50.0, color: Colors.lightBlueAccent),
                              ),
                              Center(
                                child: Text(
                                  '正在学习',
                                  textAlign: TextAlign.left,
                                  style: style,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.only(top: 20.0, left: 10.0),
                          decoration: decoration,
                          child: InkWell(
                            child: Column(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.only(top: 120)),
                                Center(
                                  child: Icon(Icons.school,
                                      size: 50.0,
                                      color: Colors.lightBlueAccent),
                                ),
                                Center(
                                  child: Text(
                                    '已学单词',
                                    textAlign: TextAlign.left,
                                    style: style,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VocabularyList(
                                          prefs: widget.prefs,
                                          title: '已学单词',
                                          label: 'studied')));
                            },
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
