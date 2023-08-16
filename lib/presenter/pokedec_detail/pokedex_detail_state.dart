import 'package:equatable/equatable.dart';

abstract class PokeDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class PokeDetailInitialState extends PokeDetailState {}

class PokeDetailLoadingState extends PokeDetailState {}

class PokeDetailSuccessState extends PokeDetailState {}

class PokeDetailFailedState extends PokeDetailState {}
