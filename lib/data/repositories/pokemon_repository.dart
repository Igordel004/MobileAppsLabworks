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

  static const String _baseUrl = 'https://pokeapi.co';

  @override
  Future<List<CardData>?> loadData({String? q}) async {
    try {
      const String listUrl = '$_baseUrl/api/v2/pokemon?limit=20';

      final Response<dynamic> listResponse = await _dio.get(listUrl);

      final List<dynamic> results = listResponse.data['results'] as List<dynamic>;

      final List<PokemonDataDto> dtoList = [];

      for (final result in results) {
        final String name = (result['name'] as String).replaceFirst(result['name'][0], result['name'][0].toUpperCase());

        if (q != null && q.isNotEmpty) {
          if (!name.toLowerCase().contains(q.toLowerCase())) {
            continue;
          }
        }

        final String pokeUrl = result['url'] as String;

        final Response<dynamic> pokeResponse = await _dio.get(pokeUrl);

        final List<String> types = (pokeResponse.data['types'] as List<dynamic>)
            .map((t) => (t['type']['name'] as String).replaceFirst(t['type']['name'][0], t['type']['name'][0].toUpperCase()))
            .toList();

        final String? image = pokeResponse.data['sprites']['other']['official-artwork']['front_default'] as String? ??
            pokeResponse.data['sprites']['front_default'] as String?;

        final String speciesUrl = pokeResponse.data['species']['url'] as String;

        final Response<dynamic> speciesResponse = await _dio.get(speciesUrl);

        String description = '';
        final List<dynamic> flavorTexts = speciesResponse.data['flavor_text_entries'] as List<dynamic>;
        for (final ft in flavorTexts) {
          if (ft['language']['name'] == 'en') {
            description = (ft['flavor_text'] as String).replaceAll(RegExp(r'[\n\f]'), ' ');
            break;
          }
        }

        dtoList.add(PokemonDataDto(
          id: pokeResponse.data['id'].toString(),
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