import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_poke/data/repository/pokemon_repository.dart';
import 'package:test_poke/domain/pokemon.dart';
import 'package:test_poke/presenter/pokedex/bloc/store_pokedex_bloc.dart';

sealed class GetPokedexState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPokedexInitialState extends GetPokedexState {}

class GetPokedexLoadingState extends GetPokedexState {}

//List
class GetPokedexSuccessState extends GetPokedexState {
  final List<Pokemon> pokemon;
  GetPokedexSuccessState({required this.pokemon});
}

class GetPokedexFailedState extends GetPokedexState {
  final String message;
  GetPokedexFailedState({required this.message});
}

abstract class PokedexBloc<T> extends Cubit<T> {
  final PokemonRepository pokemonRepository;

  PokedexBloc(this.pokemonRepository, T initialState) : super(initialState);

  Future<void> getPokemons();
}

class GetPokedexBloc extends PokedexBloc<GetPokedexState> {
  GetPokedexBloc(super.pokemonRepository, super.initialState);

  @override
  Future<void> getPokemons() async {
    emit(GetPokedexLoadingState());
    try {
      final response = await pokemonRepository.getListPokemon();
      Pokemon pokemon = Pokemon();
      pokemon.getFullName();
      if (response.$2 != null) {
        emit(GetPokedexSuccessState(pokemon: response.$2 ?? <Pokemon>[]));
      } else {
        emit(GetPokedexFailedState(message: response.$1 ?? ''));
      }
    } catch (e) {
      emit(GetPokedexFailedState(message: e.toString()));
    }
  }
}
