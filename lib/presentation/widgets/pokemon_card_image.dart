import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokemon/core/theme/app_colors.dart';

class PokemonCardImage extends StatelessWidget {
  final String imageUrl;
  final String? localImagePath;

  const PokemonCardImage({
    Key? key,
    required this.imageUrl,
    this.localImagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (localImagePath != null) {
      final file = File(localImagePath!);
      if (file.existsSync()) {
        return Image.file(
          file,
          width: 50,
          height: 50,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => _buildPlaceholder(),
        );
      }
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: 50,
      height: 50,
      fit: BoxFit.contain,
      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => _buildPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 50,
      height: 50,
      color: AppColors.placeholderBackground,
      child: const Center(
        child: Icon(
          Icons.catching_pokemon,
          size: 24,
          color: AppColors.iconColor,
        ),
      ),
    );
  }
}