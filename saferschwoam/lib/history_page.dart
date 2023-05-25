import 'package:flutter/material.dart';
import 'package:namer_app/services/calculationservice.dart';
import 'package:namer_app/services/history_service.dart';

import 'models/consumeddrink.dart';
import '../my-globals.dart' as globals;

class HistoryPage extends StatefulWidget {
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final HistoryService historyService = HistoryService();
  final CalculationService calculationService = CalculationService();
  

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
   // historyService.clearHistory();

     double bac;
     //   print("BAC: $bac"); // print the BAC to the console
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text('Schwoab History ',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor)),
            Divider(
              thickness: 1,
            ),
            Text('Date: ' + globals.sessionDate.toString(),
                          style: TextStyle(fontSize: 12,fontWeight:FontWeight.bold,  color: theme.primaryColor),),
            Expanded(
              child: StreamBuilder<List<ConsumedDrink>>(
                stream: historyService.getHistory(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(
                      child: Text('Error fetching data'),
                    );
                  }

                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else{
                        
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        final drink = snapshot.data![index];
                        return Card(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: ListTile(
                            leading: Icon(Icons.local_drink),
                            title: Text(drink.name),
                            subtitle: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        'Alcohol content: ${drink.alcohol} ‰'),
                                    Text('${drink.size} ml'),
                                    
                                  ],
                                ),
                                Text('Consumed on: ${drink.consumed}'),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                },
              ),
              
            ),
             ElevatedButton(
          child: const Text('Clear History'),
          onPressed: () {
            final scaffoldMessenger = ScaffoldMessenger.of(context);
             scaffoldMessenger.showSnackBar(
            SnackBar(
                content: Text('History Cleared.'),
                duration: Duration(seconds: 3),
              )
             );
            historyService.clearHistory();
          globals.bacRound = 0;
          globals.flList.clear();},
        ),

          ],
        ),
      ),
    );
  }
}
