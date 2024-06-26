import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pokedex/painter/curved_painter.dart';
import 'package:flutter_app_pokedex/providers/pokemon_provider.dart';
import 'package:flutter_app_pokedex/widgets/pokemon_evolution_row_widget.dart';
import 'package:flutter_app_pokedex/widgets/pokemon_stats_widget.dart';
import 'package:provider/provider.dart';

import '../models/pokemon_model.dart';
import '../utils/utils.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);
    final Pokemon? args = pokemonProvider.selectedPokemon;

    if (args == null) {
      return const Scaffold(
        body: Center(
          child: Text("No Pokemon selected"),
        ),
      );
    }

    Size size = MediaQuery.of(context).size;
    Color color = getColor(args.type);
    Color colorDark = getDarkerColor(color);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomPaint(
              size: size,
              painter: CurvedPainter(color),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: const Icon(
                          Icons.chevron_left_rounded,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      GestureDetector(
                        child: const Icon(
                          Icons.star_border_outlined,
                          color: Colors.white,
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    args.name,
                    style: const TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: size.width * 0.5 - 100,
              top: size.height * 0.3 - 100,
              child: Column(
                children: [
                  Hero(
                    tag: '${args.id}',
                    child: CachedNetworkImage(
                      imageUrl: args.img,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.fill,
                      width: 200,
                      height: 200,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: colorDark,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                    child: Text(
                      getType1(args.type),
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PokemonStatsWidget(
                      title: 'HP',
                      value: 45,
                      color: colorDark,
                    ),
                    PokemonStatsWidget(
                      title: 'Attack',
                      value: 56,
                      color: colorDark,
                    ),
                    PokemonStatsWidget(
                      title: 'Defense',
                      value: 48,
                      color: colorDark,
                    ),
                    PokemonStatsWidget(
                      title: 'Sp. Atk',
                      value: 45,
                      color: colorDark,
                    ),
                    PokemonStatsWidget(
                      title: 'Sp. Def',
                      value: 37,
                      color: colorDark,
                    ),
                    PokemonStatsWidget(
                      title: 'Speed',
                      value: 34,
                      color: colorDark,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Evolutions',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    EvolutionRowWidget(
                      prevEvolutionImages: args.prevEvolutionImages,
                      nextEvolutionImages: args.nextEvolutionImages,
                      img: args.img,
                      colorDark: colorDark,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
