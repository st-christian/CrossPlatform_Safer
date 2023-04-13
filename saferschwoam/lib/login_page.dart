import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _selectedGender = 'Female';
  double _age = 20.0;
  double _weight = 70.0;
  double _height = 170.0;


  @override
  Widget build(BuildContext context) {
       final theme = Theme.of(context);
    return Scaffold(
       backgroundColor: Colors.white,
       
      body: SingleChildScrollView(
        child: Center(
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
                      SizedBox(
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
                      SizedBox(
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
                      SizedBox(
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
                  SizedBox(height: 1.0),
                  Row(
                     mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Gender: ',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(width: 1.0),
                      Container(
                        decoration: BoxDecoration(color: Colors.white ),
                        child: DropdownButton<String>(
                          value: _selectedGender,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedGender = newValue!;
                            });
                          },
                          items: <String>['Female','Male',]
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
      ),
          
        
      
    );
  }
}