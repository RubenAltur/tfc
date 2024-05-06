import 'package:flutter/material.dart';
import 'package:llistes_compres/provider/supermercatProvider.dart';
import 'package:llistes_compres/screens/mainScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => supermercatProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Llista supermercats',
        home: mainScreen(),
      ),
    );
  }
}
