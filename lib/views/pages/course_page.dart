import 'package:explore_flutter_2/views/widgets/hero_widget.dart';
import 'package:flutter/material.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: HeroWidget(
          title: "Course Page",
          imgUrl: "assets/images/rei_2.jpeg",
          tag: "hero1",
        ),
      ),
    );
  }
}
