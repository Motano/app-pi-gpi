import 'package:flutter/material.dart';
import 'package:aplicacionpi/functions/functions.dart';

class Config extends StatefulWidget {
  const Config({Key? key}) : super(key: key);
  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  final _controllerRuta = TextEditingController();

  @override
  void dispose() {
    // Limpia el controlador cuando el widget se elimine del árbol de widgets
    _controllerRuta.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Configuracion'),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            height: 70.0,
            color: Colors.white,
            child: Row(children: <Widget>[
              Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  controller: _controllerRuta,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ingrese la ruta de la Api...',
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                iconSize: 25.0,
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  String ruta = _controllerRuta.text;
                  setRuta(ruta);
                },
              )
            ])));
  }
}
