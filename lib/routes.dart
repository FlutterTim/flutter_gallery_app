import 'package:flutter_gallery/models/image.dart';
import 'package:flutter_gallery/ui/screens/favorites_screen.dart';
import 'package:flutter_gallery/ui/screens/home_screen.dart';
import 'package:flutter_gallery/ui/screens/image_screen.dart';
import 'package:flutter_gallery/ui/screens/search_screen.dart';
import 'package:go_router/go_router.dart';

const homeScreenRoute = '/';
const searchScreenRoute = '/search';
const favoritesScreenRoute = '/favorites';
const imageScreenRoute = '/image';

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
    GoRoute(
      name: 'image',
      path: imageScreenRoute,
      builder: (context, state) {
        ImageModel image = state.extra as ImageModel;
        return ImageScreen(image: image);
      },
    ),
  ],
);
