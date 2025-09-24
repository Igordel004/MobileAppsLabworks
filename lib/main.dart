import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      ),
      home: const MyHomePage(title: 'Pocemons'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const MyWidget(),
    );
  }
}

class _CardData {
  final String text;
  final String descriptionText;
  final IconData icon;
  final String? imageUrl;

  _CardData(
    this.text, {
    required this.descriptionText,
    this.icon = Icons.ac_unit_outlined,
    this.imageUrl,
  });
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      _CardData(
        'Бульбазавр',
        descriptionText:
            'Крепкий покемон травяного и ядовитого типа. У него на спине растёт луковица, которая постепенно становится больше и сильнее.',
        icon: Icons.local_florist,
        imageUrl:
            'https://img.pokemondb.net/sprites/home/normal/2x/avif/bulbasaur.avif',
      ),
      _CardData(
        'Раттата',
        descriptionText:
            'Шустрый покемон нормального типа. Легко приспосабливается к жизни в городах, а его острые зубы помогают выживать.',
        icon: Icons.circle,
        imageUrl:
            'https://img.pokemondb.net/sprites/home/normal/2x/avif/rattata.avif',
      ),
      _CardData(
        'Вульпикс',
        descriptionText:
            'Огненный покемон с несколькими красивыми хвостами. Может выпускать пламя и выглядит очень изящно.',
        icon: Icons.local_fire_department,
        imageUrl:
            'https://img.pokemondb.net/sprites/home/normal/2x/avif/vulpix.avif',
      ),
      _CardData(
        'Слоупок',
        descriptionText:
            'Водный и психический покемон. Он очень медлительный, но иногда неожиданно использует сильные психические способности.',
        icon: Icons.water_drop,
        imageUrl:
            'https://img.pokemondb.net/sprites/home/normal/2x/avif/slowpoke.avif',
      ),
      _CardData(
        'Дитто',
        descriptionText:
            'Необычный покемон нормального типа. Умеет превращаться в любого другого покемона, которого видит.',
        icon: Icons.circle,
        imageUrl:
            'https://img.pokemondb.net/sprites/home/normal/2x/avif/ditto.avif',
      ),
    ];

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: data.map((e) => _Card.fromData(e)).toList(),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String text;
  final String descriptionText;
  final IconData icon;
  final String? imageUrl;

  const _Card(
    this.text, {
    this.icon = Icons.ac_unit_outlined,
    required this.descriptionText,
    this.imageUrl,
  });

  factory _Card.fromData(_CardData data) => _Card(
    data.text,
    descriptionText: data.descriptionText,
    icon: data.icon,
    imageUrl: data.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.lightGreen.withOpacity(.2),
            spreadRadius: 4,
            offset: const Offset(0, 5),
            blurRadius: 8,
          ),
        ],
        color: Colors.grey.withOpacity(.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 100,
              width: 100,
              child: Image.network(
                imageUrl ?? '',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Placeholder(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Text(
                          descriptionText,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(icon),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
