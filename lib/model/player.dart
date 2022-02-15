import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class Player extends StatefulWidget {
  final src;
  final text;
  final color;
  final autoplay;
  Player({this.src,this.text,this.color,this.autoplay});
  @override
  PlayerState createState() =>  PlayerState();
}

class PlayerState extends State<Player>{
  bool playing = false;
  String lastSrc = '';
  var color;
  AudioPlayer audioPlayer;
  StreamSubscription _audioPlayerStateSubscription;

  @override
  void initState() {
    super.initState();
    initAudio();
  }

  @override
  void dispose(){
    stop();
    super.dispose();
  }
  
  @override
  didUpdateWidget(oldWidget){
    if(lastSrc != widget.src && widget.autoplay){
      initAudio();
    }
  }

  Future play(url) async {
    try{
      String ans = url.replaceAll('http', 'https');
      int result = await audioPlayer.play(ans);
      if (result == 1) {
        // success
        print(url);
        print('play success');
      } else {
        print('play failed');
      }
      if(mounted){
        setState((){
          lastSrc = ans;
          playing = true;
        });
      }
    }catch(e){
      print(e);
      stop();
    }
  }

  Future stop() async {
    try{
      int result = await audioPlayer.stop();
      if (result == 1) {
        // success
        print('pause success');
      } else {
        print('pause failed');
      }
      if(mounted){
        setState(() => playing = false);
      }
    }catch(e){
      if(mounted){
        setState(() => playing = false);
      }
    }
  }

  void audioController(url){
    if(playing){
      stop();
    }else{
      play(url);
    }
  }

  void initAudio(){
    audioPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           Icon(
            playing ? Icons.pause_circle_outline : Icons.play_circle_outline,
            color: widget.color,
            size: 19.0,
          ),
           Text(' /'+widget.text+'/',style:  TextStyle(fontSize: 18.0,color: widget.color),),
        ],
      ),
      onTap: (){
        audioPlayer =  AudioPlayer();
        _audioPlayerStateSubscription = audioPlayer.onPlayerStateChanged.listen((s){
          if(s == AudioPlayerState.COMPLETED){
            stop();
          }
        }, onError: (msg){
          stop();
        });
        if(widget.src.isNotEmpty){
          audioController(widget.src);
        }
      },
    );
  }
}