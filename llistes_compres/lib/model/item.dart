class item {
  bool comprat;
  String nom;
  int cantitat;

  item({
    required this.comprat,
    required this.nom,
    required this.cantitat,
  });

  factory item.fromMap(Map<String, dynamic> map) {
    return item(
      comprat: map['comprat'] ?? false,
      nom: map['nom'] ?? '',
      cantitat: map['cantitat'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'comprat': comprat,
      'nom': nom,
      'cantitat': cantitat,
    };
  }
}
