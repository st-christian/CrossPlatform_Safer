import 'package:cloud_firestore/cloud_firestore.dart';

class ConsumedDrink {
  final String name;
  final num size;
  final num alcohol;
  final DateTime consumed;
  final String user;

  ConsumedDrink(this.name, this.size, this.alcohol, this.consumed, this.user);

  ConsumedDrink.fromFirestore(Map<String, dynamic> firestoreData)
    : name = firestoreData['name'],
      size = firestoreData['size'],
      alcohol = firestoreData['alcohol'],
      consumed = (firestoreData['consumed'] as Timestamp).toDate(),
      user = firestoreData['user'];
}
