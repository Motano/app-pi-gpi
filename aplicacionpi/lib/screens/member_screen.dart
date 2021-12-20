import 'package:flutter/material.dart';

class MemberScreen extends StatefulWidget {
  @override
  _MemberScreenState createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  @override
  bool isHover = false;
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Información'),
        ),
        body: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(15),
          elevation: 10,
          child: ListView(
            children: <Widget>[
              // Usamos ListTile para ordenar la información del card como titulo, subtitulo e icono
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                title: Text('¿De que trata el proyecto?'),
                subtitle: Text(
                    'Como sección de GPI 2021 segundo semestre se nos propuso, como proyecto de investigación, realizar una aplicación capaz de traducir del español al mapudungun. Este mediante un dataset encontrado en linea y el uso de las respectivas tecnologias fue desarrollado a lo largo del semestre donde la sección se separó en distintas ramas, tales como: Desarrollador, Documentador e Investigador'),
                leading: Icon(Icons.analytics_outlined),
              ),
              ListTile(
                  contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                  title: Text('Jefes de area'),
                  subtitle: Text(
                      'Jefe de proyecto : Kevin Salinas Velastín\nJefe de desarrollo : Israel Pérez Berríos\nJefe de documentación : Andrés Parada Claussen'),
                  leading: Icon(Icons.face_unlock_outlined)),
              ListTile(
                  contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                  title: Text('Desarrolladores'),
                  subtitle: Text(
                      'Roberto Albornoz Gutiérrez\nEdgar Matus Soto\nEsteban Moyano Pérez\nLeonardo Peña Fuentes\nJavier Saavedra Zaravia'),
                  leading: Icon(Icons.engineering_sharp)),
              ListTile(
                  contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                  title: Text('Documentadores'),
                  subtitle: Text(
                      'Rodrigo Aguirre Rodríguez\nBraulio Argandoña Carrasco\nAlex Bidart Orellana\nDaniel Bustamante Díaz\nFelipe Gonzalez Duarte\nNicolás Jiménez Jiménez\nMiguel Martinez Sánchez\nAndres Mella Varela\nDiego Núñez Gomez\nAriel Painenao Pincheira\nIan Poveda Duarte\nFanny Rivero Valdivia\nEsteban Rojas Rojas\nCristobal Sanchez Orellana\nAndrés Segarra Pavez\nAlan Slazak Castro\nFabián Urriola Poisson\nCristobal Valenzuela Catalan'),
                  leading: Icon(Icons.fact_check_outlined)),
            ],
          ),
        ));
  }
}
