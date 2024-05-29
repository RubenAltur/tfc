// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, empty_catches, must_be_immutable

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:llistes_compres/services/auth_service.dart';

import 'components/MYtextfield.dart';
import 'components/MyButton.dart';
import 'components/SquareTile.dart';

class Loginscreen extends StatefulWidget {
  Loginscreen({super.key, required this.onTap});

  Function()? onTap;

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        user = event;
      });
    });
  }

  void registrarGoogle() {
    try {
      GoogleAuthProvider _googleProv = GoogleAuthProvider();
      _auth.signInWithProvider(_googleProv);
    } catch (e) {
      print(e);
    }
  }

  final usuariController = TextEditingController();

  final passController = TextEditingController();

  void loginUser() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usuariController.text, password: passController.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      if (e.code == "user-not-found" || e.code == "wrong-password") {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("El mail o contraseña son incorrectes"),
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white10,
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 50),
            //logo
            Icon(Icons.lock),
            SizedBox(height: 50),
            //welcome
            Text(
              "Bienvenido",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(height: 25),

            //username
            MYtextfield(
                controller: usuariController,
                hintText: "Usuari",
                amagarText: false),
            SizedBox(height: 5),
            //password
            MYtextfield(
                controller: passController,
                hintText: "Contraseña",
                amagarText: true),
            //forgot pass
            SizedBox(height: 10),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Text("Ha olvidat la seua contrasenya?")],
                )),
            SizedBox(height: 25),
            //sign in
            MyButton(
              onTap: loginUser,
            ),
            SizedBox(height: 50),
            //continue with

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Continua con:",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            //google login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareTile(
                    onTap: () => AuthService().signinWithGoogle(),
                    imgPath: 'lib/assets/img/google.png')
              ],
            ),

            //register
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Aun no està registrado?"),
                SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Registrate",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ]),
        ))));
  }
}
