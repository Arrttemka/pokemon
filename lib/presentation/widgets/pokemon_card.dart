import 'package:flutter/material.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../pages/pokemon_details_page.dart';
import 'pokemon_card_info.dart';
import 'pokemon_card_image.dart';

class PokemonCard extends StatelessWidget {
  final PokemonEntity pokemon;
  final Color cardColor;
  final Color textColor;

  const PokemonCard({
    Key? key,
    required this.pokemon,
    required this.cardColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetailsPage(pokemon: pokemon),
          ),
        );
      },
      child: Card(
        color: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PokemonCardInfo(
                  name: pokemon.name,
                  id: pokemon.id,
                  textColor: textColor,
                ),
              ),
              const SizedBox(width: 16),
              PokemonCardImage(imageUrl: pokemon.imageUrl),
            ],
          ),
        ),
      ),
    );
  }
}