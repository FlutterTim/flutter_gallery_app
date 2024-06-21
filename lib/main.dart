import 'dart:io';

import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gallery/routes.dart';
import 'package:flutter_gallery/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

var locale = Platform.localeName;

Future main() async {
  await dotenv.load(fileName: ".env");
  if (locale.contains('nl')) {
    locale = "nl-NL";
  } else {
    locale = "en-US";
  }
  WidgetsFlutterBinding.ensureInitialized();
  String storageLocation = (await getApplicationDocumentsDirectory()).path;
  await FastCachedImageConfig.init(
    subDir: storageLocation,
    clearCacheAfter: const Duration(
      days: 1,
    ),
  );
  FastCachedImageConfig.clearAllCachedImages();
  runApp(
    const ProviderScope(
      child: GalleryApp(),
    ),
  );
}

class GalleryApp extends StatelessWidget {
  const GalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: lightTheme,
      darkTheme: darkTheme,
      routerConfig: router,
      title: 'Gallery App',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('nl'),
      ],
    );
  }
}
