import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EvolutionRowWidget extends StatelessWidget {
  final List<String>? prevEvolutionImages;
  final List<String>? nextEvolutionImages;
  final String img;
  final Color colorDark;

  const EvolutionRowWidget({
    super.key,
    required this.prevEvolutionImages,
    required this.nextEvolutionImages,
    required this.img,
    required this.colorDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prevEvolutionImages != null && prevEvolutionImages!.isNotEmpty)
          for (var i = 0; i < prevEvolutionImages!.length; i++) ...[
            EvolutionImage(imageUrl: prevEvolutionImages![i]),
            const SizedBox(width: 16),
            EvolutionDivider(colorDark: colorDark),
            const SizedBox(width: 16),
          ],
        EvolutionImage(imageUrl: img),
        if (nextEvolutionImages != null && nextEvolutionImages!.isNotEmpty)
          for (var i = 0; i < nextEvolutionImages!.length; i++) ...[
            const SizedBox(width: 16),
            EvolutionDivider(colorDark: colorDark),
            const SizedBox(width: 16),
            EvolutionImage(imageUrl: nextEvolutionImages![i]),
          ],
      ],
    );
  }
}

class EvolutionImage extends StatelessWidget {
  final String imageUrl;

  const EvolutionImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: BoxFit.fill,
      width: 80,
      height: 80,
    );
  }
}

class EvolutionDivider extends StatelessWidget {
  final Color colorDark;

  const EvolutionDivider({
    super.key,
    required this.colorDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 80,
      decoration: BoxDecoration(
        color: colorDark,
      ),
    );
  }
}
