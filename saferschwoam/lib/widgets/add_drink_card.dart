import 'package:flutter/material.dart';

class AddDrinkCard extends StatefulWidget {
  final String drinkName;
  final int alcoholContent;
  final int size;

  AddDrinkCard({
    Key? key,
    required this.drinkName,
    required this.alcoholContent,
    required this.size,
  }) : super(key: key);

  @override
  State<AddDrinkCard> createState() => _AddDrinkCardState();
}

class _AddDrinkCardState extends State<AddDrinkCard> {
  List<bool> isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(Icons.wine_bar_rounded),
        title: Text(widget.drinkName,
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
                Text('${widget.alcoholContent} ‰'),
              ],
            ),
            SizedBox(height: 10,),
            ToggleButtons(isSelected: isSelected,
                renderBorder: true,
                borderWidth: 1.5,
                borderRadius: BorderRadius.circular(10),
                onPressed: (int newIndex) {
                  setState(() {
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
                const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('300 ml'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('500 ml'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('1000 ml'),
                  ),
                ]
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.add_circle_rounded),
          iconSize: 38.0,
          color: theme.colorScheme.primary,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'Added ${widget.drinkName} to your drink list.'),
                duration: Duration(seconds: 3),
              ),
            );
            // Handle button press
          },
        ),
      ),
    );
  }

}
