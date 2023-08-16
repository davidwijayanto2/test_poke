import 'dart:convert';

import 'package:test_poke/domain/pokemon.dart';
import 'package:test_poke/utils/dio.dart';

abstract class PokemonRepository extends DioHandler {
  PokemonRepository({required super.dio});

  Future<(String?, List<Pokemon>?)> getListPokemon();
  // Future<String?> postPokemon();
}

class PokemonRepositoryAPI extends PokemonRepository {
  PokemonRepositoryAPI({required super.dio});

  @override
  Future<(String?, List<Pokemon>?)> getListPokemon() async {
    try {
      final response = await getData(
        url: "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
      );
      return (null, Pokemon().listPokemonFromJson(jsonEncode(response)));
    } catch (e) {
      return (e.toString(), null);
    }
  }

  // @override
  // Future<String?> postPokemon() async {
  //   try {
  //     final response = await postData(
  //       url: "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
  //     );
  //     return response;
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }
}
