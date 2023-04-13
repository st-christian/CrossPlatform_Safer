import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_drink_page.dart';
import 'history_page.dart';
import 'login_page.dart';
import 'profile_page.dart';
import 'splash_screen.dart';

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
          '/LoginPage': (BuildContext context) => LoginPage(),
          '/MainHomePage': (BuildContext context) => MyHomePage(),
       
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


