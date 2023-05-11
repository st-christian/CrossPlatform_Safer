import 'package:flutter/material.dart';
import 'package:namer_app/services/drink_service.dart';
import 'package:namer_app/widgets/add_drink_card.dart';

import 'models/drink.dart';

class AddDrinkPage extends StatefulWidget {
  @override
  State<AddDrinkPage> createState() => _AddDrinkPageState();
}

class _AddDrinkPageState extends State<AddDrinkPage> {
  List<bool> isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
                Text('Oans Schwoam',
                          style: TextStyle(fontSize: 28,fontWeight:FontWeight.bold,  color: theme.primaryColor),),
                           Divider(thickness: 1,),
            Expanded(
              child: StreamBuilder<List<Drink>>(
                stream: DrinkService().getDrinks(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AddDrinkCard(drink: snapshot.data![index]);
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
