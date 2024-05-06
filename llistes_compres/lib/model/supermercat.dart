class Supermercat {
  String? producte;
  int? cantitat;
  int? preu;

  Supermercat({required this.producte, this.cantitat, this.preu});

  Supermercat.fromJSON(Map<String, dynamic> objecteJSON) {
    producte = objecteJSON["Producte"] ?? "";
    producte = objecteJSON["Cantitat"] ?? "";
    producte = objecteJSON["Preu"] ?? "";
  }

  @override
  String toString() {
    return "producte: $producte,cantitat: $cantitat,preu: $preu";
  }
}
