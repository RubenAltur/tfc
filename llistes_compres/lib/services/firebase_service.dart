// ignore_for_file: empty_catches, non_constant_identifier_names

import "package:cloud_firestore/cloud_firestore.dart";
import 'dart:math';

class fireservice{
FirebaseFirestore firestore = FirebaseFirestore.instance;


Future<List<Map<String, dynamic>>> getLlistes() async {
  try {
    CollectionReference collection = firestore.collection("llistes");
    QuerySnapshot querySnapshot = await collection.get() as QuerySnapshot<Object?>;
     print(querySnapshot);

    List<Map<String, dynamic>> data;

    data = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return data;
    }).toList();
    print(data);
    return data;
   

  } catch (e) {
    print("Error al obtener los documentos: $e");
    return [];
  }
}
//firestore.collection("llistes");
 

String generarRandomId(int length) {
  const String chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final Random random = Random();

  return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
}

Future<void> addLlistes(Map<String, dynamic> llista)async{

try{
await firestore.collection('llistes').doc(generarRandomId(9)).set(llista);
}catch (e) {
      
    }
}        

Future<void> updateCamp(String colleccio, String Id, String camp, dynamic valorNou) async {
    try {
      await firestore.collection(colleccio).doc(Id).update({camp: valorNou});
      
    } catch (e) {
      
    }
  }


Future<void> borrarCollecio(String colleccio, String Id) async {
    try {
      await firestore.collection(colleccio).doc(Id).delete();
      
    } catch (e) {
     
    }
  }



Future<List<dynamic>> getItemsFromLlista(String colleccio, String Id, String items) async {
  try {
    DocumentSnapshot docSnapshot = await firestore.collection(colleccio).doc(Id).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      return data[items] as List<dynamic>;
    } else {
     
      return [];
    }
  } catch (e) {
   
    return [];
  }
}
}