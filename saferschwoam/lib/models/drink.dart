class Drink {
  final String name;
  final num size;
  final num size_m;
  final num size_l;
  final num alcohol;
  final num id;

  Drink(this.name, this.size, this.alcohol, this.id, this.size_m,  this.size_l);

  Drink.fromFirestore(Map<String, dynamic> firestoreData)
    : name = firestoreData['name'],
      size = firestoreData['size'],
      size_m = firestoreData['size_m'],
      size_l = firestoreData['size_l'],
      alcohol = firestoreData['alcohol'],
      id = firestoreData['id'];
}
