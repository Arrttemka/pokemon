import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokemon/domain/usecases/get_pokemon_list.dart';

part 'pokemon_list_state.dart';

class PokemonListCubit extends Cubit<PokemonListState> {
  final GetPokemonList getPokemonList;

  PokemonListCubit({required this.getPokemonList})
      : super(PokemonListInitial());

  int _offset = 0;
  final int _limit = 20;
  List<PokemonEntity> _allPokemons = [];
  bool _hasReachedMax = false;

  Future<void> loadMorePokemons() async {
    if (state is PokemonListLoading || _hasReachedMax) return;

    if (state is PokemonListLoaded) {
      emit(PokemonListLoading(
          pokemons: _allPokemons,
          isFirstFetch: false
      ));

      final result = await getPokemonList(_offset, _limit);

      result.fold(
            (failure) => emit(PokemonListError(message: failure.message)),
            (newPokemons) {
          _offset += _limit;
          _hasReachedMax = newPokemons.isEmpty;
          _allPokemons = [..._allPokemons, ...newPokemons];
          emit(PokemonListLoaded(
            pokemons: _allPokemons,
            hasReachedMax: _hasReachedMax,
          ));
        },
      );
    }
  }

  Future<void> loadPokemonList({bool refresh = false}) async {
    if (state is PokemonListLoading) return;

    if (refresh) {
      _offset = 0;
      _allPokemons = [];
      _hasReachedMax = false;
    }

    if (_hasReachedMax && !refresh) return;

    emit(PokemonListLoading(
        pokemons: _allPokemons,
        isFirstFetch: _offset == 0
    ));

    final result = await getPokemonList(_offset, _limit);

    result.fold(
          (failure) => emit(PokemonListError(message: failure.message)),
          (newPokemons) {
        _offset += _limit;
        _hasReachedMax = newPokemons.length < _limit;
        _allPokemons = [..._allPokemons, ...newPokemons];
        emit(PokemonListLoaded(
          pokemons: _allPokemons,
          hasReachedMax: _hasReachedMax,
        ));
      },
    );
  }
}