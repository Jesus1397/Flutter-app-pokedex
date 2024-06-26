import 'package:flutter/material.dart';

class PokemonStatsWidget extends StatelessWidget {
  const PokemonStatsWidget(
      {super.key,
      required this.title,
      required this.value,
      required this.color});

  final String title;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 206, 206, 206),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: LinearProgressIndicator(
              value: value / 100,
              color: color,
              minHeight: 8,
              borderRadius: BorderRadius.circular(8),
              backgroundColor: const Color.fromARGB(255, 206, 206, 206),
            ),
          ),
        ],
      ),
    );
  }
}
