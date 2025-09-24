import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/models/card.dart';
part '../details_page/details_page.dart';
part 'card.dart';

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
      body: const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      CardData(
        'Бульбазавр',
        descriptionText:
            'Крепкий покемон травяного типа. У него на спине растёт луковица, которая постепенно становится больше и сильнее.',
        icon: Icons.local_florist,
        imageUrl:
            'https://img.pokemondb.net/sprites/home/normal/2x/avif/bulbasaur.avif',
        types: ['Grass', 'Poison'],
      ),
      CardData(
        'Раттата',
        descriptionText:
            'Шустрый покемон нормального типа. Легко приспосабливается к жизни в городах, а его острые зубы помогают выживать.',
        icon: Icons.circle,
        imageUrl:
            'https://img.pokemondb.net/sprites/home/normal/2x/avif/rattata.avif',
        types: ['Normal'],
      ),
      CardData(
        'Вульпикс',
        descriptionText:
            'Огненный покемон с несколькими красивыми хвостами. Может выпускать пламя и выглядит очень изящно.',
        icon: Icons.local_fire_department,
        imageUrl:
            'https://img.pokemondb.net/sprites/home/normal/2x/avif/vulpix.avif',
        types: ['Fire'],
      ),
      CardData(
        'Слоупок',
        descriptionText:
            'Водный и психический покемон. Он очень медлительный, но иногда неожиданно использует сильные психические способности.',
        icon: Icons.water_drop,
        imageUrl:
            'https://img.pokemondb.net/sprites/home/normal/2x/avif/slowpoke.avif',
        types: ['Water', 'Psychic'],
      ),
      CardData(
        'Дитто',
        descriptionText:
            'Необычный покемон нормального типа. Умеет превращаться в любого другого покемона, которого видит.',
        icon: Icons.circle,
        imageUrl:
            'https://img.pokemondb.net/sprites/home/normal/2x/avif/ditto.avif',
        types: ['Normal'],
      ),
    ];

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: data
              .map(
                (e) => _Card.fromData(
                  e,
                  onLike: (title, isLiked) =>
                      _showSnackBar(context, title, isLiked),
                  onTap: () => _navToDetails(context, e),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String title, bool isLiked) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Покемон $title ${isLiked ? 'liked' : 'disliked'}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          backgroundColor: Colors.orangeAccent,
          duration: const Duration(seconds: 1),
        ),
      );
    });
  }

  void _navToDetails(BuildContext context, CardData data) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => DetailsPage(data)),
    );
  }
}
