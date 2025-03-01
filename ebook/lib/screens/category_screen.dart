import 'package:flutter/material.dart';
import 'book_list_screen.dart';

class CategoryScreen extends StatelessWidget {
  final List<String> categories = [
    'Fiction',
    'Non-Fiction',
    'Sci-Fi',
    'Fantasy',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Categories')),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index]),
            leading: Icon(Icons.book, color: Colors.blueAccent),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => BookListScreen(category: categories[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
