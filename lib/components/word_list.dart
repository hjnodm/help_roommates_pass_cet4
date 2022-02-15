import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:helproommatespasscet4/components/word_detail.dart';
import 'package:helproommatespasscet4/model/word.dart';
import 'package:helproommatespasscet4/model/db.dart';
import 'package:helproommatespasscet4/model/constant.dart';
import 'dart:async';

class VocabularyList extends StatefulWidget {
  final SharedPreferences prefs;

  final String title;
  final String label;

  VocabularyList({Key key, this.prefs, this.title, this.label})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return VocabularyListState();
  }
}

class VocabularyListState extends State<VocabularyList> {
  List list;
  DBClient client;
  int num;

  @override
  initState() {
    super.initState();
    client = DBClient();
  }

  setLearnednum() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final prefss = await _prefs;
    prefss.setInt(Constant.L_num.toString(), num);
  }

  @override
  dispose() {
    super.dispose();
  }

  Widget buildItem(BuildContext context, int index) {
    Word item = Word().getDetail(list[index]);
    return Card(
      elevation: 0.5,
      key: Key(index.toString()),
      color: Colors.white70,
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Text(
            item.text,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  WordDetail(item: item, prefs: widget.prefs)));
        },
      ),
    );
  }

  Future<List> getList() async {
    List wholeList = await Word().getList(widget.prefs.getInt('level'));
    print('NCAA');
    if (widget.label == 'all') {
      return wholeList;
    }
    List studiedList = await client.queryAll();
    if (widget.label == 'studied') {
      List studied = wholeList.where((item) {
//        print(studiedList.contains(item['word']));
        return studiedList.contains(item['word']);
      }).toList();
      this.num = studied.length;
      setLearnednum();
      return studied;
    }
    if (widget.label == 'unstudy') {
      List unstudy = wholeList.where((item) {
        return !studiedList.contains(item['word']);
      }).toList();
      return unstudy;
    } else {
      List lastWords = wholeList.where((item) {
        return !studiedList.contains(item['word']);
      }).toList();
      int count = widget.prefs.getInt('count');
      int len = count > lastWords.length ? lastWords.length : count;
      return lastWords.sublist(0, len);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: getList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              list = snapshot.data;
              return ListView.builder(
                itemBuilder: buildItem,
                itemCount: list.length,
              );
            }
            return Container(
              child: null,
            );
          }),
    );
  }
}
