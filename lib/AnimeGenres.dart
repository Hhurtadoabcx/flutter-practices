import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AnimeListByGenre extends StatefulWidget {
  @override
  _AnimeListByGenreState createState() => _AnimeListByGenreState();
}

class _AnimeListByGenreState extends State<AnimeListByGenre> {
  List<Map<String, dynamic>> genres = [];

  Future<void> fetchAnimeByGenre() async {
    final response =
        await http.get(Uri.parse('https://api.jikan.moe/v4/genres/anime'));

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      final genreData = data['data'];

      setState(() {
        genres = List.from(genreData);
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
                  return ListTile(
                    title: Text(genres[index]['name']),
                    onTap: () {
                      // Aquí puedes navegar a una nueva pantalla para mostrar los animes por género
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnimeListScreen(
                            genreId: genres[index]['mal_id'],
                            genreName: genres[index]['name'],
                          ),
                        ),
                      );
                    },
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
  List<Map<String, dynamic>> animeList = [];

  Future<void> fetchAnimeListByGenre(int genreId) async {
    final response = await http
        .get(Uri.parse('https://api.jikan.moe/v4/genres/anime/$genreId'));

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      final animeData = data['data'];

      setState(() {
        animeList = List.from(animeData);
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
                    title: Text(animeList[index]['name']),
                  );
                },
              ),
      ),
    );
  }
}
