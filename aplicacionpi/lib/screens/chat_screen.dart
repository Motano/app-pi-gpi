import 'dart:convert';

import 'package:aplicacionpi/models/messages.dart';
import 'package:aplicacionpi/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final myController = TextEditingController();
  String traducir = "";
  List<Message> _mensajes = [
    Message("Envia cualquier frase para empezar a traducir", false),
  ];
  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    myController.dispose();
    super.dispose();
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
                  child: ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.only(top: 15.0),
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
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
