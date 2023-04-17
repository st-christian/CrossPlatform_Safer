import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/drink.dart';

class DrinkService {
  final CollectionReference collection = FirebaseFirestore.instance.collection('Drinks');

  getDrinks(){
    return collection.snapshots();
  }
}