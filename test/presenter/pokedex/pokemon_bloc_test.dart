import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_poke/data/repository/pokemon_repository.dart';
import 'package:test_poke/domain/get_pokemon_usecase.dart';
import 'package:test_poke/domain/pokemon.dart';
import 'package:test_poke/presenter/pokedex/bloc/get_pokedex_bloc.dart';
import 'package:test_poke/presenter/pokedex/bloc/store_pokedex_bloc.dart';

final mockPokemon = <Pokemon>[
  Pokemon(
      firstName: "Char",
      lastName: "mender",
      url: "https://pokeapi.co/api/v2/pokemon/1/"),
  Pokemon(
      firstName: "Pika",
      lastName: "chu",
      url: "https://pokeapi.co/api/v2/pokemon/2/"),
  Pokemon(
      firstName: "Bulba",
      lastName: "saur",
      url: "https://pokeapi.co/api/v2/pokemon/3/"),
];

class PokemonRepositoryMock extends Mock implements PokemonRepository {
  @override
  Future<(String?, List<Pokemon>?)> getListPokemon() async {
    return (null, mockPokemon);
  }
}

void main() {
  late GetPokedexBloc pokedexBloc;
  late PokemonRepository mockPokemonRepository;

  setUp(() {
    mockPokemonRepository = PokemonRepositoryMock();
    pokedexBloc =
        GetPokedexBloc(mockPokemonRepository, GetPokedexInitialState());
  });

  group("get pokemon bloc test success case", () {
    blocTest<GetPokedexBloc, GetPokedexState>(
      'emits [PokedexSuccessState] when PokedexState is added.',
      build: () => pokedexBloc,
      act: (bloc) async => await bloc.getPokemons(),
      expect: () => <GetPokedexState>[
        GetPokedexLoadingState(),
        GetPokedexSuccessState(pokemon: mockPokemon)
      ],
    );

    // blocTest<PokedexBloc, PokedexState>(
    //   'emits [PokedexFailedState] when PokedexState is added.',
    //   build: () => pokedexBloc,
    //   act: (bloc) => bloc.getPokemons(PokemonUseCaseFailedMock()),
    //   expect: () => <PokedexState>[
    //     PokedexLoadingState(),
    //     PokedexFailedState(message: "Error")
    //   ],
    // );
  });
}



// class PokemonUseCaseMock extends Mock implements PokemonUseCase {
//   @override
//   Future<(String?, List<Pokemon>?)> getAllPokemon() async {
//     return (null, mockPokemon);
//   }
// }

// class PokemonUseCaseFailedMock extends Mock implements PokemonUseCase {
//   @override
//   Future<(String?, List<Pokemon>?)> getAllPokemon() async {
//     return ("Error", null);
//   }
// }
