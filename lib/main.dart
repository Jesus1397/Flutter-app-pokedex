import 'package:flutter/material.dart';
import 'package:flutter_app_pokedex/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

import 'pages/details_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PokemonProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomePage(),
        'details': (_) => const DetailsPage(),
      },
    );
  }
}
