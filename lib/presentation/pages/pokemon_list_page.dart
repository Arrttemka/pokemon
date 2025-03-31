import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/core/di/injection_container.dart';
import 'package:pokemon/presentation/cubits/pokemon_list_cubit.dart';
import 'package:pokemon/presentation/widgets/pokemon_card.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({Key? key}) : super(key: key);

  @override
  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  final _scrollController = ScrollController();
  late PokemonListCubit _pokemonListCubit;

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
    if (_isBottom) {
      _pokemonListCubit.loadMorePokemons();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF3C2C2C);
    const cardColor = Color(0xFF4A3A3A);
    const textColor = Colors.white;

    return BlocProvider(
      create: (_) => _pokemonListCubit,
      child: Scaffold(
        backgroundColor: backgroundColor,
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
                        style: const TextStyle(color: textColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          _pokemonListCubit.loadPokemonList(refresh: true);
                        },
                        child: const Text('Retry'),
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

              return RefreshIndicator(
                onRefresh: () async {
                  _pokemonListCubit.loadPokemonList(refresh: true);
                },
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'PokeApp',
                              style: TextStyle(
                                fontSize: 28,
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Pokemon list',
                              style: TextStyle(
                                fontSize: 18,
                                color: textColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Find the pokemon you want',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            if (index >= pokemons.length) {
                              if (state is PokemonListLoading && !state.isFirstFetch) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  child: Center(child: CircularProgressIndicator()),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            }

                            return PokemonCard(
                              pokemon: pokemons[index],
                              cardColor: cardColor,
                              textColor: textColor,
                            );
                          },
                          childCount: pokemons.length + 1,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}