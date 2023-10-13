import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import './AnimeReviews.dart';
import './AnimeGenres.dart';
import 'AnimeCharacterSearch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Api Demo',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 223, 5, 96),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'API PRACTICE - JIKA API REST'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
            ],
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(text: 'Anime Character Search'),
                Tab(text: 'Anime Genres List'),
                Tab(text: 'Anime Reviews'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              AnimeCharacterSearch(),
              AnimeListByGenre(),
              AnimeReviews(),
            ],
          ),
        ),
      );
}
