// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:llistes_compres/screens/producScreen.dart';

// ignore: must_be_immutable
class mainScreen extends StatelessWidget {
  List<Map<String, String>> llistamercats = [
    {"mercat": "mercadona"},
    {"mercat": "masymas"},
    {"mercat": "carrefour"}
  ];

  mainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _creaLlistaMercats(llistamercats),
      ),
    );
  }

  dynamic _creaLlistaMercats(List<Map<String, String>>? values) {
    if (values == null) {
      // Si la llista és nul·la retornem un indicador de progrés
      return const [CircularProgressIndicator()];
    }

    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        if (values.isNotEmpty) {
          String? mercat = values[index]["mercat"];

          return ClickableMercatCard(mercat: mercat);
        } else {
          return Center(
            child: Text("No mercats"),
          );
        }
      },
    );
  }
}

class ClickableMercatCard extends StatelessWidget {
  ClickableMercatCard({this.mercat, super.key});
  final String? mercat;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => producScreen(supermercat: mercat))));
        }),
        child: mercatCard(mercat: mercat));
  }
}

class mercatCard extends StatelessWidget {
  mercatCard({super.key, this.mercat});
  final String? mercat;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          height: 150,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 67, 70, 72),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "Supermercat: $mercat",
              style: TextStyle(
                  fontFamily: "LeckerliOne",
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                  shadows: [
                    Shadow(
                        offset: Offset(2, 2),
                        color: Colors.black,
                        blurRadius: 3),
                  ]),
            ),
          )),
    );
  }
}
