import 'package:flutter/material.dart';
import 'package:llistes_compres/provider/supermercatProvider.dart';
import 'package:provider/provider.dart';

class producScreen extends StatelessWidget {
  producScreen({this.supermercat, super.key});
  final String? supermercat;

  @override
  Widget build(BuildContext context) {
    var superProvi = Provider.of<supermercatProvider>(context);
    superProvi.superMercatActual = supermercat!;

    return Scaffold(
      body: Center(
        child: _creaLlistaProductes(superProvi.llistaProd),
      ),
    );
  }

  dynamic _creaLlistaProductes(List<dynamic>? values) {
    if (values == null) return const CircularProgressIndicator();

    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        if (values.isNotEmpty) {
          String nom = values[index]["Producte"];
          String preu = values[index]["Preu"];
          String cantitat = values[index]["Cantitat"];
          return ProducteCard(nom: nom, preu: preu, cantitat: cantitat);
        } else {
          return const Center(
            child: Text("This shit empty"),
          );
        }
      },
    );
  }
}

class ProducteCard extends StatelessWidget {
  const ProducteCard(
      {super.key,
      required this.nom,
      required this.preu,
      required this.cantitat});

  final String nom;
  final String preu;
  final String cantitat;

  @override
  Widget build(BuildContext context) {
    int preuTotal = (int.parse(preu) * int.parse(cantitat));
    String preuTotalS = preuTotal.toString();
    return Card(
        child: Container(
      height: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 10, 1, 63),
      ),
      child: Row(
        children: [
          Text(
            "Producte: $nom",
            style: const TextStyle(
                fontFamily: "LeckerliOne",
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 250, 250),
                fontSize: 15,
                shadows: [
                  Shadow(
                      offset: Offset(2, 2),
                      color: Color.fromARGB(255, 0, 0, 0),
                      blurRadius: 3),
                ]),
          ),
          Spacer(),
          Text(
            "Cantitat: $cantitat unitat",
            style: const TextStyle(
                fontFamily: "LeckerliOne",
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 15,
                shadows: [
                  Shadow(
                      offset: Offset(2, 2), color: Colors.black, blurRadius: 3),
                ]),
          ),
          Spacer(),
          Text(
            "Preu per unitat: $preu€",
            style: const TextStyle(
                fontFamily: "LeckerliOne",
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 15,
                shadows: [
                  Shadow(
                      offset: Offset(2, 2), color: Colors.black, blurRadius: 3),
                ]),
          ),
          Spacer(),
          Text(
            "Preu Total: $preuTotalS€",
            style: const TextStyle(
                fontFamily: "LeckerliOne",
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 15,
                shadows: [
                  Shadow(
                      offset: Offset(2, 2), color: Colors.black, blurRadius: 3),
                ]),
          ),
        ],
      ),
    ));
  }
}
