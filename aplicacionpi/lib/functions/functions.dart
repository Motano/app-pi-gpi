import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

final myController = TextEditingController();

// Función post a la api para obtener la traducción
Future<String> postRequest(String traducir) async {
  var Box = Hive.box('config');
  String Ruta = Box.get('Ruta');
  var url = Uri.parse('http://$Ruta/api/traductor');
  Map data = {"spanish": traducir};
  var body = jsonEncode(data);
  var response = await http.post(url,
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate,br"
      },
      body: body);

  //print(utf8.decode(response.bodyBytes));
  return utf8.decode(response.bodyBytes);
}

// Guardado de la ruta en la BOX creada en Hive

Future<void> setRuta(String ruta) async {
  await Hive.initFlutter();
  var box = await Hive.openBox('config');
  var Box = Hive.box('config');
  Box.put('Ruta', ruta);
}
