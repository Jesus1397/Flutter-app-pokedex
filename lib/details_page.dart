import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'models/pokemon_model.dart';
import 'utils/utils.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  Widget _buildStatRow(String title, int value, Color color) {
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

  @override
  Widget build(BuildContext context) {
    final Pokemon args = ModalRoute.of(context)?.settings.arguments as Pokemon;
    Size size = MediaQuery.of(context).size;
    final color = getColor(args.type);

    Color getDarkerColor(Color color, [double amount = 0.4]) {
      final hsl = HSLColor.fromColor(color);
      final darkerHsl =
          hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
      return darkerHsl.toColor();
    }

    final colorDark = getDarkerColor(color);

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
              bottom: 20,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatRow('HP', 45, colorDark),
                    _buildStatRow('Attack', 56, colorDark),
                    _buildStatRow('Defense', 48, colorDark),
                    _buildStatRow('Sp. Atk', 45, colorDark),
                    _buildStatRow('Sp. Def', 37, colorDark),
                    _buildStatRow('Speed', 34, colorDark),
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

class CurvedPainter extends CustomPainter {
  final Color color;

  CurvedPainter(this.color);

  Color getDarkerColor(Color color, [double amount = 0.4]) {
    final hsl = HSLColor.fromColor(color);
    final darkerHsl =
        hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return darkerHsl.toColor();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final baseColor = color;
    final darkerColor = getDarkerColor(baseColor);

    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          baseColor,
          darkerColor,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height * 0.3));

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height * 0.3)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.42, size.width,
          size.height * 0.3) // Ajusta la curva
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
