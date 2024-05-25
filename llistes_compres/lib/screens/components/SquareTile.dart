

import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imgPath;
  const SquareTile({super.key, required this.imgPath, required this.onTap});
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(16)),
          child: Image.asset(
            imgPath,
            height: 40,
          )),
    );
  }
}