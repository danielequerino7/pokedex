import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/dados/api-internet/entidade/http_paged_result.dart';
import 'package:pokedex/dados/repositorio/pokemon_repositorio_implementacao.dart';
import 'package:pokedex/dominio/pokemon.dart';
import 'package:pokedex/widgets/pokemon_card.dart';
import 'package:provider/provider.dart';


class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key, required PagingController<int, PokemonEntity> pagingController});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {

  late final PokemonRepositoryImpl pokemonRepo;
  late final PagingController<int, Pokemon> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    pokemonRepo = Provider.of<PokemonRepositoryImpl>(context, listen: false);
    _pagingController.addPageRequestListener(
          (pageKey) async {
        try {
          final pokemons = await pokemonRepo.getPokemons(page: pageKey, limit: 10);
          _pagingController.appendPage(pokemons, pageKey + 1);
        } catch (e) {
          _pagingController.error = e;
          //print(e);
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokédex"),
      ),
      body: PagedListView<int, Pokemon>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Pokemon>(
          itemBuilder: (context, pokemon, index) => PokemonCard(pokemon: pokemon),
        ),
      ),
    );
  }
}