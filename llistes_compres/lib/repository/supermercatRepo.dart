import 'package:http/http.dart' as http;

import 'dart:convert'; // Per realitzar conversions entre tipus de dades

class SupermercatRepo {
  Future<List<dynamic>> obtenirSupermercat(String supermercat) async {
    String url = 'http://localhost:8080/api/llistes/$supermercat';
    http.Response data = await http.get(Uri.parse(url));

    if (data.statusCode == 200) {
      String body = utf8.decode(data.bodyBytes);
      final bodyJSON = jsonDecode(body) as List;
      return bodyJSON;
    } else {
      return [];
    }
  }
}
