import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:project_tpm/views/book_search_view.dart';
import 'detailbuku.dart';

class AwalMenu extends StatefulWidget {
  @override
  _AwalMenuState createState() => _AwalMenuState();
}

class _AwalMenuState extends State<AwalMenu> {
  late Future<List<dynamic>> books;
  String selectedTimezone = 'WIB';
  String currentTime = '';


  @override
  void initState() {
    super.initState();
    books = fetchBooks();
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

  Future<List<dynamic>> fetchBooks() async {
    final response = await http.get(
        Uri.parse('https://www.googleapis.com/books/v1/volumes?q=osamu'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['items'];
    } else {
      throw Exception('Failed to load books');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[800],
        title: Text('Serba Rp50.000,-'),
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
          IconButton(
            icon: const Icon(
              Icons.search_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookSearch(),
                  ));
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: books,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final bookList = snapshot.data!;

            return GridView.builder(
              padding: EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: bookList.length,
              itemBuilder: (context, index) {
                final book = bookList[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(bookId: book['id']),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: book['volumeInfo']['imageLinks'] != null
                              ? Image.network(
                            book['volumeInfo']['imageLinks']['thumbnail'],
                            fit: BoxFit.cover,
                          )
                              : Container(
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            book['volumeInfo']['title'],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load books'),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}