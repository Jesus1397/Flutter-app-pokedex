import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pokedex/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';
import 'models/pokemon_model.dart';
import 'utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<PokemonProvider>(context, listen: false).fetchPokemons();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -size.height * 0.15,
              right: -size.height * 0.15,
              child: Image.asset(
                'assets/game.png',
                height: size.height * 0.45,
                width: size.height * 0.45,
              ),
            ),
            Container(
              width: size.width,
              height: size.height,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.menu,
                    size: 30,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Pokedex',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SearchWidget(),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Consumer<PokemonProvider>(
                      builder: (context, pokemonProvider, child) {
                        if (pokemonProvider.isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (pokemonProvider.pokemons.isNotEmpty) {
                          return GridView(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              mainAxisExtent: 170,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 20,
                            ),
                            physics: const BouncingScrollPhysics(),
                            children: pokemonProvider.pokemons.map((pokemon) {
                              return GestureDetector(
                                child: PokemonBoxWidget(
                                  pokemon: pokemon,
                                ),
                                onTap: () {
                                  Provider.of<PokemonProvider>(context,
                                          listen: false)
                                      .selectPokemon(pokemon);
                                  Navigator.pushNamed(context, 'details');
                                },
                              );
                            }).toList(),
                          );
                        } else {
                          return const Center(child: Text("No Pokémon found."));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffBCBCBC),
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextFormField(
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        controller: textController,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Search pokemon',
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
