

class Llista {
  bool _comprada;
  String _data;
  int _id;
  List<dynamic> _items;
  String _nom;
  String _supermercat;
  String _usuari;

  // Constructor principal
  Llista(this._comprada, this._data, this._id, this._items, this._nom, this._supermercat, this._usuari);

  // Constructor vacío
  Llista.empty()
      : _comprada = false,
        _data = '',
        _id = 0,
        _items = [],
        _nom = '',
        _supermercat = '',
        _usuari='';
  
  // Constructor named fromMap
  Llista.fromMap(Map<String, dynamic> map) :
    _comprada = map['comprada'],
    _data = map['data'],
    _id = map['id'],
    _items = map['items'],
    _nom = map['nom'],
    _supermercat = map['supermercat'],
    _usuari =map['usuari'];

   Map<String, dynamic> toMap() {
    return {
      'comprada': _comprada,
      'data': _data,
      'id': _id,
      'items': _items,
      'nom': _nom,
      'supermercat': _supermercat,
      'usuari': _usuari
    };}

  String get usuari => _usuari;
  set usuari(String value) {
    _usuari = value;
  }



  // Getter and Setter for comprada
  bool get comprada => _comprada;
  set comprada(bool value) {
    _comprada = value;
  }

  // Getter and Setter for data
  String get data => _data;

  set data(String value) {
    _data = value;
  }

  // Getter and Setter for id
  int get id => _id;
  set id(int value) {
    _id = value;
  }

  // Getter and Setter for items
 List<dynamic> get items => _items;
  set items(List<dynamic> value) {
    _items = value;
  }

  // Getter and Setter for nom
  String get nom => _nom;
  set nom(String value) {
    _nom = value;
  }

  // Getter and Setter for supermercat
  String get supermercat => _supermercat;
  set supermercat(String value) {
    _supermercat = value;
  }

  
}