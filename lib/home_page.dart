import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'models/pokemon_model.dart';
import 'utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              const Image(
                image: AssetImage('assets/pokemon_logo.png'),
                height: 60,
              ),
              const SizedBox(height: 10),
              const SearchWidget(),
              const SizedBox(height: 10),
              Expanded(
                child: FutureBuilder(
                  future: getPokemons(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<Pokemon>> snapshot,
                  ) {
                    if (snapshot.hasData) {
                      return GridView(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          mainAxisExtent: 160,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 20,
                        ),
                        physics: const BouncingScrollPhysics(),
                        children: snapshot.data!.map((pokemon) {
                          return GestureDetector(
                            child: PokemonBoxWidget(
                              pokemon: pokemon,
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                'details',
                                arguments: pokemon,
                              );
                            },
                          );
                        }).toList(),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PokemonBoxWidget extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonBoxWidget({super.key, required this.pokemon});

  Color getDarkerColor(Color color, [double amount = 0.4]) {
    final hsl = HSLColor.fromColor(color);
    final darkerHsl =
        hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return darkerHsl.toColor();
  }

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
              top: -60,
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
                  horizontal: 10,
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

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
        controller: textController,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Search pokemon',
        ),
      ),
    );
  }
}
