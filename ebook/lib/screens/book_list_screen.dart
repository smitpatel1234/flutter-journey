import 'package:flutter/material.dart';
import 'book_reader_screen.dart';
import '../models/book.dart';

class BookListScreen extends StatelessWidget {
  final String category;
  BookListScreen({required this.category});

  final List<Book> books = [
    Book(
      title: 'Book A',
      imageUrl: 'https://via.placeholder.com/150',
      description: 'A thrilling adventure book.',
      pdfUrl: 'assets/bookA.pdf',
    ),
    Book(
      title: 'Book B',
      imageUrl: 'https://via.placeholder.com/150',
      description: 'A deep dive into science fiction.',
      pdfUrl: 'assets/bookB.pdf',
    ),
    Book(
      title: 'Book C',
      imageUrl: 'https://via.placeholder.com/150',
      description: 'A compelling non-fiction story.',
      pdfUrl: 'assets/bookC.pdf',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$category Books')),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Image.network(
                books[index].imageUrl,
                width: 50,
                height: 50,
              ),
              title: Text(books[index].title),
              subtitle: Text(books[index].description),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookReaderScreen(book: books[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
