import 'package:flutter/material.dart';

class ChangePlan extends StatefulWidget {
  final prefs;
  ChangePlan({Key key,this.prefs}) : super(key:key);

  @override
  ChangePlanState createState() =>  ChangePlanState();
}

class ChangePlanState extends State<ChangePlan> {
  int count;
  @override
  void initState() {
    super.initState();
    setState((){
      count = widget.prefs.getInt('count');
    });
  }

  @override
  Widget build(BuildContext context){
    return  Scaffold(
        appBar:  AppBar(
          elevation: 0.0,
          title:  Text('复习计划'),
        ),
        body:  Container(
          padding: const EdgeInsets.all(16.0),
          child:  CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: <Widget>[
               SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context,int){
                      return  Column(
                      children: <Widget>[
                         RadioListTile(
                          activeColor: Colors.blueGrey,
                          key:  Key('10'),
                          title: const Text('每天学习10个单词'),
                          value: 10,
                          groupValue: count,
                          onChanged: (value) { setState(() {
                            count = value;
                            widget.prefs.setInt('count', value);
                          }); },
                        ),
                         RadioListTile(
                          activeColor: Colors.blueGrey,
                          key: Key('15'),
                          title: const Text('每天学习15个单词'),
                          value: 15,
                          groupValue: count,
                          onChanged: (value) { setState(() {
                            count = value;
                            widget.prefs.setInt('count', value);
                          }); },
                        ),
                         RadioListTile(
                          activeColor: Colors.blueGrey,
                          key: Key('20'),
                          title: const Text('每天学习20个单词'),
                          value: 20,
                          groupValue: count,
                          onChanged: (value) { setState(() {
                            count = value;
                            widget.prefs.setInt('count', value);
                          }); },
                        ),
                         RadioListTile(
                          activeColor: Colors.blueGrey,
                          key: Key('25'),
                          title: const Text('每天学习25个单词'),
                          value: 25,
                          groupValue: count,
                          onChanged: (value) { setState(() {
                            count = value;
                            widget.prefs.setInt('count', value);
                          }); },
                        ),
                         RadioListTile(
                          activeColor: Colors.blueGrey,
                          key: Key('30'),
                          title: const Text('每天学习30个单词'),
                          value: 30,
                          groupValue: count,
                          onChanged: (value) { setState(() {
                            count = value;
                            widget.prefs.setInt('count', value);
                          }); },
                        ),
                         RadioListTile(
                          activeColor: Colors.blueGrey,
                          key: Key('50'),
                          title: const Text('每天学习50个单词'),
                          value: 50,
                          groupValue: count,
                          onChanged: (value) { setState(() {
                            count = value;
                            widget.prefs.setInt('count', value);
                          }); },
                        ),
                      ],
                    );
                    },
                    childCount: 1
                  )
              ),
            ],
          ),
        )
    );
  }
}