import 'package:flutter/material.dart';




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




