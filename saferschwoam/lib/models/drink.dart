class Drink {
  final String name;
  final num size;
  final num alcohol;

  Drink(this.name, this.size, this.alcohol);

  Drink.fromFirestore(Map<String, dynamic> firestoreData)
    : name = firestoreData['name'],
      size = firestoreData['size'],
      alcohol = firestoreData['alcohol'];
}
