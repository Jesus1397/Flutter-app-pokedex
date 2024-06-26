import 'package:flutter/material.dart';
import '../models/pokemon_model.dart';
import 'package:http/http.dart' as http;

Color getDarkerColor(Color color, [double amount = 0.4]) {
  final hsl = HSLColor.fromColor(color);
  final darkerHsl = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
  return darkerHsl.toColor();
}

Color getColor(List<Type> type) {
  switch (type.first.toString()) {
    case 'Type.FIRE':
      return const Color(0xffEB8E59).withOpacity(1);
    case 'Type.ICE':
      return const Color(0xff98D8D8).withOpacity(1);
    case 'Type.FLYING':
      return const Color(0xffA890F0).withOpacity(1);
    case 'Type.PSYCHIC':
      return const Color(0xffA040A0).withOpacity(1);
    case 'Type.WATER':
      return const Color(0xff6EE1F4).withOpacity(1);
    case 'Type.GROUND':
      return const Color(0xffE0C068).withOpacity(1);
    case 'Type.ROCK':
      return const Color(0xffB8A038).withOpacity(1);
    case 'Type.ELECTRIC':
      return const Color(0xffF8D030).withOpacity(1);
    case 'Type.GRASS':
      return const Color(0xff75E3AD).withOpacity(1);
    case 'Type.FIGHTING':
      return const Color(0xffC03028).withOpacity(1);
    case 'Type.POISON':
      return const Color(0xffA040A0).withOpacity(1);
    case 'Type.BUG':
      return const Color(0xffA8B820).withOpacity(1);
    case 'Type.FAIRY':
      return const Color(0xffF0B6BC).withOpacity(1);
    case 'Type.GHOST':
      return const Color(0xff705898).withOpacity(1);
    case 'Type.DARK':
      return const Color(0xff705848).withOpacity(1);
    case 'Type.STEEL':
      return const Color(0xffB8B8D0).withOpacity(1);
    case 'Type.DRAGON':
      return const Color(0xff7038F8).withOpacity(1);
    case 'Type.NORMAL':
      return const Color(0xffA8A878).withOpacity(1);
    default:
      return Colors.white;
  }
}

String getType1(List<Type> type) {
  switch (type[0].toString()) {
    case 'Type.FIRE':
      return "Fire";
    case 'Type.ICE':
      return "Ice";
    case 'Type.FLYING':
      return "Flying";
    case 'Type.PSYCHIC':
      return "Psychic";
    case 'Type.WATER':
      return "Water";
    case 'Type.GROUND':
      return "Ground";
    case 'Type.ROCK':
      return "Rock";
    case 'Type.ELECTRIC':
      return "Electric";
    case 'Type.GRASS':
      return "Grass";
    case 'Type.FIGHTING':
      return "Fighting";
    case 'Type.POISON':
      return "Poison";
    case 'Type.BUG':
      return "Bug";
    case 'Type.FAIRY':
      return "Fairy";
    case 'Type.GHOST':
      return "Ghost";
    case 'Type.DARK':
      return "Dark";
    case 'Type.STEEL':
      return "Steel";
    case 'Type.DRAGON':
      return "Dragon";
    case 'Type.NORMAL':
      return "Normal";
    default:
      return '';
  }
}

String getType2(List<Type> type) {
  switch (type[1].toString()) {
    case 'Type.FIRE':
      return "Fire";
    case 'Type.ICE':
      return "Ice";
    case 'Type.FLYING':
      return "Flying";
    case 'Type.PSYCHIC':
      return "Psychic";
    case 'Type.WATER':
      return "Water";
    case 'Type.GROUND':
      return "Ground";
    case 'Type.ROCK':
      return "Rock";
    case 'Type.ELECTRIC':
      return "Electric";
    case 'Type.GRASS':
      return "Grass";
    case 'Type.FIGHTING':
      return "Fighting";
    case 'Type.POISON':
      return "Poison";
    case 'Type.BUG':
      return "Bug";
    case 'Type.FAIRY':
      return "Fairy";
    case 'Type.GHOST':
      return "Ghost";
    case 'Type.DARK':
      return "Dark";
    case 'Type.STEEL':
      return "Steel";
    case 'Type.DRAGON':
      return "Dragon";
    case 'Type.NORMAL':
      return "Normal";
    default:
      return '';
  }
}

Future<List<Pokemon>> getPokemons() async {
  Pokemons pokemonData;
  List<Pokemon> pokemons = [];
  http.Response response;
  String jsonResponse;

  var url = Uri.https(
    'raw.githubusercontent.com',
    '/Biuni/PokemonGO-Pokedex/master/pokedex.json',
  );

  response = await http.get(url);
  jsonResponse = response.body;
  pokemonData = pokemonsFromJson(jsonResponse);

  for (var pokemon in pokemonData.pokemon) {
    pokemons.add(pokemon);
  }

  return pokemons;
}

Future<void> getImagesEvolution({
  required List<Pokemon> pokemons,
  required String numPokemon,
  required Pokemon currentPokemon,
}) async {
  try {
    final targetPokemon = pokemons.firstWhere((p) => p.num == numPokemon);

    if (targetPokemon.nextEvolution != null) {
      currentPokemon.nextEvolutionImages = targetPokemon.nextEvolution!
          .map((evo) => _getImageUrl(evo.num))
          .toList();
    } else {
      currentPokemon.nextEvolutionImages = [];
    }

    if (targetPokemon.prevEvolution != null) {
      currentPokemon.prevEvolutionImages = targetPokemon.prevEvolution!
          .map((evo) => _getImageUrl(evo.num))
          .toList();
    } else {
      currentPokemon.prevEvolutionImages = [];
    }
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }
}

String _getImageUrl(String pokemonNum) {
  return "http://www.serebii.net/pokemongo/pokemon/${pokemonNum.padLeft(3, '0')}.png";
}
