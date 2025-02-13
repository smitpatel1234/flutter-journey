import 'dart:async';
import 'dart:io';

class Book {
  int _bookId;
  String _title;
  String _author;
  int _yearPublished;
  bool _isAvailable;

  Book(this._bookId, this._title, this._author, this._yearPublished, this._isAvailable);

  // Getters and Setters
  int get bookId => _bookId;
  set bookId(int id) => _bookId = id;

  String get title => _title;
  set title(String newTitle) => _title = newTitle;

  String get author => _author;
  set author(String newAuthor) => _author = newAuthor;

  int get yearPublished => _yearPublished;
  set yearPublished(int year) => _yearPublished = year;

  bool get isAvailable => _isAvailable;
  set isAvailable(bool availability) => _isAvailable = availability;

  // Method to display details
  void displayDetails() {
    print('Book ID: $_bookId');
    print('Title: $_title');
    print('Author: $_author');
    print('Year Published: $_yearPublished');
    print('Available: ${_isAvailable ? "Yes" : "No"}\n');
  }
}

class EBook extends Book {
  double _fileSize;

  EBook(super.bookId, super.title, super.author, super.yearPublished, super.isAvailable, this._fileSize);

  double get fileSize => _fileSize;
  set fileSize(double size) => _fileSize = size;

  @override
  void displayDetails() {
    super.displayDetails();
    print('File Size: ${_fileSize}MB\n');
  }
}

abstract class User {
  void displayUserType();
}

class Member extends User {
  @override
  void displayUserType() {
    print("User Type: Member");
  }
}

class Library {
  final List<Book> _books = [];
  static int _totalBooks = 0;

  Library() {
    // Predefined books
    _books.add(Book(1, "Dart Basics", "John Doe", 2020, true));
    _books.add(Book(2, "Flutter Advanced", "Jane Smith", 2021, true));
    _books.add(EBook(3, "Async Programming", "Alex Brown", 2022, true, 1.5));
    _totalBooks = _books.length;
  }

  // Getters
  List<Book> get books => _books;

  static int get totalBooks => _totalBooks;

  // Methods
  void addBook(Book book) {
    _books.add(book);
    _totalBooks++;
    print("Book added successfully!\n");
  }

  void borrowBook(int bookId) {
    try {
      var book = _books.firstWhere((b) => b.bookId == bookId);
      if (book.isAvailable) {
        book.isAvailable = false;
        print("You borrowed '${book.title}'\n");
      } else {
        throw Exception("Book is currently unavailable!");
      }
    } catch (e) {
      print("Error: $e\n");
    }
  }

  void returnBook(int bookId) {
    try {
      var book = _books.firstWhere((b) => b.bookId == bookId);
      if (!book.isAvailable) {
        book.isAvailable = true;
        print("You returned '${book.title}'\n");
      } else {
        throw Exception("Book was not borrowed!");
      }
    } catch (e) {
      print("Error: $e\n");
    }
  }

  Future<void> listBooks() async {
    print("Fetching book list...");
    await Future.delayed(Duration(seconds: 2));
    print("\n--- Book List ---");
    for (var book in _books) {
      book.displayDetails();
    }
  }

  static void displayTotalBooks() {
    print("Total books in the library: $_totalBooks\n");
  }
}

void main() async {
  Library library = Library();

  while (true) {
    print("=== Library Menu ===");
    print("1. Add a Book");
    print("2. Borrow a Book");
    print("3. Return a Book");
    print("4. List All Books");
    print("5. Display Total Books");
    print("6. Exit");
    print("====================");
    stdout.write("Enter your choice: ");
    int choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        stdout.write("Enter Book ID: ");
        int id = int.parse(stdin.readLineSync()!);
        stdout.write("Enter Title: ");
        String title = stdin.readLineSync()!;
        stdout.write("Enter Author: ");
        String author = stdin.readLineSync()!;
        stdout.write("Enter Year Published: ");
        int year = int.parse(stdin.readLineSync()!);
        stdout.write("Enter File Size (Enter 0 for physical books): ");
        double fileSize = double.parse(stdin.readLineSync()!);

        if (fileSize > 0) {
          library.addBook(EBook(id, title, author, year, true, fileSize));
        } else {
          library.addBook(Book(id, title, author, year, true));
        }
        break;
      case 2:
        stdout.write("Enter Book ID to borrow: ");
        int bookId = int.parse(stdin.readLineSync()!);
        library.borrowBook(bookId);
        break;
      case 3:
        stdout.write("Enter Book ID to return: ");
        int bookId = int.parse(stdin.readLineSync()!);
        library.returnBook(bookId);
        break;
      case 4:
        await library.listBooks();
        break;
      case 5:
        Library.displayTotalBooks();
        break;
      case 6:
        print("Exiting system. Goodbye!");
        return;
      default:
        print("Invalid choice! Please try again.\n");
    }
  }
}
