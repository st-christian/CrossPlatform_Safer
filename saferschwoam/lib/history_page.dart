
import 'package:flutter/material.dart';


class HistoryPage extends StatefulWidget {
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
    // Dummy data for the ListView
   List<Map<String, dynamic>> _listData = [
    {'name': 'Bier', 'icon': Icons.local_drink, 'value': 700, 'alcohol' : 5},
    {'name': 'Wein', 'icon': Icons.local_drink, 'value': 500,'alcohol' : 10},
     {'name': 'Spritzer', 'icon': Icons.local_drink, 'value': 125, 'alcohol' : 7},
    {'name': 'Mojito', 'icon': Icons.local_drink, 'value': 500, 'alcohol' : 14},
   ];

   List<Map<String, dynamic>> _listDataTwo = [
     {'name': 'Spritzer', 'icon': Icons.local_drink, 'value': 125, 'alcohol' : 7},
    {'name': 'Mojito', 'icon': Icons.local_drink, 'value': 500, 'alcohol' : 14},
    {'name': 'Bier', 'icon': Icons.local_drink, 'value': 700, 'alcohol' : 5},
   ];
  @override
  Widget build(BuildContext context) {

  final theme = Theme.of(context);
    return Scaffold(
   body: SafeArea(
     child: Column(
          children: <Widget>[
   
           SizedBox(height: 30,),
                Text('Schwoab History ',
                          style: TextStyle(fontSize: 28,fontWeight:FontWeight.bold,  color: theme.primaryColor),),
                           Divider(thickness: 1,),
            Text("Session: 15/04/2023"),
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
                            Text('Alcohol content: ${_listData[index]['alcohol']} ‰'),
                            Text('${_listData[index]['value']} ml'), // Placeholder for the slider value
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                );
              },
            ),
            ),
            Divider(thickness: 1,),
            Text("Session: 13/04/2023"),
            Expanded(
            child : ListView.builder(
              itemCount: _listDataTwo.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                  leading: Icon(_listDataTwo[index]['icon']),
                  title: Text(_listDataTwo[index]['name']),
                  subtitle: Column(
                      children: [                
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('alcohol content: ${_listData[index]['alcohol']} ‰'),
                            Text('${_listData[index]['value']} ml'), // Placeholder for the slider value
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                );
              },
            ),
            ),
            
            SizedBox(
                    width: 120,
                    height: 50,
                    child: ElevatedButton(
                       style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(theme.colorScheme.primary)),
                      child: Text('New Session', style: TextStyle(fontSize: 12, color: theme.colorScheme.onPrimary),),
                      onPressed: () {                    
                      },
                          ),
                  ),
          ],
        ),
   ),
    );
  }
}

  /*  var appState = context.watch<MyAppState>();

    if(appState.favorites.isEmpty){
      return Center(child: Text('No Favorites yet.'),
      );
    }
    return ListView(
children: [
  Padding(padding: const EdgeInsets.all(20),
  child: Text('You have ' '${appState.favorites.length} favorites:' ),
  ),
  for(var pair in appState.favorites)
  ListTile(
    leading: Icon(Icons.favorite),
    title: Text(pair.asLowerCase),
  )
],
    );
  }
}*/