import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_tpm/views/detailbuku.dart';
import 'package:hive/hive.dart';
import 'package:project_tpm/controller/book_data.dart';
import 'package:project_tpm/models/books.dart';
import 'package:project_tpm/models/book_lib.dart';

import '../boxes.dart';

class BooksCatalog extends StatefulWidget {
  final String text;

  const BooksCatalog({Key? key, required this.text}) : super(key: key);


  @override
  _BooksCatalogState createState() => _BooksCatalogState();
}

class _BooksCatalogState extends State<BooksCatalog> {
  late String title;
  late String authors;
  late String imageLink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[800],
        title: Text("Catalog Buku"),
        actions: <Widget>[
        ],
      ),
      body: Container(
        // FutureBuilder() membentuk hasil Future dari request API
        child: FutureBuilder(
          future: BookDataSource.instance.loadBooks(widget.text),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError || widget.text.isEmpty) {
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
              Book book = Book.fromJson(snapshot.data);
              return _buildSuccessSection(book);
            }
            return _buildLoadingSection();
          },
        ),
      ),
    );
  }

  // Jika API sedang dipanggil
  Widget _buildLoadingSection() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorSection() {
    if (widget.text.isEmpty) {
      return const Text("Search bar cannot be Empty");
    } else {
      return const Text("Error");
    }
  }

  // Jika data ada
  Widget _buildSuccessSection(Book data) {
    return ListView.builder(
      itemCount: data.items?.length,
      itemBuilder: (BuildContext context, int index) {
        final book = data.items![index];
        if (book.volumeInfo == null ||
            book.volumeInfo!.imageLinks == null ||
            book.volumeInfo!.authors == null) {
          // Handle the case when any of the required properties is null
          return Container(); // Or any other appropriate fallback widget
        }

        // Access the properties safely
        final imageLink = book.volumeInfo!.imageLinks!.smallThumbnail!;
        final title = book.volumeInfo!.title!;
        final authors = book.volumeInfo!.authors!.join(", ");

        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(bookId: book.id!),
              ),
            );
          },
          leading: Image(
            image: NetworkImage(imageLink),
          ),
          title: Text(title),
          subtitle: Text(
            authors,
            style: TextStyle(fontSize: 11.0),
          ),
          isThreeLine: true,
        );
      },
    );
  }
}