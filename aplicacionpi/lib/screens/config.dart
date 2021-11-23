import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

  Future<void> asyncInit() async {
    await Hive.initFlutter();
    
    var config = await Hive.openBox('config');
    var ruta = config.get('rutaAPI');
    
    setState(() {
      _controllerRuta.text = ruta;
    });
  }

  @override
  void didChangeDependencies() {
    asyncInit();
  }

  Future<void> setRuta(ruta) async {
  
    /*
    setState(() {
      _controllerRuta.text = ruta;
    });
    */



    var config = await Hive.openBox('config');
    config.put('rutaAPI', ruta);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Configuracion'),
        ),
        body: Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Ruta API',
                    ),
                    controller: _controllerRuta,
                    onChanged: (text) {
                      setRuta(text);
                    },
                  )
                ],
              )
            )
        )
    );
  }
}
