import 'package:flutter/material.dart';
import 'package:pokemon/core/di/injection_container.dart';
import 'package:pokemon/core/navigation/app_navigator.dart';
import 'package:pokemon/core/theme/app_colors.dart';

class PokemonBackButton extends StatelessWidget {
  const PokemonBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: AppColors.backButtonColor,
      ),
      onPressed: () => sl<AppNavigator>().goBack(),
    );
  }
}