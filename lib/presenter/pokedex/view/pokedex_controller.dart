import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_poke/presenter/pokedex/bloc/get_pokedex_bloc.dart';
import 'package:test_poke/presenter/pokedex/view/pokedex.dart';

abstract class PokedexController extends State<PokedexView> {
  @override
  void initState() {
    context.read<GetPokedexBloc>().getPokemons();
    super.initState();
  }
}
