// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_poke/data/repository/pokemon_repository.dart';
import 'package:test_poke/domain/pokemon.dart';

import '../../presenter/pokedex/pokemon_bloc_test.dart';
import '../mock_dio.dart';

class MockBuildContext extends Mock implements BuildContext {}

class DioAdapterMock extends Mock implements HttpClientAdapter {}

final Dio dioGetListPokemon = mockDioServer(
  url: "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
  method: Method.get,
  responseData: [
    {
      "firstName": "Char",
      "lastName": "mender",
      "url": "https://pokeapi.co/api/v2/pokemon/1/"
    },
    {
      "firstName": "Pika",
      "lastName": "chu",
      "url": "https://pokeapi.co/api/v2/pokemon/2/"
    },
    {
      "firstName": "Bulba",
      "lastName": "saur",
      "url": "https://pokeapi.co/api/v2/pokemon/3/"
    },
  ],
);
void main() {
  test('get list pokemon repository test', () async {
    PokemonRepository pokemonRepositoryAPI =
        PokemonRepositoryAPI(dio: dioGetListPokemon);
    final (String?, List<Pokemon>?) response =
        await pokemonRepositoryAPI.getListPokemon();
    expect(response.$1, null);
    expect(response.$2, isA<List<Pokemon>>());
  });
}
