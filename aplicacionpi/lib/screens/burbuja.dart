import 'package:flutter/material.dart';
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
          Text(widget.TextoEs),
          Text(widget.TextoMa),
        ],
      )
    );
  }
}
