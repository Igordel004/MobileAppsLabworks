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

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _searchController = TextEditingController();
  final PokemonRepository _repo = PokemonRepository();
  late Future<List<CardData>?> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _repo.loadData();
  }

  void _onSearchChanged(String search) {
    setState(() {
      _dataFuture = _repo.loadData(q: search.isNotEmpty ? search : null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: CupertinoSearchTextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<CardData>?>(
              future: _dataFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final pokemons = snapshot.data!;
                  if (pokemons.isEmpty) {
                    return const Center(
                      child: Text('Покемоны не найдены'),
                    );
                  }
                  return ListView(
                    children: pokemons.map((data) {
                      return _Card.fromData(
                        data,
                        onLike: (String title, bool isLiked) => _showSnackBar(context, title, isLiked),
                        onTap: () => _navToDetails(context, data),
                      );
                    }).toList(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Ошибка: ${snapshot.error}'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}