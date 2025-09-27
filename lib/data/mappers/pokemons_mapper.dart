import 'package:flutter/material.dart';
import 'package:lab_app/data/dtos/pokemons_dto.dart';
import 'package:lab_app/domain/models/card.dart';

extension PokemonDataDtoToModel on PokemonDataDto {
  CardData toDomain() {
    final String? firstType = attributes?.types?.first;
    return CardData(
      attributes?.name ?? 'UNKNOWN',
      descriptionText: attributes?.description ?? '',
      types: attributes?.types ?? [],
      imageUrl: attributes?.image,
      icon: _getIconFromType(firstType ?? ''),
    );
  }

  IconData _getIconFromType(String type) {
    switch (type.toLowerCase()) {
      case 'grass':
        return Icons.local_florist;
      case 'normal':
        return Icons.circle;
      case 'fire':
        return Icons.local_fire_department;
      case 'water':
        return Icons.water_drop;
      case 'electric':
        return Icons.bolt;
      case 'ice':
        return Icons.ac_unit;
      case 'fighting':
        return Icons.sports_martial_arts;
      case 'poison':
        return Icons.science;
      case 'ground':
        return Icons.landscape;
      case 'flying':
        return Icons.air;
      case 'psychic':
        return Icons.psychology;
      case 'bug':
        return Icons.bug_report;
      case 'rock':
        return Icons.diamond;
      case 'ghost':
        return Icons.nights_stay;
      case 'dragon':
        return Icons.pets;
      default:
        return Icons.ac_unit_outlined;
    }
  }
}