import 'package:flutter/material.dart';


class AddDrinkPage extends StatefulWidget {
  @override
  _AddDrinkPageState createState() => _AddDrinkPageState();
}

class _AddDrinkPageState extends State<AddDrinkPage> {
  // Dummy data for the ListView
   List<Map<String, dynamic>> _listData = [
    {'name': 'Bier', 'icon': Icons.local_drink, 'value': 500, 'alcohol' : 5},
    {'name': 'Rusty Nail', 'icon': Icons.local_drink, 'value': 125,'alcohol' : 20},
    {'name': 'Wein', 'icon': Icons.local_drink, 'value': 125,'alcohol' : 10},
    {'name': 'Wasser', 'icon': Icons.local_drink, 'value': 500,'alcohol' : 0},
     {'name': 'Spritzer', 'icon': Icons.local_drink, 'value': 125, 'alcohol' : 7},
    {'name': 'Mojito', 'icon': Icons.local_drink, 'value': 500, 'alcohol' : 14},

    
  ];

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return Scaffold(
   body: Column(
        children: <Widget>[
          Card(
            color: theme.colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Current alcohol level 2.5',
                style: TextStyle(color: theme.colorScheme.onPrimary,fontSize: 24.0),
              ),
            ),
          ),
          Expanded(
          child : ListView.builder(
            itemCount: _listData.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                leading: Icon(_listData[index]['icon']),
                title: Text(_listData[index]['name']),
                subtitle: Column(
                    children: [                
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Menge:'),
                          Text('${_listData[index]['value']} ml'), // Placeholder for the slider value
                        ],
                      ),
                      Slider(
                        value: _listData[index]['value'],
                        min: 0,
                        max: 1000,
                        onChanged: (value) {
                          // Update the slider value
                          setState(() {
                            _listData[index]['value'] = value.toInt();
                          });
                        },
                      ),
                      Text('alcohol content: ${_listData[index]['alcohol']} %'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.add_circle_rounded),
                    color: theme.colorScheme.primary,
                    onPressed: () {
                      // Handle the button press
                    },
                  ),
                ),
              );
            },
          ),
          ),
        ],
      ),
    );
  }
}
