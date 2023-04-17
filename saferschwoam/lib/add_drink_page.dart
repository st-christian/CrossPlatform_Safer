import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/services/drink_service.dart';

import 'models/drink.dart';

class AddDrinkPage extends StatefulWidget {
  @override
  State<AddDrinkPage> createState() => _AddDrinkPageState();
}

class _AddDrinkPageState extends State<AddDrinkPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Card(
              color: theme.colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Current alcohol level 2.5',
                  style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: 24.0),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: DrinkService().getDrinks(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot? drinkData = snapshot.data?.docs[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: ListTile(
                            leading: Icon(Icons.local_drink),
                            title: Text(drinkData?["name"]),
                            subtitle: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Menge:'),
                                    Text('${drinkData?["size"]} ml'),
                                  ],
                                ),
                                Slider(
                                  value: drinkData?["size"].toDouble(),
                                  min: 0,
                                  max: 1000,
                                  onChanged: (value) {
                                    // Handle slider value change
                                  },
                                ),
                                Text('Alcohol content: ${drinkData?["alcohol"]} %'),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add_circle_rounded),
                              color: theme.colorScheme.primary,
                              onPressed: () {
                                // Handle button press
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
