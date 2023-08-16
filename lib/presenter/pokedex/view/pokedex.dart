import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_poke/presenter/pokedex/bloc/get_pokedex_bloc.dart';
import 'package:test_poke/presenter/pokedex/view/pokedex_controller.dart';

class PokedexView extends StatefulWidget {
  const PokedexView({super.key});

  @override
  PokedexViewState createState() => PokedexViewState();
}

class PokedexViewState extends PokedexController {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<GetPokedexBloc, GetPokedexState, GetPokedexState>(
      selector: (state) => state,
      builder: (_, state) => switch (state) {
        GetPokedexInitialState() => Container(),
        GetPokedexLoadingState() => const CircularProgressIndicator(),
        GetPokedexSuccessState() => ListView.builder(
            itemCount: state.pokemon.length,
            itemBuilder: (_, index) {
              return PokemonCard(
                name: state.pokemon[index].getFullName(),
              );
            },
          ),
        GetPokedexFailedState() => Center(
            child: Text(state.message),
          ),
      },
    );
  }
}

class PokemonCard extends StatelessWidget {
  final String name;

  const PokemonCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[200] ?? Colors.grey, width: 1),
      ),
      alignment: Alignment.center,
      child: Text(name),
    );
  }
}
