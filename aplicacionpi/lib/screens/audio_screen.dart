import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:bubble/bubble.dart';

import 'burbuja.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({Key? key}) : super(key: key);
  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final SpeechToText _speech = SpeechToText();
  bool _speechEnabled = false;
  String _text = '';
  List<List<String>> burbujas = [];

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speech.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speech.listen(onResult: _onSpeechResult);
    setState(() {
    });
  }

  void _stopListening() async {
    await _speech.stop();
    if(_text != ""){
      setState(() {
        //aca deberiamos llamar la api antes de crear la burbuja
        burbujas.add(
          [_text, '...'],
        );
        _text = "";
      });
    } else {
      // si no hay texto igual hay que refrescar la app
      setState(() {
        //_text = "";
      });
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _text = result.recognizedWords;
    });
    _stopListening(); // si quito esta linea se bugea en mala XD
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('¿Qué desea traducir?'),
      ),
      body: Center(
        child: ListView(
          children: <Widget> [
            for (var i in burbujas)
              Burbuja(i[0], i[1])
            ,
            if (_speech.isListening)
              Bubble(
                margin: BubbleEdges.only(top: 10),
                alignment: Alignment.topRight,
                nip: BubbleNip.rightTop,
                color: Color.fromRGBO(225, 255, 199, 1.0),
                child: Text(_text, textAlign: TextAlign.right, style: TextStyle(color: Colors.black)),
              ),
          ],
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _speechEnabled,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _speech.isNotListening ? _startListening : _stopListening,
          tooltip: 'Listen',
          child: Icon(_speech.isNotListening ? Icons.mic_off : Icons.mic),
        ),
      ),
    );
  }
}
