import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final myController = TextEditingController();

Future<String> postRequest(String traducir) async {
  var url = Uri.parse('http://35.222.79.80:5000/api/traductor');
  Map data = {"spanish": traducir};
  var body = jsonEncode(data);
  var response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate,br"
      },
      body: body);

  return response.body;
}
