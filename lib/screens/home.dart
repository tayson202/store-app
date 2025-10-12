import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  static String id = 'home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.abc, color: Colors.black),
          ),
        ],
        backgroundColor: Colors.indigo,
        elevation: 0,
        centerTitle: true,
        title: Text('new', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
