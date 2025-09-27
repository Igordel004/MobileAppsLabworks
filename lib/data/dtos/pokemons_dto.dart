import 'package:json_annotation/json_annotation.dart';

part 'pokemons_dto.g.dart';

@JsonSerializable(createToJson: false)
class PokemonsDto {
  final List<PokemonDataDto>? data;

  const PokemonsDto({this.data});

  factory PokemonsDto.fromJson(Map<String, dynamic> json) => _$PokemonsDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class PokemonDataDto {
  final String? id;
  final String? type;
  final PokemonAttributesDataDto? attributes;

  const PokemonDataDto({this.id, this.type, this.attributes});

  factory PokemonDataDto.fromJson(Map<String, dynamic> json) => _$PokemonDataDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class PokemonAttributesDataDto {
  final String? name;
  final String? description;
  final List<String>? types;
  final String? image;

  const PokemonAttributesDataDto({this.name, this.description, this.types, this.image});

  factory PokemonAttributesDataDto.fromJson(Map<String, dynamic> json) => _$PokemonAttributesDataDtoFromJson(json);
}