import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 223, 5, 96),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Bookings'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> titulosPredefinidos = [
    'Hawaii ➔ Sevilla',
    'Sevilla ➔ Monaco',
    'Geneva ➔ Mexico City',
    'Atlanta ➔ Marrakech'
  ];

  String seleccionarTituloAleatorio() {
    Random random = Random();
    return titulosPredefinidos[random.nextInt(titulosPredefinidos.length)];
  }//Esto ea para que los titulos sean random, esto mismo voy hacer para los iconos

  List<Widget> _buildCardList(int count) {
    List<Widget> cards = [];

    for (int i = 1; i <= count; i++) {
      cards.add(
        Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Color.fromARGB(115, 209, 88, 138),
              child: Icon(Icons.airplanemode_active, color: Color.fromARGB(255, 223, 5, 96)),
            ),
            title: Text(seleccionarTituloAleatorio()),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('28 Oct. 2018 ----- 11:00AM'),
                Text('Emirates Airways'),
              ],
            ),
            trailing: Icon(Icons.more_vert),
          ),
        ),
      );
    }

    return cards;
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
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
                Tab(text: 'TRIPS'),
                Tab(text: 'HOTELS'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListView(
                children: _buildCardList(10),
              ),
              ListView(
                children: _buildCardList(10),
              ),
            ],
          ),
        ),
      );
}
