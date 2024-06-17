import 'package:flutter/material.dart';
import 'package:flutter_gallery/utilities/localizations.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var localizations = context.localizations;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.favoritesScreenTitle,
        ),
      ),
    );
  }
}
