import 'package:flutter/material.dart';
import 'package:project_tpm/money.dart';
import 'package:project_tpm/profile.dart';
import 'package:project_tpm/views/book_catalog_view.dart';
import 'package:project_tpm/views/book_search_view.dart';
import 'package:project_tpm/views/menuawal.dart';
import 'kalender.dart';



class Homepage extends StatefulWidget {

  const Homepage({Key? key}) : super(key: key);
  @override
  State<Homepage> createState() => _HomepageState();
}
class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  static List<Widget> _option = <Widget>[
    const profile(), const MoneyThingy(),  AwalMenu(), const kalender(),
  ];

  void _onTap(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _option.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(

        onTap: _onTap,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.green[800],
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on_outlined),
            label: 'Konversi Uang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_add_check_outlined),
            label: 'Check Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Kalender',
          ),
        ],
        currentIndex: _selectedIndex,

      ),

    );
  }
}