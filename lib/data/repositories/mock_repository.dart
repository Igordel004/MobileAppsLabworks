import 'package:flutter/material.dart';
import 'package:lab_app/domain/models/card.dart';
import 'package:lab_app/data/repositories/api_interface.dart';

class MockRepository extends ApiInterface {
  @override
  Future<List<CardData>?> loadData() async {
    return [
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
  }
}