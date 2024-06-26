import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pokedex/models/pokemon_model.dart';
import 'package:flutter_app_pokedex/utils/utils.dart';

class PokemonBoxWidget extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonBoxWidget({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final baseColor = getColor(pokemon.type);
    final darkerColor = getDarkerColor(baseColor);
    return Container(
      decoration: const BoxDecoration(),
      padding: const EdgeInsets.only(top: 40),
      child: Container(
        width: 100,
        height: 160,
        decoration: BoxDecoration(
          color: getColor(pokemon.type),
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              darkerColor,
              baseColor,
            ],
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -50,
              left: 0,
              right: 0,
              child: Hero(
                tag: '${pokemon.id}',
                child: CachedNetworkImage(
                    cacheKey: '${pokemon.id}',
                    imageUrl: pokemon.img,
                    placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                    errorWidget: (context, url, error) {
                      return const Icon(Icons.error);
                    }),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 10,
              right: 10,
              child: Container(
                height: 30,
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(0, 189, 189, 189),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text(
                      '#${pokemon.num}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        pokemon.name,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
