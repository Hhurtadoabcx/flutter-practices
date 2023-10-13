import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Genre {
  final int id;
  final String name;
  final String url;
  final int count;
  final String? description;
  final String? image;

  Genre({
    required this.id,
    required this.name,
    required this.url,
    required this.count,
    this.description,
    this.image,
  });
}

class Anime {
  final int malId;
  final String name;
  final String? description;

  Anime({
    required this.malId,
    required this.name,
    this.description,
  });
}

class AnimeListByGenre extends StatefulWidget {
  @override
  _AnimeListByGenreState createState() => _AnimeListByGenreState();
}

class _AnimeListByGenreState extends State<AnimeListByGenre> {
  List<Genre> genres = [];

  Future<void> fetchAnimeByGenre() async {
    final response =
        await http.get(Uri.parse('https://api.jikan.moe/v4/genres/anime'));

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      final genreData = data['data'];

      setState(() {
        genres = List.from(genreData.map((genre) => Genre(
              id: genre['mal_id'],
              name: genre['name'],
              url: genre['url'],
              count: genre['count'],
              description: genre['description'],
              image: genre['image'],
            )));
      });
    } else {
      throw Exception('Failed to load anime by genre');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAnimeByGenre();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anime Genres List'),
      ),
      body: Center(
        child: genres.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: genres.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Card(
                        color: Color(0xFFA590A4),
                        child: ListTile(
                          title: Text(
                            genres[index].name,
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Descripción: ${genres[index].description ?? 'Descripción no disponible'}',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'ID: ${genres[index].id.toString()}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          leading: genres[index].image != null
                              ? Image.network(genres[index].image!)
                              : Icon(Icons.image_not_supported),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AnimeListScreen(
                                  genreId: genres[index].id,
                                  genreName: genres[index].name,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Card(
                          color: Color(0xFFAEA3B0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Animes: ${genres[index].count.toString()}',
                              style: TextStyle(
                                color: Color.fromARGB(255, 239, 239, 238),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}

class AnimeListScreen extends StatefulWidget {
  final int genreId;
  final String genreName;

  AnimeListScreen({required this.genreId, required this.genreName});

  @override
  _AnimeListScreenState createState() => _AnimeListScreenState();
}

class _AnimeListScreenState extends State<AnimeListScreen> {
  List<Anime> animeList = [];

  Future<void> fetchAnimeListByGenre(int genreId) async {
    final response = await http
        .get(Uri.parse('https://api.jikan.moe/v4/genres/anime/$genreId'));

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      final animeData = data['data'];

      setState(() {
        animeList = List.from(animeData.map((anime) => Anime(
              malId: anime['mal_id'],
              name: anime['name'],
              description: anime['description'],
            )));
      });
    } else {
      throw Exception('Failed to load anime list by genre');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAnimeListByGenre(widget.genreId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anime List - ${widget.genreName}'),
      ),
      body: Center(
        child: animeList.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: animeList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(animeList[index].name),
                    subtitle: Text(animeList[index].description ??
                        'Descripción no disponible'),
                  );
                },
              ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AnimeListByGenre(),
  ));
}
