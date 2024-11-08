import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokedex/dominio/pokemon.dart';

class PokemonDetalhes extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetalhes({Key? key, required this.pokemon}) : super(key: key);

  final Map<String, Color> typeColors = {
    'Fire': Colors.red,
    'Water': Colors.blue,
    'Grass': Colors.green,
    'Electric': Colors.yellow,
    'Psychic': Colors.pink,
    'Ice': Colors.cyan,
    'Normal': Colors.grey,
    'Fighting': Colors.brown,
    'Poison': Colors.purple,
    'Ground': Colors.orange,
    'Flying': Colors.lightBlue,
    'Bug': Colors.lightGreen,
    'Rock': Colors.amber,
    'Ghost': Colors.deepPurple,
    'Dragon': Colors.indigo,
  };

  @override
  Widget build(BuildContext context) {
    final String formattedId = pokemon.id.toString().padLeft(3, '0');
    final String imageUrl = 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$formattedId.png';

    // Verificação para definir a cor de fundo com base no tipo do Pokémon
    Color backgroundColor;
    if (pokemon.type != null && pokemon.type.isNotEmpty && typeColors.containsKey(pokemon.type.first)) {
      backgroundColor = typeColors[pokemon.type.first]!;
    } else {
      backgroundColor = Colors.grey.shade200; // Cor padrão se o tipo for nulo, vazio ou não mapeado
    }

    final double maxStatValue = 250;

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
        backgroundColor: backgroundColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 430,
                fit: BoxFit.fitWidth,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '#${formattedId} ${pokemon.name}',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      alignment: WrapAlignment.center,
                      children: (pokemon.type ?? []).map((type) {
                        return Chip(
                          label: Text(type),
                          backgroundColor: typeColors[type] ?? Colors.grey.shade300,
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Base Stats',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    _buildStatBar('HP', pokemon.baseStats['HP'] ?? 0, maxStatValue),
                    SizedBox(height: 10),
                    _buildStatBar('Attack', pokemon.baseStats['Attack'] ?? 0, maxStatValue),
                    SizedBox(height: 10),
                    _buildStatBar('Defense', pokemon.baseStats['Defense'] ?? 0, maxStatValue),
                    SizedBox(height: 10),
                    _buildStatBar('Speed', pokemon.baseStats['Speed'] ?? 0, maxStatValue),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBar(String label, int value, double maxStatValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: $value', style: TextStyle(fontSize: 16)),
        SizedBox(height: 5),
        Container(
          width: double.infinity,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(5),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: value / maxStatValue,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
