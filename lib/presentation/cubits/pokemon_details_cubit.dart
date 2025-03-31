import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokemon/domain/failures/failures.dart';
import 'package:pokemon/domain/usecases/get_pokemon_details.dart';

part 'pokemon_details_state.dart';

class PokemonDetailsCubit extends Cubit<PokemonDetailsState> {
  final GetPokemonDetails getPokemonDetails;

  PokemonDetailsCubit({required this.getPokemonDetails})
      : super(PokemonDetailsInitial());

  Future<void> loadPokemonDetails(int id) async {
    emit(PokemonDetailsLoading());

    final result = await getPokemonDetails(id);

    result.fold(
          (failure) => emit(PokemonDetailsError(failure: failure)),
          (pokemon) => emit(PokemonDetailsLoaded(pokemon: pokemon)),
    );
  }
}