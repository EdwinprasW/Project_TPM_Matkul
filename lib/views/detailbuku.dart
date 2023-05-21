import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_tpm/homepage.dart';
import 'package:project_tpm/views/book_catalog_view.dart';
import 'package:project_tpm/views/menuawal.dart';





class DetailPage extends StatefulWidget {
  final String bookId;



  DetailPage({required this.bookId});


  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<Map<String, dynamic>> bookDetails;
  double amount = 0;
  bool ready = false;
  String selectedCurrency = 'USD';
  Map<String, double> exchangeRates = {
    'IDR': 1.0,
    'EUR': 16000,
    'USD': 15000,
    'JPY': 108,
  };
  late String result;

  double convertCurrency() {
    return amount * 50000 / exchangeRates[selectedCurrency]!;
  }

  String harga(){
    if(selectedCurrency == 'IDR'){
      if(convertCurrency() == 0){
        ready = false;
        return result = 'Rp' + (convertCurrency().toStringAsFixed(2));
      }else{
        ready = true;
        return result = 'Rp' + (convertCurrency().toStringAsFixed(2));
      }
    }else if(selectedCurrency == 'EUR'){
      if(convertCurrency() == 0){
        ready = false;
        return result = '€' + (convertCurrency().toStringAsFixed(2));
      }else{
        ready = true;
        return result = '€' + (convertCurrency().toStringAsFixed(2));
      }

    }else if(selectedCurrency == 'USD'){
      if(convertCurrency() == 0){
        ready = false;
        return result = 'USD' + (convertCurrency().toStringAsFixed(2));
      }else{
        ready = true;
        return result = 'USD' + (convertCurrency().toStringAsFixed(2));
      }
  }else{
      if(convertCurrency() == 0){
        ready = false;
        return result = '¥' + (convertCurrency().toStringAsFixed(2));
      }else{
        ready = true;
        return result = '¥' + (convertCurrency().toStringAsFixed(2));
      }
    }
  }



  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(
        r"<[^>]*>",
        multiLine: true,
        caseSensitive: true
    );

    return htmlText.replaceAll(exp, '');
  }


  late double price;
  @override
  void initState() {
    super.initState();
    bookDetails = fetchBookDetails();
  }

  Future<Map<String, dynamic>> fetchBookDetails() async {
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes/${widget.bookId}'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load book details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[800],
        title: Text("Detail Buku"),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: bookDetails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final book = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (book['volumeInfo']?['imageLinks']?['thumbnail'] != null)
                      Image.network(
                          book['volumeInfo']!['imageLinks']!['thumbnail'],
                          height: 200,
                        ),

                    SizedBox(height: 16),
                    Text(
                      book['volumeInfo']?['title'] ?? '',textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Authors: ${book['volumeInfo']?['authors']?.join(', ') ?? ''}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Description: ' + removeAllHtmlTags(book['volumeInfo']?['description'] ?? ''),textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Publisher: ${book['volumeInfo']['publisher']}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Published Date: ${book['volumeInfo']['publishedDate']}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        double inputAmount = double.tryParse(value) ?? 0;
                        setState(() {
                          amount =  inputAmount;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Amount',
                      ),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedCurrency,
                      items: exchangeRates.keys
                          .map<DropdownMenuItem<String>>(
                            (String currency) => DropdownMenuItem<String>(
                          value: currency,
                          child: Text(currency),
                        ),
                      )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCurrency = value!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Currency',
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Converted Amount: ' + harga(),
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    AnimatedButton(
                      text: "Checkout",
                        color: Colors.green,
                        pressEvent: (){
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.info,
                          animType: AnimType.topSlide,
                          showCloseIcon: true,
                          title: "Hold up!",
                          desc: "Are you sure you want to checkout?",
                          btnCancelOnPress: (){},
                          btnOkOnPress: (){
                            if(ready == true) {
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.topSlide,
                                  showCloseIcon: false,
                                  title: "Thank you!",
                                  desc: "Checkout Success!",
                                  btnOkOnPress: () {
                                    Navigator.of(context).pop(
                                        MaterialPageRoute(builder: (context) {
                                          return Homepage();
                                        })
                                    );
                                  }

                              ).show();
                            }else{
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.topSlide,
                                  showCloseIcon: false,
                                  title: "Can't Checkout!",
                                  desc: "There's No Item",
                                  btnCancelOnPress: () {}
                              ).show();

                            }
                          },
                        ).show();
                        }
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load book details'),
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