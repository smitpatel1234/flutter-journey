import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../models/book.dart';

class BookReaderScreen extends StatelessWidget {
  final Book book;

  BookReaderScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: Column(
        children: [
          Image.network(book.imageUrl, width: 200, height: 200),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              book.description,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(child: PDFView(filePath: book.pdfUrl)),
        ],
      ),
    );
  }
}
