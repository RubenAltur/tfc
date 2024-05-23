// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:llistes_compres/model/llista.dart';

import 'package:llistes_compres/provider/llistaProvider.dart';
import 'package:provider/provider.dart';





class llisteScreen extends StatelessWidget {
  llisteScreen({this.supermercat, super.key});
  final String? supermercat;

  @override
  Widget build(BuildContext context) {
    var llistaProvi = Provider.of<Llistaprovider>(context);
    llistaProvi.superMercatActual = supermercat!;
    List<Map<String, dynamic>>? values=llistaProvi.llistaEnv;
     
    return Scaffold(
      
      body: Center(
        
        child: _creaLlistaProductes(values),
      ),
    );
  }

  dynamic _creaLlistaProductes(List<Map<String, dynamic>>? values) {
    if (values == null) {
      // Si la llista és nul·la retornem un indicador de progrés
    
      return const CircularProgressIndicator();
    }


    
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
      
       Llista llist =Llista.fromMap(values[index]);
       print(llist.nom);
        
       
        
      if (values.isNotEmpty) {return llistaCard(llist: llist);}
      return null;

           
         
        
      },
    );
  }
}
class llistaCard extends StatelessWidget {
  llistaCard({super.key, required this.llist});
  final Llista llist;
  


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          height: 150,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 67, 70, 72),
          ),
          child: Row(
           
            children:[ 
              
              Text(
              llist.nom,
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
            Spacer(),
              Text(
                "Data de la llista: ${llist.data}",
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
              Spacer(),
               Text(
              "Productes restants: ${llist.items.length}",
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


          ])),
    );
  }
}
