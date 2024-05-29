// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:llistes_compres/model/item.dart';
import 'package:llistes_compres/model/llista.dart';
import 'package:llistes_compres/provider/llistaProvider.dart';
import 'package:provider/provider.dart';

class itemsScreen extends StatefulWidget {
  itemsScreen({super.key, required this.llista});
  final Llista llista;

  @override
  State<itemsScreen> createState() => _itemsScreenState();
}

class _itemsScreenState extends State<itemsScreen> {
  @override
  Widget build(BuildContext context) {
    List<Item> items = Item.fromList(widget.llista.items);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.llista.nom),
      ),
      body: Center(
        child: items.isEmpty
            ? Text(
                "No hi han productes per a aquesta llista",
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
        return ClickableItemCard(
          item: items[index],
          llist: widget.llista,
        );
      },
    );
  }
}

class ClickableItemCard extends StatefulWidget {
  ClickableItemCard({required this.llist, super.key, required this.item});
  final Llista llist;
  final Item item;

  @override
  State<ClickableItemCard> createState() => _ClickableItemCardState();
}

class _ClickableItemCardState extends State<ClickableItemCard> {
 @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (() {setState(() {
          actualitzarEstatItem(context);
        });
          
        }),
        child: ItemCard(
          llista: widget.llist,
          item: widget.item,
        ));
  }

  actualitzarEstatItem(BuildContext context) {
    List<dynamic> llistaItemsA = widget.llist.items;
    List<dynamic> llistaItemsN = [];
    var llistaProvi = Provider.of<Llistaprovider>(context, listen: false);
    widget.item.comprat = !widget.item.comprat;

    for (dynamic listItem in llistaItemsA) {
      if (listItem["nom"] == widget.item.nom) {
        llistaItemsN.add(widget.item.toMap());
      } else {
        llistaItemsN.add(listItem);
      }
    }

    widget.llist.items = llistaItemsN;

    llistaProvi.updateLlista(widget.llist.id, "items", widget.llist);
    
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.item,
    required this.llista,
  });
  final Item item;
  final Llista llista;

  @override
  
  Widget build(BuildContext context) {
   print(item);
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.nom,
                      style: TextStyle(
                        decoration:
                            item.comprat ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(item.cantitat),
                  ),
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
    );
  }
}
