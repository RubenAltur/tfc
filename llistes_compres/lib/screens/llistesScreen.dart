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
    



    return Scaffold(
      
      body: Center(
        
        child: _creaLlistaProductes(llistaProvi.llistaEnv),
      ),
    );
  }

  dynamic _creaLlistaProductes(List<llista>? values) {
    if (values == null) {
      // Si la llista és nul·la retornem un indicador de progrés
      return const CircularProgressIndicator();
    }
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        llista llist = values[index];
        return ListTile(
          title: Text(llist.nom),
          subtitle: Text('Data: ${llist.data}'),
          trailing: Text('Items: ${llist.items.length}'),
        );
      },
    );
  }
}
