part of 'pokemon_details_cubit.dart';

abstract class PokemonDetailsState extends Equatable {
  const PokemonDetailsState();

  @override
  List<Object?> get props => [];
}

class PokemonDetailsInitial extends PokemonDetailsState {}

class PokemonDetailsLoading extends PokemonDetailsState {}

class PokemonDetailsLoaded extends PokemonDetailsState {
  final PokemonEntity pokemon;

  const PokemonDetailsLoaded({required this.pokemon});

  @override
  List<Object?> get props => [pokemon];
}

class PokemonDetailsError extends PokemonDetailsState {
  final Failure failure;

  const PokemonDetailsError({required this.failure});

  String get message => failure.message;

  @override
  List<Object?> get props => [failure];
}