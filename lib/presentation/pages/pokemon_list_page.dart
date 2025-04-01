import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/core/di/injection_container.dart';
import 'package:pokemon/core/theme/app_colors.dart';
import 'package:pokemon/core/theme/app_text_styles.dart';
import '../features/pokemon_list/cubit/pokemon_list_cubit.dart';
import '../features/pokemon_list/widgets/pokemon_card.dart';
import '../features/pokemon_list/widgets/pokemon_list_header_widget.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({Key? key}) : super(key: key);

  @override
  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  final _scrollController = ScrollController();
  late PokemonListCubit _pokemonListCubit;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _pokemonListCubit = sl<PokemonListCubit>();
    _pokemonListCubit.loadPokemonList();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && !_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
      });

      _pokemonListCubit.loadMorePokemons().then((_) {
        if (mounted) {
          setState(() {
            _isLoadingMore = false;
          });
        }
      });
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _pokemonListCubit,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: BlocBuilder<PokemonListCubit, PokemonListState>(
            builder: (context, state) {
              if (state is PokemonListInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PokemonListLoading && state.isFirstFetch) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PokemonListError && state is! PokemonListLoading) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error: ${state.message}',
                        style: AppTextStyles.error,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          _pokemonListCubit.loadPokemonList(refresh: true);
                        },
                        child: const Text('Retry', style: AppTextStyles.retryButton),
                      ),
                    ],
                  ),
                );
              }

              final pokemons = state is PokemonListLoading
                  ? state.pokemons
                  : state is PokemonListLoaded
                  ? state.pokemons
                  : [];

              final hasReachedMax = state is PokemonListLoaded
                  ? state.hasReachedMax
                  : false;

              return Column(
                children: [
                  const PokemonListHeader(),

                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: pokemons.length + 1,
                      itemBuilder: (context, index) {
                        if (index < pokemons.length) {
                          final pokemon = pokemons[index];
                          return PokemonCard(pokemon: pokemon);
                        }

                        if (state is PokemonListLoading && !state.isFirstFetch) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        } else if (hasReachedMax || _isLoadingMore == false) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}