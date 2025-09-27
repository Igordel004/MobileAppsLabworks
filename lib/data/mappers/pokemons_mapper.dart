import 'package:lab_app/data/dtos/pokemons_dto.dart';
import 'package:lab_app/domain/models/card.dart';

extension PokemonDataDtoToModel on PokemonDataDto {
  CardData toDomain() => CardData(
    attributes?.name ?? 'UNKNOWN',
    descriptionText: attributes?.description ?? '',
    types: attributes?.types ?? [],
    imageUrl: attributes?.image,
  );
}
