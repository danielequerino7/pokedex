import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:pokedex/dados/api-internet/entidade/http_paged_result.dart';
import 'package:pokedex/dados/api-internet/cliente_api.dart';
import 'pokedex_page.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  late final PagingController<int, PokemonEntity> _pagingController;

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController(firstPageKey: 0);

    // Listener para carregar a próxima página quando necessário
    _pagingController.addPageRequestListener((pageKey) async {
      try {
        setState(() {
          _isLoading = true;
        });

        final apiClient = Provider.of<ApiClient>(context, listen: false);

        final pokemons = await apiClient.getPokemons(page: pageKey, limit: 10);

        // Verifica se é a última página
        if (pokemons.isEmpty) {
          _pagingController.appendLastPage(pokemons); // Marca como última página
        } else {
          _pagingController.appendPage(pokemons, pageKey + 1); // Carrega a próxima página
        }
      } catch (e) {
        _pagingController.error = e;
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _navigateToPokedexPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PokedexPage(pagingController: _pagingController),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 300,
              height: 300,
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: _navigateToPokedexPage,
                child: Text("Pokédex"),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  print("Encontro Diário foi clicado");
                },
                child: Text("Encontro Diário"),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  print("Meus Pokémons foi clicado");
                },
                child: Text("Meus Pokémons"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}