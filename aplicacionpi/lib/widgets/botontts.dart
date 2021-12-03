import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class BotonTTS extends StatefulWidget {
  final String texto;
  final bool autoplay;

  const BotonTTS({Key? key, required this.texto, required this.autoplay}) : super(key: key);

  @override
  _BotonTTSState createState() => _BotonTTSState();
}

class _BotonTTSState extends State<BotonTTS> {

  FlutterTts flutterTts = FlutterTts();
  
  Future _configs() async {
    await flutterTts.setLanguage("es-CL");
  }


  Future _speak(texto) async{
    await flutterTts.speak(texto);
  }

  @override
  void initState() {
    super.initState();
    _configs();
    if(widget.autoplay) {
      _speak(widget.texto);
    }
  }


  @override
  Widget build(BuildContext context) {
    return (
      IconButton(
        icon: const Icon(Icons.play_circle_outline),
        tooltip: 'Escuchar',
        color: Colors.black,
        onPressed: () {
            _speak(widget.texto);
        },
      )
    );
  }
}