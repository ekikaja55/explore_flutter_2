import 'package:explore_flutter_2/data/constants.dart';
import 'package:explore_flutter_2/views/pages/course_page.dart';
import 'package:explore_flutter_2/views/widgets/container_widget.dart';
import 'package:explore_flutter_2/views/widgets/hero_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          HeroWidget(
            title: "Tutur.id",
            tag: "hero1",
            imgUrl: "assets/images/rei_1.jpeg",
            nextPage: CoursePage(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: KCardData.length,
              itemBuilder: (context, index) {
                final data = KCardData[index];
                return ContainerWidget(title: data.title, desc: data.desc);
              },
            ),
          ),
        ],
      ),
    );
  }
}
