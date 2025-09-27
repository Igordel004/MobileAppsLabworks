import 'package:dio/dio.dart';
import 'package:lab_app/data/dtos/pokemons_dto.dart';
import 'package:lab_app/data/mappers/pokemons_mapper.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../domain/models/card.dart';
import 'api_interface.dart';

class PokemonRepository extends ApiInterface {
  static final Dio _dio = Dio()
    ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
    ));

  static const String _baseUrl = 'https://beta.pokeapi.co/graphql/v1beta';

  @override
  Future<List<CardData>?> loadData({String? q}) async {
    try {
      _dio.options.baseUrl = _baseUrl;

      const String query = r'''
        query getPokemons($limit: Int!, $where: pokemon_v2_pokemon_bool_exp) {
          pokemon_v2_pokemon(limit: $limit, order_by: {id: asc}, where: $where) {
            id
            name
            pokemon_v2_pokemontypes {
              pokemon_v2_type {
                name
              }
            }
            pokemon_v2_pokemonsprites {
              sprites
            }
            pokemon_v2_pokemonspecy {
              pokemon_v2_pokemonspeciesflavortexts(where: {pokemon_v2_language: {name: {_eq: "en"}}}, limit: 1) {
                flavor_text
              }
            }
          }
        }
      ''';

      final Map<String, dynamic> variables = {
        'limit': 151,
      };

      if (q != null && q.isNotEmpty) {
        variables['where'] = {
          'name': {'_ilike': '%$q%'},
        };
      }

      final Response<dynamic> response = await _dio.post(
        '',
        data: {
          'query': query,
          'variables': variables,
        },
      );

      final List<dynamic> results = response.data['data']['pokemon_v2_pokemon'] as List<dynamic>;

      final List<PokemonDataDto> dtoList = [];

      for (final result in results) {
        final String rawName = result['name'] as String;
        final String name = rawName.replaceFirst(rawName[0], rawName[0].toUpperCase());

        final List<dynamic> typeList = result['pokemon_v2_pokemontypes'] as List<dynamic>;
        final List<String> types = typeList.map((t) {
          final String rawType = t['pokemon_v2_type']['name'] as String;
          return rawType.replaceFirst(rawType[0], rawType[0].toUpperCase());
        }).toList();

        final List<dynamic> spritesList = result['pokemon_v2_pokemonsprites'] as List<dynamic>;
        final Map<String, dynamic> sprites = spritesList.isNotEmpty ? spritesList[0]['sprites'] as Map<String, dynamic> : {};

        final String? image = sprites['other']?['official-artwork']?['front_default'] as String? ??
            sprites['front_default'] as String?;

        final Map<String, dynamic> species = result['pokemon_v2_pokemonspecy'] as Map<String, dynamic>;
        final List<dynamic> flavorTexts = species['pokemon_v2_pokemonspeciesflavortexts'] as List<dynamic>;

        String description = '';
        if (flavorTexts.isNotEmpty) {
          description = (flavorTexts[0]['flavor_text'] as String).replaceAll(RegExp(r'[\n\f]'), ' ');
        }

        dtoList.add(PokemonDataDto(
          id: (result['id'] as int).toString(),
          type: 'pokemon',
          attributes: PokemonAttributesDataDto(
            name: name,
            description: description,
            types: types,
            image: image,
          ),
        ));
      }

      final PokemonsDto dto = PokemonsDto(data: dtoList);
      final List<CardData>? data = dto.data?.map((e) => e.toDomain()).toList();
      return data;
    } on DioException catch (e) {
      return null;
    }
  }
}