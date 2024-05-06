import 'package:flutter/foundation.dart';
import 'package:llistes_compres/repository/supermercatRepo.dart';

class supermercatProvider with ChangeNotifier {
  final _supermercatRepo = SupermercatRepo();
  List<dynamic>? llistaProd;
  String? _superActual = "";
  supermercatProvider() {
    _carregaSupermercat(superMercatActual);
  }

  void _carregaSupermercat(supermercat) async {
    List<dynamic> jsonSuperM =
        await _supermercatRepo.obtenirSupermercat(supermercat);
    llistaProd = jsonSuperM;
    notifyListeners();
  }

  String get superMercatActual {
    return _superActual!;
  }

  set superMercatActual(String? supermercat) {
    if (_superActual == null || _superActual != supermercat) {
      llistaProd = null;
      _superActual = supermercat;

      _carregaSupermercat(supermercat);
      notifyListeners();
    }
  }
}
