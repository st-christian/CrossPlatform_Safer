import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/drink.dart';

class DrinkService {
  final CollectionReference collection = FirebaseFirestore.instance.collection('Drinks');

  Stream<List<Drink>> getDrinks() {
    return collection
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Drink.fromFirestore(doc.data() as Map<String, dynamic>))
            .toList());
  }
}