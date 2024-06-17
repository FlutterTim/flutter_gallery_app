import 'package:flutter/material.dart';
import 'package:flutter_gallery/utilities/localizations.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var localizations = context.localizations;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.searchScreenTitle,
        ),
      ),
    );
  }
}
