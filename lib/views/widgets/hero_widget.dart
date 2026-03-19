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
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        AspectRatio(
          aspectRatio: 19 / 6,
          child: Hero(
            tag: tag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                imgUrl,
                color: Colors.teal,
                colorBlendMode: BlendMode.darken,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20.0),
              onTap: nextPage != null
                  ? () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => nextPage!),
                    )
                  : null,
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            letterSpacing: 10.0,
            fontSize: 40.0,
          ),
        ),
      ],
    );
  }
}
