import 'package:flutter/material.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({
    super.key,
    required this.title,
    required this.imgUrl,
    required this.tag,
    this.nextPage,
  });

  final String title;
  final String tag;
  final String imgUrl;
  final Widget? nextPage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: nextPage != null
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return nextPage!;
                  },
                ),
              );
            }
          : null,
      child: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          Hero(
            tag: tag,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20.0),
              child: Image.asset(
                imgUrl,
                color: Colors.teal,
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          FittedBox(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                letterSpacing: 50.0,
                fontSize: 50.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
