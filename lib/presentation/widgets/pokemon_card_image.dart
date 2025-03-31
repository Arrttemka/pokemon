import 'package:flutter/material.dart';

class PokemonCardImage extends StatelessWidget {
  final String imageUrl;

  const PokemonCardImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: 50,
      height: 50,
      errorBuilder: (_, __, ___) {
        return const Icon(Icons.error, color: Colors.red);
      },
    );
  }
}