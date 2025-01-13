import 'package:flutter/material.dart';
import 'movie_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OTT App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MovieListScreen(),
    );
  }
}

final List<Map<String, dynamic>> movies = [
  {
    'id': 1,
    'title': 'Inception',
    'description':
        'A thief with the ability to enter dreams takes on a final job.',
    'rating': 8.8,
    'image':
        'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQovCe0H45fWwAtV31ajOdXRPTxSsMQgPIQ3lcZX_mAW0jXV3kH',
    'video': 'https://www.youtube.com/watch?v=YoHD9XEInc0',
  },
  {
    'id': 2,
    'title': 'The Matrix',
    'description': 'A computer hacker learns about the true nature of reality.',
    'rating': 8.7,
    'image':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5DoFtShSmClflZ0RzBj9JBMweU5IUVBCeEbbLeV2XPlCnTKNi',
    'video': 'https://www.youtube.com/watch?v=vKQi3bBA1y8',
  },
  {
    'id': 3,
    'title': 'Interstellar',
    'description': 'A journey beyond the stars to save humanity.',
    'rating': 8.6,
    'image':
        'https://upload.wikimedia.org/wikipedia/en/b/bc/Interstellar_film_poster.jpg',
    'video': 'https://www.youtube.com/watch?v=zSWdZVtXT7E',
  },
];

class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  List<Map<String, dynamic>> filteredMovies = movies;

  void filterMovies(String query) {
    setState(() {
      filteredMovies = movies
          .where((movie) =>
              movie['title'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTT'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: filterMovies,
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                final movie = filteredMovies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(movie: movie),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(
                          movie['image'],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          movie['title'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
