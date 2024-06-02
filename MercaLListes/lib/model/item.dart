class Item {
  bool comprat;
  String nom;
  String cantitat;

  Item({
    required this.comprat,
    required this.nom,
    required this.cantitat,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      comprat: map['comprat'] ?? false,
      nom: map['nom'] ?? '',
      cantitat: map['cantitat'] ?? '',
    );
  }

  Map<String, dynamic> toMap() { 
    return {
      'comprat': comprat,
      'nom': nom,
      'cantitat': cantitat,
    };
  }
   

 static List<Item> fromList(List<dynamic> list) {
    return list.map((map) => Item.fromMap(map)).toList();
  }

  @override
  String toString() {
    return 'Llista(comprada: $comprat, cantitat: $cantitat, nom: $nom)';
  }
}
