import 'package:flutter/foundation.dart';

import 'package:llistes_compres/services/firebase_service.dart';



class Llistaprovider with ChangeNotifier {
  final fs = fireservice();
  List<Map<String, dynamic>>? _llistaEnv;
  String? _llistaActual = "";
  String? superMercatActual="";

  Llistaprovider() {
    _carregaLlistes();
  }


  void _carregaLlistes() async{

    List<Map<String, dynamic>>? jsonLlista= await fs.getLlistes();
    _llistaEnv=jsonLlista;
    

    
    notifyListeners();
  }

  void _carregaLlistesC(dynamic data) async{
    List<Map<String, dynamic>> jsonLlista= await fs.getLlistes();
      print(jsonLlista);
    _llistaEnv=jsonLlista;
    notifyListeners();
  }
  
  String get llistaActual {
    return _llistaActual!;
  }

  List<Map<String, dynamic>>? get llistaEnv {
    return _llistaEnv;
  }

  set superMercatActuall(String? llista) {
    if (_llistaActual == null || _llistaActual != llista) {
      _llistaEnv = null;
      _llistaActual = llista;

      _carregaLlistesC(llista);
      notifyListeners();
    }
  }
}
