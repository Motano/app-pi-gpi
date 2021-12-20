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

  bool _autoplayDone = false;

  FlutterTts flutterTts = FlutterTts();
  
  Future _configs() async {
    await flutterTts.setLanguage("es-CL");
  }


  Future _speak(texto) async{
    await flutterTts.speak(texto);
  }

  Future<void> _init() async {
    await _configs();
    if(widget.autoplay && !(_autoplayDone)) {
      _speak(widget.texto);
      _autoplayDone = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(BotonTTS oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.autoplay && (widget.texto != oldWidget.texto)) {
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