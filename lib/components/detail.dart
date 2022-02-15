import 'package:flutter/material.dart';
import 'package:helproommatespasscet4/model/word.dart';
import 'detail_means.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Means extends StatefulWidget {
  final Word currentItem;
  final SharedPreferences prefs;

  Means({Key key, this.currentItem, this.prefs}) : super(key: key);

  @override
  MeansState createState() => MeansState();
}

class MeansState extends State<Means> {
  bool means;
  bool showCn;
  bool showCollins;
  bool showSentence;

  @override
  void initState() {
    super.initState();
    setState(() {
      means = false;
      showCn = widget.prefs.getBool('showCn');
      showCollins = widget.prefs.getBool('showcollins');
      showSentence = widget.prefs.getBool('sentence');
    });
  }

  @override
  void didUpdateWidget(Means oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (mounted) {
      setState(() {
        means = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _getMeans() {
    if (means) {
      return DetailMeans(
        word: widget.currentItem,
        showCn: showCn,
        showCollins: showCollins,
        showSentence: showSentence,
      );
    } else {
      return Expanded(child: Text(''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: <Widget>[
        _getMeans(),
        InkWell(
          onTap: () {
            setState(() {
              means = !means;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Text(
              means ? '点击隐藏释义' : '点击显示释义',
              style: TextStyle(color: Colors.blueGrey),
            ),
          ),
        )
      ],
    ));
  }
}
