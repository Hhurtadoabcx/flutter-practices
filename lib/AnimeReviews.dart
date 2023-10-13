import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AnimeReviews extends StatefulWidget {
  @override
  _AnimeReviewsState createState() => _AnimeReviewsState();
}

class _AnimeReviewsState extends State<AnimeReviews> {
  List<Map<String, dynamic>> reviews = [];

  Future<void> fetchAnimeReviews() async {
    final response =
        await http.get(Uri.parse('https://api.jikan.moe/v4/reviews/anime'));

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);

      setState(() {
        reviews = List.from(data['data']);
      });
    } else {
      throw Exception('Failed to load Anime Reviews');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAnimeReviews();
  }

  Widget _buildStarRating(int score) {
    List<Icon> stars = [];
    for (int i = 0; i < 5; i++) {
      if (i < score) {
        stars.add(Icon(Icons.star, color: Colors.amber));
      } else {
        stars.add(Icon(Icons.star_border, color: Colors.amber));
      }
    }
    return Row(children: stars);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return Card(
            color: Color(0xFFA590A4),
            margin: EdgeInsets.all(8),
            child: Card(
              color: Color(0xFFAEA3B0),
              elevation: 4,
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Anime: ${review['entry']['title']}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Score:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    _buildStarRating(review['score']),
                    SizedBox(height: 8),
                    Text(
                      'Review:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(review['review']),
                    SizedBox(height: 8),
                    Text(
                      'User:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(review['user']['username']),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
