import 'package:flutter/material.dart';
import 'audio_screen.dart';
import 'chat_screen.dart';
import 'member_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 1;
  late List<Widget> _screens;

  @override
  void initState() {
    _screens = [ChatScreen(), AudioScreen(), MemberScreen()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screens[_index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.message), label: 'ChatTraductor'),
          BottomNavigationBarItem(
              icon: Icon(Icons.mic_rounded), label: 'AudioTraductor'),
          BottomNavigationBarItem(
              icon: Icon(Icons.accessibility_new_rounded), label: 'Miembros'),
        ],
        elevation: 0,
        currentIndex: _index,
        onTap: (int newValue) {
          setState(() {
            _index = newValue;
          });
        },
      ),
    );
  }
}
