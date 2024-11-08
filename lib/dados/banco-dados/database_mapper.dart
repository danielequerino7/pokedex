import 'package:pokedex/dados/api-internet/entidade/http_paged_result.dart';
import 'package:pokedex/dados/banco-dados/entidades-database/pokemon_database_entity.dart';
import 'package:pokedex/dominio/excecoes/MapperException.dart';

import '../../dominio/pokemon.dart';

class DatabaseMapper {

  Pokemon toPokemon(PokemonDatabaseEntity entity) {
    try {

      /*
      print("Hp dentro do toPokemon: ${entity.hp}");
      print("Hp dentro do toPokemon: ${entity.attack}");
      print("Hp dentro do toPokemon: ${entity.defense}");
      print("Hp dentro do toPokemon: ${entity.spAttack}");
      print("Hp dentro do toPokemon: ${entity.spDefense}");
      print("Hp dentro do toPokemon: ${entity.speed}");
       */
      final types = [
        entity.type1,
        if (entity.type2 != null) entity.type2!,
      ];

      return Pokemon(
        id: entity.id!,
        name: entity.englishName,
        type: types,
        baseStats: {
          'hp': entity.hp,
          'attack': entity.attack,
          'defense': entity.defense,
          'spAttack': entity.spAttack,
          'spDefense': entity.spDefense,
          'speed': entity.speed,
        },
      );
    } catch (e) {
      throw MapperException<PokemonEntity, Pokemon>(e.toString());
    }
  }

  List<Pokemon> toPokemons(List<PokemonDatabaseEntity> entities) {
    final List<Pokemon> pokemons = [];
    for (var pokemonEntity in entities) {
      pokemons.add(toPokemon(pokemonEntity));
    }
    return pokemons;
  }

  PokemonDatabaseEntity toPokemonDatabaseEntity(Pokemon pokemon) {
    try {
      //print("Base stats recebidos em toPokemonDatabaseEntity: ${pokemon.baseStats}");

      return PokemonDatabaseEntity(
        id: pokemon.id,
        englishName: pokemon.name,
        type1: pokemon.type[0],
        type2: pokemon.type.length > 1
            ? pokemon.type[1]
            : null, // Pega o segundo tipo se existir
        hp: pokemon.baseStats['hp'] ?? 10,
        attack: pokemon.baseStats['attack']?? 20,
        defense: pokemon.baseStats['defense']?? 30,
        spAttack: pokemon.baseStats['spAttack']?? 40,
        spDefense: pokemon.baseStats['spDefense']?? 50,
        speed: pokemon.baseStats['speed']?? 60,
      );
    } catch (e) {
      throw MapperException<PokemonEntity, Pokemon>(e.toString());
    }
  }

  List<PokemonDatabaseEntity> toPokemonDatabaseEntities(List<Pokemon> pokemons) {
    final List<PokemonDatabaseEntity> pokemonDatabaseEntities = [];
    for (var p in pokemons) {
      pokemonDatabaseEntities.add(toPokemonDatabaseEntity(p));
    }
    return pokemonDatabaseEntities;
  }
}