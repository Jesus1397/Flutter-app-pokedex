import 'package:flutter/material.dart';
import 'package:flutter_app_pokedex/widgets/pokemon_box_widget.dart';
import 'package:flutter_app_pokedex/providers/pokemon_provider.dart';
import 'package:flutter_app_pokedex/widgets/search_widget.dart';
import 'package:provider/provider.dart';

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
