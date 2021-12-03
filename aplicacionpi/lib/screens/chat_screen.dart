import 'package:aplicacionpi/model/modelos.dart';
import 'package:aplicacionpi/functions/functions.dart';
import 'package:aplicacionpi/widgets/mensajes.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final myController = TextEditingController();
  String traducir = "";
  List<Message> _mensajes = [];
  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    myController.dispose();
    super.dispose();
  }

// Constructor de barra donde se escribe el mensaje
  _buildMessageComposer() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        height: 70.0,
        color: Colors.white,
        child: Row(children: <Widget>[
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.black),
              controller: myController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Envia el mensaje a traducir...',
                hintStyle: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          // Botón de enviar el cual realiza la petición a la api y el guardado en la lista de mensajes para desplegarlas en la vista como chat
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () async {
              traducir = myController.text;

              String translate = await postRequest(traducir);
              List<String> traducido = translate.split(":");
              traducido[1] =
                  traducido[1].replaceAll("}", "").replaceAll('"', "");
              String traducidox =
                  traducido[1][0].toUpperCase() + traducido[1].substring(1);
              setState(() {
                _mensajes.insert(0, Message(traducir, true));
                _mensajes.insert(0, Message(traducidox, false));
                myController.text = "";
              });
            },
          )
        ]));
  }

// Constructor de elementos visuales del chat screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        elevation: 0.0,
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
                  child: Mensajes(
                    mensajes: _mensajes,
                    textoInicial: "Envia cualquier frase para empezar a traducir",
                  )
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
