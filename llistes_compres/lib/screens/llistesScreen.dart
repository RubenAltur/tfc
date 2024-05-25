// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:llistes_compres/model/llista.dart';
import 'package:llistes_compres/provider/llistaProvider.dart';
import 'package:provider/provider.dart';




class llisteScreen extends StatelessWidget {
  llisteScreen({this.supermercat, Key? key}) : super(key: key);

  final String? supermercat;
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    var llistaProvi = Provider.of<Llistaprovider>(context);
    llistaProvi.superMercatActual = supermercat!;
    List<Map<String, dynamic>>? values = llistaProvi.llistaEnv;

    // Filtrar las listas que pertenecen al supermercado actual
    List<Llista> listasFiltradas = values?.map((data) => Llista.fromMap(data))
        .where((llist) => llist.supermercat == supermercat&& llist.usuari == user.email)
        .toList() ?? [];

       

    return Scaffold(
      appBar: AppBar(
        title: Text('Llistes de Compres'),
      ),
      body: Center(
        child: listasFiltradas.isEmpty
            ? Text(
                "No hi han llistes per a aquest Supermercat",
                style: TextStyle(
                  fontFamily: "LeckerliOne",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              )
            : _creaLlistaProductes(listasFiltradas),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _showAddItemDialog(context, llistaProvi.superMercatActual, llistaProvi);
              },
            ),
          ],
        ),
      ),
    );
  }

  dynamic _creaLlistaProductes(List<Llista> listasFiltradas) {
    
    return ListView.builder(
      itemCount: listasFiltradas.length,
      itemBuilder: (BuildContext context, int index) {
        return llistaCard(llist: listasFiltradas[index]);
      },
    );
  }

  void _showAddItemDialog(BuildContext context, String? superMActual, Llistaprovider llistaProvi) {
    final _formKey = GlobalKey<FormState>();
    
    Llista llistaNova = Llista.empty();
    String fecha = obtenerFechaDeHoy();
    String? nomLL="";
    llistaNova.data = fecha;
    llistaNova.supermercat = superMActual!;
    llistaNova.usuari=user.email!;

    List<TextEditingController> _productControllers = [];
    List<TextEditingController> _quantityControllers = [];

    void _addProductField() {
      _productControllers.add(TextEditingController());
      _quantityControllers.add(TextEditingController(text: '0'));
    }

    void _removeProductField(int index) {
      _productControllers.removeAt(index);
      _quantityControllers.removeAt(index);
    }

    _addProductField(); // Añadir un campo inicial

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Crea una llista nova'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Nom'),
                        onSaved: (value) {
                          nomLL=value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Introdueix un nom';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      Text('Productes'),
                      ..._productControllers.asMap().entries.map((entry) {
                        int index = entry.key;
                        return Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: _productControllers[index],
                                decoration: InputDecoration(
                                  labelText: 'Producte',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Introdueix un producte';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        int currentValue = int.parse(_quantityControllers[index].text);
                                        if (currentValue > 0) {
                                          currentValue--;
                                          _quantityControllers[index].text = currentValue.toString();
                                        }
                                      });
                                    },
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _quantityControllers[index],
                                      decoration: InputDecoration(
                                        labelText: 'Quantitat',
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Introdueix una quantitat';
                                        }
                                        if (int.tryParse(value) == null) {
                                          return 'Introdueix un número vàlid';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        int currentValue = int.parse(_quantityControllers[index].text);
                                        currentValue++;
                                        _quantityControllers[index].text = currentValue.toString();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.remove_circle),
                              onPressed: () {
                                setState(() {
                                  _removeProductField(index);
                                });
                              },
                            ),
                          ],
                        );
                      }).toList(),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {

                          setState(() {
                            _addProductField();
                          });
                        },
                        child: Text('Afegeix Producte'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              child: Text('Cancel·la'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Afegeix'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  
                  List<Map<String, String>> products = [];
                  for (int i = 0; i < _productControllers.length; i++) {
                    products.add({
                      'producte': _productControllers[i].text,
                      'quantitat': _quantityControllers[i].text,
                    });
                  }
                  // Aquí podrías añadir la lógica para agregar la lista y los productos al proveedor
                   llistaNova.nom = nomLL!;
                    llistaNova.items=products;
                    int idR=generarRandomId(10);
                    llistaNova.id=idR;
                    print(llistaNova.toString());
                    llistaProvi.addLlista(llistaNova);
                    
                  Navigator.of(context).pop();
                  
                }
              },
            ),
          ],
        );
      },
    );
  }
}

int generarRandomId(int length) {
   final Random random = Random();
  String numero = '';

  for (int i = 0; i < 9; i++) {
    int digito = random.nextInt(9) + 1; // Genera un número aleatorio entre 1 y 9
    numero += digito.toString();
  }

  return int.parse(numero);
}


String obtenerFechaDeHoy() {
  DateTime ahora = DateTime.now();
  return "${ahora.day.toString().padLeft(2, '0')}/${ahora.month.toString().padLeft(2, '0')}/${ahora.year}";
}

class llistaCard extends StatelessWidget {
  llistaCard({super.key, required this.llist});
  final Llista llist;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 100,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
           ),
          color: const Color.fromARGB(255, 224, 106, 59),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
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
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
            ),
           
           Expanded(
              flex: 1,
              child: Text(
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
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
            ),
          
            Expanded(
              flex: 1,
              child: Text(
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
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
