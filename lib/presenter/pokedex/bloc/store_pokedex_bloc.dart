// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:test_poke/data/repository/pokemon_repository.dart';
// import 'package:test_poke/domain/pokemon.dart';

// //get pokemon state
// abstract class StorePokedexState extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class StorePokedexInitialState extends StorePokedexState {}

// class StorePokedexLoadingState extends StorePokedexState {}

// //List
// class StorePokedexSuccessState extends StorePokedexState {
//   final String message;
//   StorePokedexSuccessState({required this.message});
// }

// class StorePokedexFailedState extends StorePokedexState {
//   final String message;
//   StorePokedexFailedState({required this.message});
// }

// class StorePokedexBloc extends Cubit<StorePokedexState> {
//   StorePokedexBloc() : super(StorePokedexInitialState());

//   Future<void> storePokemons(PokemonRepository pokemonRepository) async {
//     emit(StorePokedexLoadingState());
//     try {
//       final response = await pokemonRepository.postPokemon();
//       emit(StorePokedexSuccessState(message: response ?? ''));
//     } catch (e) {
//       emit(StorePokedexSuccessState(message: e.toString()));
//     }
//   }
// }
