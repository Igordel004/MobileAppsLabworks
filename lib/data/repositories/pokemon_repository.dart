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
  Future <List<CardData>?> loadData() async {
    try {
      const String url = '$_baseUrl/api/v2/pokemons';

      final Response<dynamic> response = await _dio.get<Map<dynamic, dynamic>>(url);

      final PokemonsDto dto = PokemonsDto.fromJson(response.data as Map<String, dynamic>);
      final List<CardData>? data = dto.data?.map((e) => e.toDomain()).toList();
      return data;
    } on DioException catch (e) {
      // todo
      return null;
    }
  }
}