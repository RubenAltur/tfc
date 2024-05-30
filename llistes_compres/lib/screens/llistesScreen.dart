// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:llistes_compres/model/llista.dart';
import 'package:llistes_compres/provider/llistaProvider.dart';
import 'package:llistes_compres/screens/itemsScreen.dart';
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
    List<Llista> listasFiltradas = values
            ?.map((data) => Llista.fromMap(data))
            .where((llist) =>
                llist.supermercat == supermercat && llist.usuari == user.email)
            .toList() ??
        [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Llistes de Compres de $supermercat'),
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
                _showAddItemDialog(
                    context, llistaProvi.superMercatActual, llistaProvi);
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
        return ClickablLlistaCard(llist: listasFiltradas[index]);
      },
    );
  }

  void _showAddItemDialog(
      BuildContext context, String? superMActual, Llistaprovider llistaProvi) {
    final _formKey = GlobalKey<FormState>();

    Llista llistaNova = Llista.empty();
    String fecha = obtenerFechaDeHoy();
    String? nomLL = "";
    llistaNova.data = fecha;
    llistaNova.supermercat = superMActual!;
    llistaNova.usuari = user.email!;

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
                          nomLL = value;
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
                                        int currentValue = int.parse(
                                            _quantityControllers[index].text);
                                        if (currentValue > 0) {
                                          currentValue--;
                                          _quantityControllers[index].text =
                                              currentValue.toString();
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
                                        int currentValue = int.parse(
                                            _quantityControllers[index].text);
                                        currentValue++;
                                        _quantityControllers[index].text =
                                            currentValue.toString();
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

                  List<Map<String, dynamic>> products = [];
                  for (int i = 0; i < _productControllers.length; i++) {
                    products.add({
                      'comprat': false,
                      'nom': _productControllers[i].text,
                      'cantitat': _quantityControllers[i].text,
                    });
                  }
                  // Aquí podrías añadir la lógica para agregar la lista y los productos al proveedor
                  llistaNova.nom = nomLL!;
                  llistaNova.items = products;

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

String obtenerFechaDeHoy() {
  DateTime ahora = DateTime.now();
  return "${ahora.day.toString().padLeft(2, '0')}/${ahora.month.toString().padLeft(2, '0')}/${ahora.year}";
}

class ClickablLlistaCard extends StatelessWidget {
  ClickablLlistaCard({required this.llist, super.key});
  final Llista llist;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => itemsScreen(
                        llista: llist,
                      ))));
        }),
        child: llistaCard(llist: llist));
  }
}

class llistaCard extends StatelessWidget {
  llistaCard({super.key, required this.llist});
  final Llista llist;
  

  @override
  Widget build(BuildContext context) {
    llist.productesComprats;
    return Card(
      child: Container(
        height: 100,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
         
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                llist.nom,
                style: TextStyle(
                  decoration: 
                   llist.comprada ? TextDecoration.lineThrough : null,
                  fontFamily: "LeckerliOne",
                  fontWeight: FontWeight.bold,
                  color: llist.comprada ? Colors.black : Colors.white,
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
                "Productes restants: ${llist.productesComprats()}",
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
