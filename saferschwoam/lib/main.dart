import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: MyHomePage(),
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
        /*  body: Row(
            children: [
            SafeArea(
              child: NavigationRail(
              extended: constraints.maxWidth >= 600,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text("Home"),
                  ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text("Favourties"),
                  ),          
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                },
                );
              },
            ),
            ),
            Expanded(
              child : Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
                ),
            ),
          ],)*/

        );
      }
    );
  }
}


class AddDrinkPage extends StatelessWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(
                    'https://picsum.photos/250?image=9'), // Replace with your profile image
              ),
              SizedBox(height: 20.0),
              Text(
                'Age: ${_age.toInt()}',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                width: 200,
                child: Slider(
                  value: _age,
                  min: 16,
                  max: 100.0,
                  onChanged: (newValue) {
                    setState(() {
                      _age = newValue;
                    });
                  },
                ),
              ),
              Text(
                'Weight: ${_weight.toInt()} kg',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                width: 200,
                child: Slider(
                  value: _weight,
                  min: 0,
                  max: 150.0,
                  onChanged: (newValue) {
                    setState(() {
                      _weight = newValue;
                    });
                  },
                ),
              ),
              Text(
                'Height: ${_height.toInt()} cm',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                width: 200,
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
              SizedBox(height: 20.0),
              DropdownButton<String>(
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
            ],
          ),
        ),
      ),
    );
  }
}