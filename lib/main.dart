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

  IconData seleccionarIconoAleatorio() {
    Random random = Random();
    List<IconData> iconos = [
      Icons.airplanemode_active,
      Icons.bus_alert,
      Icons.directions_boat_outlined,
    ];
    return iconos[random.nextInt(iconos.length)];
  }//Use lo mismo que para el titulo

  String seleccionarTituloAleatorio() {
    Random random = Random();
    return titulosPredefinidos[random.nextInt(titulosPredefinidos.length)];
  }//Esto es para que los titulos sean random, esto mismo voy hacer para los iconos

  List<Widget> _buildCardList(int count) {
    List<Widget> cards = [];

    for (int i = 1; i <= count; i++) {
      cards.add(
        Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Color.fromARGB(115, 209, 88, 138),
              child: Icon(
                seleccionarIconoAleatorio(),
                color: Color.fromARGB(255, 223, 5, 96),
              ),
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
  List<Widget> _buildCardList1(int count) {
  List<Widget> cards1 = [];

  for (int i = 1; i <= count; i++) {
    cards1.add(
      Card(
        color: Colors.transparent, // Establece el color del Card a transparente
        elevation: 0, // Ajusta la elevación a 0 para que no haya sombra
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Ajusta el radio de borde según tus preferencias
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.green], // Cambia los colores según tus preferencias
            ),
            borderRadius: BorderRadius.all(Radius.circular(15.0)), // Asegura que el borde coincida con el del Card
          ),
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Title',
                    textAlign: TextAlign.start,
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -120),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/kaguyita.jpg'),
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'hola Lorem Ipsum is simply dummy \n text of the printing and typesetting \n industry. Lorem Ipsum has been the industrys\n standard dummy text ever since the 1500s,\n when an unknown printer took a galley of type',
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow),
                    Text(
                      'Date: 20/23',
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  return cards1;
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
                children: _buildCardList(5),
              ),
              ListView(
                children: _buildCardList1(5),
              ),
            ],
          ),
        ),
      );
}
