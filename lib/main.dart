import 'package:demo_app/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
runApp(const StoreApp());

}
class StoreApp extends StatelessWidget {
  const StoreApp({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes:{
      Home.id:(context)=>Home()
    },initialRoute:Home.id,
    );
    
  }
}

