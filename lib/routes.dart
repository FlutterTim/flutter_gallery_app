import 'package:flutter_gallery/ui/screens/favorites_screen.dart';
import 'package:flutter_gallery/ui/screens/home_screen.dart';
import 'package:flutter_gallery/ui/screens/search_screen.dart';
import 'package:go_router/go_router.dart';

const homeScreenRoute = '/';
const searchScreenRoute = '/search';
const favoritesScreenRoute = '/favorites';

final router = GoRouter(
  initialLocation: homeScreenRoute,
  routes: [
    GoRoute(
      name: 'home',
      path: homeScreenRoute,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: 'search',
      path: searchScreenRoute,
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      name: 'favorites',
      path: favoritesScreenRoute,
      builder: (context, state) => const FavoritesScreen(),
    ),
  ],
);
