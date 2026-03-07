import 'package:explore_flutter_2/data/constants.dart';
import 'package:explore_flutter_2/views/widgets/hero_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(20.0),
      child: Column(
        children: [
          HeroWidget(),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Card Basic Layout", style: KTextStyle.titleTealText),
                    Text("Card Description", style: KTextStyle.descText),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
