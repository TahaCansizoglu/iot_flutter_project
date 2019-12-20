import 'dart:convert';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';

import 'package:http/http.dart' as http;



class FirebaseService {
  static const String FIREBASE_URL = "https://sicakliksau.firebaseio.com/";
    Future<String> getSicaklik() async {//değiştir getsicaklik
        String result = (await FirebaseDatabase.instance.reference().child("veri").once()).value;
        print(result);
        //Sicaklikveri.fromJson(result);
        return result;
    }
    

  
}