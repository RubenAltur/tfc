// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, empty_catches, must_be_immutable

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:llistes_compres/services/auth_service.dart';

import 'components/MYtextfield.dart';
import 'components/MyButton.dart';
import 'components/SquareTile.dart';

class Registerscreen extends StatefulWidget {
  Registerscreen({super.key, required this.onTap});

  Function()? onTap;

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final usuariController = TextEditingController();

  final passController = TextEditingController();
  final passConfiController = TextEditingController();
  void registrarUser() async {
    try {
      if (passConfiController.text == passController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: usuariController.text, password: passController.text);
      } else {
        showError("Les contrasenyes no coincidixen");
         Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (e) {
      

      showError(e.code);
       Navigator.of(context).pop();
    }
  }

  void showError(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
          );
        });
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
              "Anem a acrear un compter",
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
            SizedBox(height: 5),
//confirmer pass
            MYtextfield(
                controller: passConfiController,
                hintText: "Confirma la contraseña",
                amagarText: true),

            //forgot pass
            SizedBox(height: 10),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Text("Olvido su contraseña?")],
                )),
            SizedBox(height: 25),
            //sign in
            MyButton(
              onTap: registrarUser,
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
                Text("Ja tens un compter?"),
                SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Log in",
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
