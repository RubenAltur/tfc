

class Llista {
  bool _comprada;
  String _data;
  String _uid;
  List<dynamic> _items;
  String _nom;
  String _supermercat;
  String _usuari;

  // Constructor principal
  Llista(this._comprada, this._data, this._uid, this._items, this._nom, this._supermercat, this._usuari);

  // Constructor vacío
  Llista.empty()
      : _comprada = false,
        _data = '',
        _uid = '',
        _items = [],
        _nom = '',
        _supermercat = '',
        _usuari='';
  
  // Constructor named fromMap
  Llista.fromMap(Map<String, dynamic> map) :
    
    _data = map['data'],
    _uid = map['uid'],
    _items = map['items'],
    _nom = map['nom'],
    _supermercat = map['supermercat'],
    _usuari =map['usuari'],
    _comprada = map['comprada'];

   Map<String, dynamic> toMap() {
    return {
      'comprada': _comprada,
      'data': _data,
      'id': _uid,
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
  String get id => _uid;
  set id(String value) {
    _uid = value;
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
 @override
  String toString() {
    return 'Llista(comprada: $_comprada, data: $_data, uid: $_uid, items: $_items, nom: $_nom, supermercat: $_supermercat, usuari: $_usuari)';
  }
  
  int productesComprats(){
    int prod=0;
      items.forEach((producte){
          
          if(!producte['comprat']) prod++;

      });


    return prod;

  }

  void llistaComprada(){
   
    int prod=0;
    int llistaP=items.length;
      items.forEach((producte){
          
          if(producte['comprat']) prod++;

      });
    if(prod==llistaP)comprada=true;

    

  }

}