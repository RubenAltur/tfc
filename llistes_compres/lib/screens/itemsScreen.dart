// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:llistes_compres/model/item.dart';
import 'package:llistes_compres/model/llista.dart';
import 'package:llistes_compres/provider/llistaProvider.dart';
import 'package:provider/provider.dart';

class itemsScreen extends StatelessWidget {
  itemsScreen({super.key, required this.llista});
  final Llista llista;
  
  @override
  Widget build(BuildContext context) {
    var llistaProvi = Provider.of<Llistaprovider>(context);
    List<Item> items = Item.fromList(llista.items);
  
    return Scaffold(
      appBar: AppBar(
        title: Text(llista.nom),
      ),
      body: Center(
        child: items.isEmpty
            ? Text(
                "No hi han llistes per a aquest Supermercat",
                style: TextStyle(
                  fontFamily: "LeckerliOne",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              )
            : _creaLlistaItems(items),
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
          ],
        ),
      ),
    );
  }

  dynamic _creaLlistaItems(final List<Item> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return ItemCard(item: items[index]);
      },
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    print(item);
    
      return Container(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(item.nom)),
                     
                      Expanded(child: Text(item.cantitat)),
                    ],
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}
