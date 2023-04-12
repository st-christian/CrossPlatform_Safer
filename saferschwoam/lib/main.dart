import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white10),
        ),
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
        '/MainHomePage': (BuildContext context) => MyHomePage(),
       '/LoginPage': (BuildContext context) => LoginPage(),
      },
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

   void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

var favorites = <WordPair>[];

void toggleFavorites(){
  if(favorites.contains(current)){
    favorites.remove(current);
  }else{
    favorites.add(current);
  }
  notifyListeners();
}

}

class MyHomePage extends StatefulWidget{
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var selectedIndex = 0;


  @override
  Widget build(BuildContext context){
    
    Widget page;
    switch (selectedIndex){
      case 0:
      page = AddDrinkPage();
      break;
      case 1:
      page = HistoryPage();
      break;
      case 2:
      page = ProfilePage();
      break;
      default: 
      throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
             /*   appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),*/ body: Center(
        child: page,
      ),
        bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_drink_rounded),
            label: 'Oans Schwoam',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_rounded),
            label: 'Schwoblisten',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Schwoaba Info',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 0, 75, 112),
        onTap: (value) {
                setState(() {
                  selectedIndex = value;
                },
                );
              },
      ),
        );
      }
    );
  }
}


class OldAddDrinkPageREMOVEWHENDONE extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

 IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.primaryContainer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(pair: pair),
            SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFavorites();
                  },
                  label: Text("Like"),
                  icon: Icon(icon),
                ),
                 SizedBox(width: 10),
                 ElevatedButton(
                  onPressed: () {
                    appState.getNext();
                  },
                  child: Text('Next'),
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

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
  }

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(pair.asLowerCase,
        style: style,
        semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _selectedGender = 'Male';
  double _age = 20.0;
  double _weight = 70.0;
  double _height = 170.0;


  @override
  Widget build(BuildContext context) {
       final theme = Theme.of(context);
    return Scaffold(
       backgroundColor: Colors.white,
       
      body: Center(
        child: Column(
          children: <Widget>[  
                Card(
                  color: theme.colorScheme.primary,
             // margin: EdgeInsets.all(8.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Current alcohol level 2.5',
                  style: TextStyle(color: theme.colorScheme.onPrimary,fontSize: 24.0),
                ),
              ),
            ),           
              SizedBox(height: 60.0),
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(
                      'https://picsum.photos/250?image=64'), // Replace with your profile image
                ),
                SizedBox(height: 30.0),
                Row(
                   mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Age: ',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Container(
                      width: 200.0,
                      child: Slider(
                        value: _age,
                        min: 0.0,
                        max: 100.0,
                        onChanged: (newValue) {
                          setState(() {
                            _age = newValue;
                          });
                        },
                      ),
                    ),
                    Text(
                      '${_age.toInt()}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                Row(
                   mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Weight: ',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Container(
                      width: 200.0,
                      child: Slider(
                        value: _weight,
                        min: 0.0,
                        max: 150.0,
                        onChanged: (newValue) {
                          setState(() {
                            _weight = newValue;
                          });
                        },
                      ),
                    ),
                    Text(
                      '${_weight.toInt()} kg',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                Row(
                   mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Height: ',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Container(
                      width: 200.0,
                      child: Slider(
                        value: _height,
                        min: 0.0,
                        max: 250.0,
                        onChanged: (newValue) {
                          setState(() {
                            _height = newValue;
                          });
                        },
                      ),
                    ),
                    Text(
                      '${_height.toInt()} cm',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                   mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Gender: ',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(width: 10.0),
                    Container(
                      decoration: BoxDecoration(color: Colors.white ),
                      child: DropdownButton<String>(
                        value: _selectedGender,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedGender = newValue!;
                          });
                        },
                        items: <String>['Male', 'Female']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Card(
                  color: Color.fromARGB(255, 0, 0, 0),
             // margin: EdgeInsets.all(8.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Excessive use of alcohol is harmful to health.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color.fromARGB(255, 255, 82, 82) ,fontSize: 24.0),
                ),
              ),
            ),           
              ],
            ),
      ),
          
        
      
    );
  }
}



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

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('/LoginPage');
    });
  }

  @override
  Widget build(BuildContext context) {
        final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: Text(
          'Safer Schwoam',
          style: TextStyle(
            fontSize: 48.0,
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _selectedGender = 'Male';
  double _age = 20.0;
  double _weight = 70.0;
  double _height = 170.0;


  @override
  Widget build(BuildContext context) {
       final theme = Theme.of(context);
    return Scaffold(
       backgroundColor: Colors.white,
       
      body: Center(
        child: Column(
          children: <Widget>[             
              SizedBox(height: 60.0),
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(
                      'https://picsum.photos/250?image=64'), // Replace with your profile image
                ),
                SizedBox(height: 30.0),
                Row(
                   mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Age: ',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Container(
                      width: 200.0,
                      child: Slider(
                        value: _age,
                        min: 0.0,
                        max: 100.0,
                        onChanged: (newValue) {
                          setState(() {
                            _age = newValue;
                          });
                        },
                      ),
                    ),
                    Text(
                      '${_age.toInt()}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                Row(
                   mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Weight: ',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Container(
                      width: 200.0,
                      child: Slider(
                        value: _weight,
                        min: 0.0,
                        max: 150.0,
                        onChanged: (newValue) {
                          setState(() {
                            _weight = newValue;
                          });
                        },
                      ),
                    ),
                    Text(
                      '${_weight.toInt()} kg',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                Row(
                   mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Height: ',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Container(
                      width: 200.0,
                      child: Slider(
                        value: _height,
                        min: 0.0,
                        max: 250.0,
                        onChanged: (newValue) {
                          setState(() {
                            _height = newValue;
                          });
                        },
                      ),
                    ),
                    Text(
                      '${_height.toInt()} cm',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                   mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Gender: ',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(width: 10.0),
                    Container(
                      decoration: BoxDecoration(color: Colors.white ),
                      child: DropdownButton<String>(
                        value: _selectedGender,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedGender = newValue!;
                          });
                        },
                        items: <String>['Male', 'Female']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: 120,
                  height: 50,
                  child: ElevatedButton(
                     style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(theme.colorScheme.primary)),
                    child: Text('Start', style: TextStyle(fontSize: 24, color: theme.colorScheme.onPrimary),),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/MainHomePage');
                    },
                        ),
                ),
              ],
            ),
      ),
          
        
      
    );
  }
}