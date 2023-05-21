import 'package:flutter/material.dart';

class detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.green[800],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('image/foto.jpeg'), // Replace with your own image path
            ),
            SizedBox(height: 16),
            Text(
              'Edwinpras Wijaya',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '123200074',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'IF - A',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Kesan Pesan :',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 4),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Text(
              'Mata kuliah ini sangat asik, jujur saya agak lemah pada mata kuliah ini, tapi saya belajar banyak dari sini',
              style: TextStyle(fontSize: 14), textAlign: TextAlign.center,
            ),
        ),
          ],
        ),
      ),
    );
  }
}