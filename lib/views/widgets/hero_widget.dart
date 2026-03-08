import 'package:flutter/material.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({
    super.key,
    required this.title,
    required this.imgUrl,
    required this.tag,
  });

  final String title;
  final String tag;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}
