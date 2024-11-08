
import 'package:dio/dio.dart';
import 'entidade/http_paged_result.dart';


class ApiClient {
  late final Dio _dio;

  ApiClient({required String baseUrl}) {
    _dio = Dio()
      ..options.baseUrl = baseUrl;
  }

  Future<List<PokemonEntity>> getPokemons({int? page, int? limit}) async {
    try {
      final response = await _dio.get(
        "/pokemons",
        queryParameters: {
          '_page': page,
          '_per_page': limit,
        },
      );

      print("Primeiro Response: ${response.data}");

      if (response.data['data'] != null && response.data['data'] is List) {
        final List<dynamic> allData = response.data['data'];
        return allData
            .map((json) => PokemonEntity.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Data não existe');
      }
    } catch (e) {
      print("Erro ao carregar Pokémons: $e");
      rethrow;
    }
  }

}


