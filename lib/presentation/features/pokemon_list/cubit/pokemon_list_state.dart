part of 'pokemon_list_cubit.dart';

abstract class PokemonListState extends Equatable {
  const PokemonListState();

  @override
  List<Object?> get props => [];
}

class PokemonListInitial extends PokemonListState {}

class PokemonListLoading extends PokemonListState {
  final List<PokemonEntity> pokemons;
  final bool isFirstFetch;

  const PokemonListLoading({
    this.pokemons = const [],
    this.isFirstFetch = true,
  });

  @override
  List<Object?> get props => [pokemons, isFirstFetch];
}

class PokemonListLoaded extends PokemonListState {
  final List<PokemonEntity> pokemons;
  final bool hasReachedMax;

  const PokemonListLoaded({
    required this.pokemons,
    required this.hasReachedMax,
  });

  @override
  List<Object?> get props => [pokemons, hasReachedMax];
}

class PokemonListError extends PokemonListState {
  final Failure failure;

  const PokemonListError({required this.failure});

  String get message => failure.message;

  @override
  List<Object?> get props => [failure];
}