import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:llistes_compres/screens/loginOrRegister.dart';
import 'package:llistes_compres/screens/mainScreen.dart';
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

class AuthScreen extends StatelessWidget{

  AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: StreamBuilder<User?>(

            stream: FirebaseAuth.instance.authStateChanges(),
            builder:(context, snapshot){
                if(snapshot.hasData){

                  return mainScreen();
                }
                  else{
                    return LoginOrRegisterScreen();
                  }

            }
        ),


    );
  }


  
}