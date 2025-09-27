import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/repositories/pokemon_repository.dart';
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
    final data = PokemonRepository().loadData();

    return Center(
      child: FutureBuilder<List<CardData>?>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data?.map((data) {
                return _Card.fromData(
                  data,
                  onLike: (String title, bool isLiked) => _showSnackBar(context, title, isLiked),
                  onTap: () => _navToDetails(context, data),
                );
              }).toList() ??
                  [],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
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
          backgroundColor: Colors.lightGreen,
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