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
  final String message;

   PokemonDetailsError({required this.failure})
      : message = failure.message;

  @override
  List<Object?> get props => [failure, message];
}