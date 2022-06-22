import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

class FirebaseConnection {

  DatabaseReference instanceFirebase() {
    FirebaseDatabase database = FirebaseDatabase.instance;
    return database.ref('');
  }

  Future<Map<String, dynamic>> getData(String path) async {

    final snapshot = await instanceFirebase().child(path).get();
    if (snapshot.exists){
      final data = json.encode(snapshot.value);
      final dataDecoded = json.decode(data);
      Map<String, dynamic> response = {};
      print(dataDecoded);
      // dataDecoded.removeWhere((value) => value == null);
      dataDecoded!.forEach((item) {
        if (item != null) {
          response[item["id"]] = item;
        }
      });

      return response;
    }
    return {};

  }

}