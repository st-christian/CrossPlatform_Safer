import 'package:flutter/material.dart';

import '../models/drink.dart';
import '../services/history_service.dart';

class AddDrinkCard extends StatefulWidget {
  final Drink drink;

  AddDrinkCard({
    Key? key,
    required this.drink,
  }) : super(key: key);

  @override
  State<AddDrinkCard> createState() => _AddDrinkCardState();
}

class _AddDrinkCardState extends State<AddDrinkCard> {
  List<bool> isSelected = [true, false, false];
  int size =0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final HistoryService historyService = HistoryService();

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(Icons.wine_bar_rounded),
        title: Text(widget.drink.name,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Alcohol content:'),
                Text('${widget.drink.alcohol} ‰'),
              ],
            ),
            SizedBox(height: 10,),
            ToggleButtons(isSelected: isSelected,
                renderBorder: true,
                borderWidth: 1.5,
                borderRadius: BorderRadius.circular(8),
                onPressed: (int newIndex) {
                  setState(() {
                    size = newIndex;
                    for (int index = 0; index < isSelected.length; index++) {
                      if (index == newIndex) {
                        // one button is always set to true
                        isSelected[index] = true;
                        
                      } else {
                        // other two will be set to false and not selected
                        isSelected[index] = false;
                      }
                    }
                  });
                },
                children:
                 [
                  Padding(
                    
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Text('${widget.drink.size}ml'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Text('${widget.drink.size_m}ml'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Text('${widget.drink.size_l}ml'),
                  ),
                ]
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.add_circle_rounded),
          iconSize: 38.0,
          color: theme.colorScheme.primary,
          // Handle button press
          onPressed: () async {
          final scaffoldMessenger = ScaffoldMessenger.of(context);
          try {
            await historyService.addDrinkToHistory(widget.drink, size);
            scaffoldMessenger.showSnackBar(
              SnackBar(
                content: Text('Added ${widget.drink.name} to your drink list.'),
                duration: Duration(seconds: 3),
              ),
            );
          } catch (e) {
            scaffoldMessenger.showSnackBar(
              SnackBar(
                content: Text('Failed to add ${widget.drink.name} to your drink list.'),
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        ),
      ),
    );
  }

}
