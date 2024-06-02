

import 'package:flutter/material.dart';

class MYtextfield extends StatelessWidget {
  final controller;
  final String hintText;
  final bool amagarText;

  const MYtextfield(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.amagarText});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: TextField(
          controller: controller,
          obscureText: amagarText,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              hintText: hintText),
        ));
  }
}