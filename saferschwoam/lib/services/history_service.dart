import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/consumeddrink.dart';
import '../models/drink.dart';


class HistoryService {
  final CollectionReference collection = FirebaseFirestore.instance.collection('History');

  Stream<List<ConsumedDrink>> getHistory() {
    return collection
        .where('user', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .orderBy('consumed', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ConsumedDrink.fromFirestore(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Future<void> addDrinkToHistory(Drink drink) async {
    await collection.add({
      'name': drink.name,
      'size': drink.size,
      'alcohol': drink.alcohol,
      'consumed': DateTime.now(),
      'user': FirebaseAuth.instance.currentUser?.uid,
    });
  }
  
  Future<void> clearHistory() async {
   var collection = FirebaseFirestore.instance.collection('History')
   .where('user', isEqualTo: FirebaseAuth.instance.currentUser?.uid);
    var snapshots = await collection.get();
for (var doc in snapshots.docs) {
  await doc.reference.delete();
}
  }

}
