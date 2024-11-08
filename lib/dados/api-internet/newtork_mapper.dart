
import 'package:pokedex/dados/api-internet/entidade/http_paged_result.dart';
import 'package:pokedex/dominio/excecoes/MapperException.dart';
import 'package:pokedex/dominio/pokemon.dart';

class NetworkMapper {

  // Método para mapear uma única entidade de Pokémon da API para o modelo de domínio
  Pokemon toPokemon(PokemonEntity entity) {
    try {
      return Pokemon(
        id: int.parse(entity.id),
        name: entity.name?["english"] ?? null,
        type: entity.type ?? [],
        baseStats: entity.baseStats,
      );
    } catch (e) {
      throw MapperException<PokemonEntity, Pokemon>(e.toString());
    }
  }

  List<Pokemon> toPokemons(List<PokemonEntity> entities) {
    return entities.map(toPokemon).toList();
  }

}
