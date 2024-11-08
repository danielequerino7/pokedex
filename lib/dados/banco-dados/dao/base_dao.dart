import 'package:flutter/material.dart';
import 'package:pokedex/dados/banco-dados/entidades-database/pokemon_database_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class BaseDao {
  static const databaseVersion = 1;
  static const _databaseName = 'pokemon_banco_dados.db';  // Alterado para o nome do banco de dados

  Database? _database;

  @protected
  Future<Database> getDb() async {
    _database ??= await _getDatabase();
    return _database!;
  }

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) async {
        final batch = db.batch();
        _createPokemonTableV1(batch);  // Alterado para a criação da tabela de Pokémon
        await batch.commit();
      },
      version: databaseVersion,
    );
  }

  void _createPokemonTableV1(Batch batch) {
    batch.execute(
      '''
      CREATE TABLE ${PokemonDatabaseContract.pokemonTable}(
      ${PokemonDatabaseContract.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${PokemonDatabaseContract.nameColumn} TEXT NOT NULL,
      ${PokemonDatabaseContract.type1Column} TEXT NOT NULL,  -- Tipos armazenados como uma string JSON
      ${PokemonDatabaseContract.type2Column} TEXT,  -- Tipos armazenados como uma string JSON (não é obrigatório)
      ${PokemonDatabaseContract.hpColumn} INTEGER NOT NULL,  -- baseStats armazenado como um valor inteiro
      ${PokemonDatabaseContract.attackColumn} INTEGER NOT NULL,
      ${PokemonDatabaseContract.defenseColumn} INTEGER NOT NULL,
      ${PokemonDatabaseContract.spAttackColumn} INTEGER NOT NULL,
      ${PokemonDatabaseContract.spDefenseColumn} INTEGER NOT NULL,
      ${PokemonDatabaseContract.speedColumn} INTEGER NOT NULL
      );
      ''',
    );
  }
}
