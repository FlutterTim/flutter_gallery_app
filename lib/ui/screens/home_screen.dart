import 'package:flutter/material.dart';
import 'package:flutter_gallery/routes.dart';
import 'package:flutter_gallery/ui/widgets/button.dart';
import 'package:flutter_gallery/utilities/localizations.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var localizations = context.localizations;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.homeScreenTitle,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              onPressed: () => context.push(searchScreenRoute),
              buttonText: localizations.searchScreenTitle,
            ),
            Button(
              onPressed: () => context.push(favoritesScreenRoute),
              buttonText: localizations.favoritesScreenTitle,
            ),
          ],
        ),
      ),
    );
  }
}
