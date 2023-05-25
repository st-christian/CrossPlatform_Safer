import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'my-globals.dart' as globals;


class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _selectedGender = globals.gender;
  double _age = globals.age;
  double _weight = globals.weight;
  double _height = globals.height;

 @override
  void initState() {
    super.initState();
    _getSharedPrefAge();
    _getSharedPrefWeight();
    _getSharedPrefHeight();
    _getSharedPrefGender();
  }

Future<void> _setSharedPref(String  sharePref, double value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setDouble(sharePref, value);
    });
  }

  Future<void> _setSharedPrefGender(String value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('gender', value);
    });
  }

  Future<void> _getSharedPrefAge() async {
    final prefs = await SharedPreferences.getInstance(); 
     setState(() {
      _age = (prefs.getDouble('age') ?? 25);
    });
  }

      Future<void> _getSharedPrefWeight() async {
    final prefs = await SharedPreferences.getInstance(); 
     setState(() {
      _weight = (prefs.getDouble('weight') ?? 80);
    });
      }

      Future<void> _getSharedPrefHeight() async {
    final prefs = await SharedPreferences.getInstance(); 
     setState(() {
      _height = (prefs.getDouble('height') ?? 170);
    });
  }

   Future<void> _getSharedPrefGender() async {
    final prefs = await SharedPreferences.getInstance(); 
     setState(() {
      _selectedGender = (prefs.getString('gender') ?? 'Male');
    });
  }

  @override
  Widget build(BuildContext context) {
       final theme = Theme.of(context);
    return Scaffold(
       resizeToAvoidBottomInset: false,
       backgroundColor: Colors.white,
       
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[  
                    SizedBox(height: 30,),
                Text('Schwoam Profil',
                          style: TextStyle(fontSize: 28,fontWeight:FontWeight.bold,  color: theme.primaryColor),),
                           Divider(thickness: 1,),
                  SizedBox(height: 20.0),
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
                        SizedBox(
                          width: 200.0,
                          child: Slider(
                            value: _age,
                            min: 0.0,
                            max: 100.0,
                            onChanged: (newValue) {
                              setState(() {
                                _setSharedPref('age', newValue);
                                globals.age = newValue;
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
                        SizedBox(
                          width: 200.0,
                          child: Slider(
                            value: _weight,
                            min: 0.0,
                            max: 150.0,
                            onChanged: (newValue) {
                              setState(() {
                                 globals.weight = newValue;
                                  _setSharedPref('weight', newValue);
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
                        SizedBox(
                          width: 200.0,
                          child: Slider(
                            value: _height,
                            min: 0.0,
                            max: 250.0,
                            onChanged: (newValue) {
                              setState(() {
                                  _setSharedPref('height', newValue);
                                 globals.height = newValue;
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
                    SizedBox(height: 10.0),
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
                                 _setSharedPrefGender(newValue!);
                                 globals.gender = newValue!;
                                _selectedGender = newValue!;
                              });
                            },
                            items: <String>['Female','Male', 'Diverse']
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
                    SizedBox(height: 30.0),
                    SizedBox(
                      height: 85,
                      child: Card(
                        color: Color.fromARGB(255, 0, 0, 0),
                                   // margin: EdgeInsets.all(8.0),
                                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Excessive use of alcohol is harmful to health.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color.fromARGB(255, 255, 82, 82) ,fontSize: 18.0),
                      ),
                                    ),
                                  ),
                    ),           
                  ],
                ),
          ),
        ),
      ),
          
        
      
    );
  }
}




