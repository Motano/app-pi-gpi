import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
class Burbuja extends StatefulWidget {
  
  final String TextoEs;
  final String TextoMa;
  
  const Burbuja(this.TextoEs, this.TextoMa);
  
  @override
  _BurbujaState createState() => _BurbujaState();
}

class _BurbujaState extends State<Burbuja> {


  @override
  Widget build(BuildContext context) {
    return(
      Column(
        children: [
          Bubble(
            margin: BubbleEdges.only(top: 10),
            alignment: Alignment.topRight,
            nip: BubbleNip.rightTop,
            color: Color.fromRGBO(225, 255, 199, 1.0),
            child: Text(widget.TextoEs, textAlign: TextAlign.right, style: TextStyle(color: Colors.black)),
          ),
          Bubble(
            margin: BubbleEdges.only(top: 10),
            alignment: Alignment.topLeft,
            nip: BubbleNip.leftTop,
            child: Text(widget.TextoMa, style: TextStyle(color: Colors.black)),
          ),
        ],
      )
    );
  }
}
