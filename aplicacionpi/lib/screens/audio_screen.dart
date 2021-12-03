import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:aplicacionpi/models/messages.dart';
import 'package:aplicacionpi/functions/functions.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({Key? key}) : super(key: key);
  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final SpeechToText _speech = SpeechToText();
  bool _speechEnabled = false;
  String _text = '';
  String traducir = "";
  List<Message> _mensajes = [
    Message(
        "Presione el microfono para iniciar el reconocimiento de voz", false),
  ];

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
    setState(() {});
  }

  void _stopListening() async {
    await _speech.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _text = result.recognizedWords;
    });
  }

  _buildMessage(Message message, bool isMe) {
    return Container(
      margin: isMe
          ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
          : EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80.0),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      decoration: BoxDecoration(
          color: isMe ? Theme.of(context).accentColor : Color(0xFFFFEFEE),
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                )
              : BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                )),
      child: Text(
        message.body,
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('¿Qué desea traducir?'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    )),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.only(top: 15.0, bottom: 10),
                    itemCount: _mensajes.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Message message = _mensajes[index];
                      bool isMe = message.isMe;
                      return _buildMessage(message, isMe);
                    },
                  ),
                ),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                    )),
                padding: EdgeInsets.only(bottom: 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _speechEnabled ? '$_text' : 'Speech no está disponible',
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      iconSize: 25.0,
                      color: Theme.of(context).primaryColor,
                      onPressed: () async {
                        traducir = _text;
                        String translate = await postRequest(traducir);
                        List<String> traducido = translate.split(":");
                        traducido[1] = traducido[1]
                            .replaceAll("}", "")
                            .replaceAll('"', "");
                        String traducidox = traducido[1][0].toUpperCase() +
                            traducido[1].substring(1);
                        setState(() {
                          _mensajes.insert(0, Message(traducir, true));
                          _mensajes.insert(0, Message(traducidox, false));
                          _text = "";
                        });
                      },
                    )
                  ],
                )),
            Container(
              padding: EdgeInsets.only(bottom: 130),
              color: Colors.black12,
            ),
          ],
        ),
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
