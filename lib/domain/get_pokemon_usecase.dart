// import 'package:test_poke/data/repository/pokemon_repository.dart';
// import 'package:test_poke/domain/pokemon.dart';

// abstract class PokemonUseCase {
//   final PokemonRepository pokemonRepository;

//   PokemonUseCase(this.pokemonRepository);
//   Future<(String?, List<Pokemon>?)> getAllPokemon();
// }

// class GetPokemonUseCase extends PokemonUseCase {
//   GetPokemonUseCase(super.pokemonRepository);

//   @override
//   Future<(String?, List<Pokemon>?)> getAllPokemon() async {
//     try {
//       final List<Pokemon> response = await pokemonRepository.getListPokemon();

//       return (null, response);
//     } catch (e) {
//       return (e.toString(), null);
//     }
//   }
// }
