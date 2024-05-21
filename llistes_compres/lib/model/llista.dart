import 'package:llistes_compres/model/item.dart';

class llista {
  bool comprada;
  String data;
  int id;
  List<dynamic> items;
  String nom;
  String supermercat;

  llista({
    required this.comprada,
    required this.data,
    required this.id,
    required this.items,
    required this.nom,
    required this.supermercat,
  });

  factory llista.fromMap(Map<String, dynamic> map) {
    return llista(
      comprada: map['comprada'] ?? false,
      data: map['data'] ?? '',
      id: map['id'] ?? 0,
      items: (map['items'] as List<dynamic>).map((item) => 
      item.fromMap(item as Map<String, dynamic>)).toList(),
      nom: map['nom'] ?? '',
      supermercat: map['supermercat'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'comprada': comprada,
      'data': data,
      'id': id,
      'items': items.map((item) => item.toMap()).toList(),
      'nom': nom,
      'supermercat': supermercat,
    };
  }
}