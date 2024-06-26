import 'package:flutter/material.dart';
import 'package:flutter_app_pokedex/models/pokemon_model.dart';
import 'package:flutter_app_pokedex/utils/utils.dart';

class PokemonProvider with ChangeNotifier {
  List<Pokemon> _pokemons = [];
  bool isLoading = false;
  Pokemon? _selectedPokemon;

  List<Pokemon> get pokemons => _pokemons;
  Pokemon? get selectedPokemon => _selectedPokemon;

  Future<void> fetchPokemons() async {
    isLoading = true;

    _pokemons = await getPokemons();
    await Future.wait(_pokemons.map((pokemon) => getImagesEvolution(
        pokemons: _pokemons,
        numPokemon: pokemon.num,
        currentPokemon: pokemon)));

    isLoading = false;
    notifyListeners();
  }

  void selectPokemon(Pokemon pokemon) {
    _selectedPokemon = pokemon;
    notifyListeners();
  }
}
