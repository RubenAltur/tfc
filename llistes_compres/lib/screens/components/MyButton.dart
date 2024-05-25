

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({super.key, this.onTap});

  final Function()? onTap;

  @override
  Widget build(Object context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(25),
          margin: EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 224, 106, 59),
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ));
  }
}