import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_tpm/login.dart';

import 'detail.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  String selectedTimezone = 'WIB';
  String currentTime = '';

  @override
  void initState() {
    super.initState();
    startClock();
  }

  void startClock() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        currentTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now().toUtc());
      });
    });
  }

  String convertToTimezone(String timezone) {
    DateTime now = DateTime.now().toUtc();
    switch (timezone) {
      case 'WIB':
        now = now.add(Duration(hours: 7));
        break;
      case 'WIT':
        now = now.add(Duration(hours: 9));
        break;
      case 'WITA':
        now = now.add(Duration(hours: 8));
        break;
    }
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          title: Text('PROFILE'),
          centerTitle: true,
          backgroundColor: Colors.green[800],
          actions: <Widget>[
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 10, 0), //apply padding to LTRB, L:Left, T:Top, R:Right, B:Bottom
              child: Text(
                selectedTimezone == 'UTC' ? currentTime : convertToTimezone(selectedTimezone),
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            DropdownButton<String>(
              value: selectedTimezone,
              onChanged: (String? newValue) {
                setState(() {
                  selectedTimezone = newValue!;
                });
              },
              items: <String>['WIB', 'WITA', 'WIT', 'UTC'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,)),
                );
              }).toList(),
            ),
            IconButton(onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context){
                    return loginpage(title:'Login');
                  })
              );
            }, icon: Icon(Icons.logout)
            )
          ]
      ) ,
      body:  ListView(
          padding:
          const EdgeInsets.all(8),
          children: [
            SizedBox(height: 30.0),
            SizedBox(height: 20.0),
            Container(
              height: 500,
              child:
              Card(
                margin: EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.green,
                          offset: Offset(0, 1),
                          blurRadius: 2.0)
                    ]
                  ),
                  child: InkWell(

                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ClipOval(
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(100),
                              child: CircleAvatar(backgroundImage: AssetImage('image/foto.jpeg')),
                            ),
                          ),

                          SizedBox(height: 20.0),
                          Text("Edwinpras Wijaya", textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Colors.green[800])),
                          Text("123200074", textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Colors.green[800])),
                          SizedBox(height: 20.0),
                          Container(
                            width: MediaQuery.of(context).size.width/4,
                            height: MediaQuery.of(context).size.height/12,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green[800]
                              ),
                              onPressed:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return detail();
                              }));
                            }, child: Text('Detail') ,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),

    );
  }
}
