import 'package:pokedex/dados/api-internet/cliente_api.dart';
import 'package:pokedex/dados/api-internet/newtork_mapper.dart';
import 'package:pokedex/dados/banco-dados/dao/pokemon_dao.dart';
import 'package:pokedex/dados/banco-dados/database_mapper.dart';
import 'package:pokedex/dados/repositorio/pokemon_repositorio.dart';
import 'package:pokedex/dominio/pokemon.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final ApiClient apiClient;
  final NetworkMapper networkMapper;
  final PokemonDao pokemonDao;
  final DatabaseMapper databaseMapper;

  PokemonRepositoryImpl({
    required this.pokemonDao,
    required this.databaseMapper,
    required this.apiClient,
    required this.networkMapper,
  });

  Future<List<Pokemon>> getPokemons({required int page, required int limit}) async {
    // Tenta carregar os Pokémons a partir do banco de dados
    final dbEntities = await pokemonDao.selectAll(limit: limit, offset: (page * limit) - limit);

    // Se houver dados no banco, retorna os dados locais
    if (dbEntities.isNotEmpty) {
      return databaseMapper.toPokemons(dbEntities);
    }

    // Caso contrário, busca os dados da API
    final networkEntity = await apiClient.getPokemons(page: page, limit: limit);
    final pokemons = networkMapper.toPokemons(networkEntity);

    // Salva os Pokémons no banco de dados local para cache
    pokemonDao.insertAll(databaseMapper.toPokemonDatabaseEntities(pokemons));

    return pokemons;
  }
}