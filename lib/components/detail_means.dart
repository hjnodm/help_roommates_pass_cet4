import 'package:flutter/material.dart';
import 'package:helproommatespasscet4/model/word.dart';
import 'package:audioplayers/audioplayers.dart';

class DetailMeans extends StatefulWidget {
  final Word word;
  final bool showCn;
  final bool showCollins;
  final bool showSentence;
  DetailMeans({Key key,this.word,this.showCn,this.showCollins,this.showSentence}):super(key:key);
  @override
  DetailMeansState createState() =>  DetailMeansState();
}

class DetailMeansState extends State<DetailMeans> {

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  Widget buildExpalin(){
    return  Text(widget.word.explain);
  }

  Widget buildWithoutCollins(){
    return  Expanded(
        child:  Column(
          children: <Widget>[
            _buildCnTitle(),
            _buildCnContent()
          ],
        )
    );
  }

  Widget buildCollins(){
    return  Expanded(
        child:  ListView(
          primary: false,
          children: <Widget>[
            _buildCnTitle(),
            _buildCnContent(),
            _buildCollinsTitle(),
            _buildCollinsContent(),
          ],
        )
    );
  }

  Widget buildExample(BuildContext context,int index,int itemIndex){
    final example = widget.word.collins[itemIndex]['example'][index];
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
         GestureDetector(
          onTap:() {
             AudioPlayer().play(example['tts_mp3'].replaceAll('http', 'https'));
          },
          child:  Text(example['ex'],
            style:  TextStyle(color: Colors.blue,fontSize: 16.0),
          ),
        ),
         Padding(
          padding: const EdgeInsets.only(bottom: 8.0,top: 2.0),
          child:  Text(example['tran'],style:  TextStyle(color: Colors.blueGrey,fontSize: 16.0),),
        )
      ],
    );
  }

  Widget _buildCnTitle(){
    if(widget.showCn){
      return  Container(
        padding: const EdgeInsets.only(top:16.0,left: 16.0, bottom: 8.0),
        child:  Text('中文释义',
          style:  TextStyle(color: Colors.blueGrey,fontSize: 15.0,fontWeight: FontWeight.w900),
        ),
      );
    }else{
      return  Text('');
    }
  }

  Widget _buildCnContent(){
    if(widget.showCn){
      return  ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemBuilder: (BuildContext context, int index){
          final cn = widget.word.cn_mean[index];
          return  Padding(
            padding: const EdgeInsets.only(left: 16.0,right:16.0,top: 2.0,bottom: 14.0),
            child:  Text('${cn['part']} ${cn['means'].join('; ')}',
              style:  TextStyle(fontSize: 14.0),
            ),
          );
        },
        itemCount: widget.word.cn_mean.length,
      );
    }else{
      return  Text('');
    }
  }

  Widget _buildCollinsTitle(){
    if(widget.showCollins && widget.word.collins[0]['def'].toString().isNotEmpty){
      return  Container(
        padding: const EdgeInsets.only(bottom:4.0,left: 16.0),
        child:  Text('词典英文释义',
          style:  TextStyle(color: Colors.blueGrey,fontSize: 15.0,fontWeight: FontWeight.bold),
        ),
      );
    }else{
      return  Text('');
    }
  }

  Widget _buildCollinsContent(){
    if(widget.showCollins){
      return  ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemBuilder: (BuildContext context, int index){
          final en = widget.word.collins[index];
          return  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _getCollinsContent(en, index),
              )
          );
        },
        itemCount: widget.word.collins.length,
      );
    }else{
      return  Text('');
    }
  }

  List<Widget> _getCollinsContent(en, index){
    if(widget.word.collins[0]['def'].toString().isNotEmpty){
      return [
         Text('${en['def']}',style:  TextStyle(fontSize: 17.0,color: Colors.black87),),
         Container(
          padding: const EdgeInsets.only(top: 4.0,bottom: 8.0),
          child: Text('${en['tran']}',style:  TextStyle(fontSize: 17.0,color: Colors.black),),
        ),
        _buildCollinsExample(en,index),
      ];
    }else{
      return [
        _buildCollinsExample(en,index),
      ];
    }
  }

  Widget _buildCollinsExample(en,index){
    if(widget.showSentence){
      return  Container(
        color:  Color.fromRGBO(236, 236, 242, 1.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.only(top: 16.0,bottom:8.0,left: 16.0,right: 16.0),
        child:  ListView.builder(
          itemBuilder: (context,i){
            return buildExample(context,i,index);
          },
          shrinkWrap: true,
          primary: false,
          itemCount: en['example'].length,
        ),
      );
    }else{
      return  Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    if(widget.word.explain.toString().isEmpty){
      return buildExpalin();
    }
    if(widget.word.collins.toString().isEmpty){
      return buildWithoutCollins();
    }
    return buildCollins();
  }

}