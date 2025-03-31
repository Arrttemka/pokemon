import 'package:flutter/material.dart';

class PokemonImageWidget extends StatelessWidget {
  final String imageUrl;

  const PokemonImageWidget({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: 200,
      height: 200,
      errorBuilder: (_, __, ___) {
        return const Icon(Icons.error, color: Colors.red);
      },
    );
  }
}