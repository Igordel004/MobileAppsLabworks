// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemons_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonsDto _$PokemonsDtoFromJson(Map<String, dynamic> json) => PokemonsDto(
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => PokemonDataDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

PokemonDataDto _$PokemonDataDtoFromJson(Map<String, dynamic> json) =>
    PokemonDataDto(
      id: json['id'] as String?,
      type: json['type'] as String?,
      attributes: json['attributes'] == null
          ? null
          : PokemonAttributesDataDto.fromJson(
              json['attributes'] as Map<String, dynamic>,
            ),
    );

PokemonAttributesDataDto _$PokemonAttributesDataDtoFromJson(
  Map<String, dynamic> json,
) => PokemonAttributesDataDto(
  name: json['name'] as String?,
  description: json['description'] as String?,
  types: (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
  image: json['image'] as String?,
);
