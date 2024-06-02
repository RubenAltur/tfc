// ignore_for_file: empty_catches, non_constant_identifier_names

import "package:cloud_firestore/cloud_firestore.dart";
import "package:llistes_compres/model/llista.dart";


class fireservice{
FirebaseFirestore firestore = FirebaseFirestore.instance;


Future<List<Map<String, dynamic>>> getLlistes() async {
  try {
    CollectionReference collection = firestore.collection("llistes");
    QuerySnapshot querySnapshot = await collection.get();
    

    List<Map<String, dynamic>> data = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['uid'] = doc.id; 
      return data;
    }).toList();

    //print(data);
    return data;
  } catch (e) {
    print("Error al obtener los documentos: $e");
    return [];
  }
}

//firestore.collection("llistes");
 



Future<void> addLlista(Map<String, dynamic> llista)async{

try{

await firestore.collection('llistes').add(llista);

}catch (e) {
      
    }
}        

Future<void> updateCamp( String Id, String camp, Llista valorNou) async {
    try {
       
      
      await firestore.collection("llistes").doc(Id).set(valorNou.toMap());
      
    } catch (e) {
      
    }
  }


Future<void> borrarCollecio(String colleccio, dynamic Id) async {
    try {
      await firestore.collection(colleccio).doc(Id).delete();
      
    } catch (e) {
     print("Error al actualizar el documento: $e");
    }
  }



}