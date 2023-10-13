import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AnimeCharacterSearch extends StatefulWidget {
  const AnimeCharacterSearch({Key? key});

  @override
  State<AnimeCharacterSearch> createState() => _AnimeCharacterSearchState();
}

class _AnimeCharacterSearchState extends State<AnimeCharacterSearch> {
  List<dynamic> characters = [];
  Map<String, dynamic> selectedCharacter = {};

  Future<void> fetchCharacters() async {
    final response =
        await http.get(Uri.parse('https://api.jikan.moe/v4/characters'));

    if (response.statusCode == 200) {
      setState(() {
        characters = convert.jsonDecode(response.body)['data'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void selectCharacter(Map<String, dynamic> character) {
    setState(() {
      selectedCharacter = character;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Color(0xFFA590A4)),
                  color: Color(0xFFAEA3B0),
                ),
                child: DropdownButton(
                  value:
                      selectedCharacter.isNotEmpty ? selectedCharacter : null,
                  dropdownColor: Color(0xFFAEA3B0),
                  items: characters
                      .map<DropdownMenuItem<Map<String, dynamic>>>(
                        (character) => DropdownMenuItem(
                          value: character,
                          child: Center(
                            child: Text(
                              character['name'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (character) {
                    selectCharacter(character!);
                  },
                  hint: const Text(
                    'Selecciona un personaje',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  underline: Container(),
                ),
              ),
              const SizedBox(height: 20),
              if (selectedCharacter.isNotEmpty)
                Card(
                  color: Color(0xFFA590A4),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Color(0xFFAEA3B0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedCharacter['name'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  selectedCharacter['about'],
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        right: -10,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: AnimeCharacterSearch()));
}
