import 'package:flutter/material.dart';
import 'package:llistes_compres/provider/llistaProvider.dart';
import 'package:llistes_compres/screens/AuthScreen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Llistaprovider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Llista supermercats',
        home: AuthScreen(),
      ),
    );
  }
}
