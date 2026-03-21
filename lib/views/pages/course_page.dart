import 'dart:convert';
import 'package:explore_flutter_2/models/activity_model.dart';
import 'package:explore_flutter_2/views/widgets/hero_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  var logger = Logger(printer: PrettyPrinter());
  late Future<ActivityModel> futureActivity;
  @override
  void initState() {
    super.initState();
    logger.d("Course Page -> Masuk Init State");
    futureActivity = fetchData();
  }

  Future<ActivityModel> fetchData() async {
    String uri = "https://bored-api.appbrewery.com/random";

    try {
      final response = await http.get(
        Uri.parse(uri),
        headers: {'Accept': 'application/json'},
      );
      logger.d(jsonDecode(response.body));
      return ActivityModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    } finally {
      logger.d("selesai fetch");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10.0,
          children: [
            HeroWidget(
              title: "Course Page",
              imgUrl: "assets/images/rei_2.jpeg",
              tag: "hero1",
            ),
            IconButton(
              onPressed: () => {
                setState(() {
                  futureActivity = fetchData();
                }),
              },
              icon: Icon(Icons.refresh),
            ),
            FutureBuilder<ActivityModel>(
              future: futureActivity,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Card(
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10.0,
                        children: [
                          Text(snapshot.data!.activity),
                          Row(
                            children: [
                              Chip(
                                backgroundColor: Colors.teal,
                                label: Text(snapshot.data!.type.toUpperCase()),
                              ),
                              const SizedBox(width: 10.0),
                              const Icon(Icons.people),
                              const SizedBox(width: 5.0),
                              Text("${snapshot.data!.participants} people"),
                            ],
                          ),
                          const Divider(),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.accessible),
                            title: const Text("Accessibility"),
                            subtitle: Text(snapshot.data!.accessibility),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.attach_money),
                            title: const Text("Price Level"),
                            subtitle: LinearProgressIndicator(
                              value: snapshot.data!.price.toDouble(),
                            ),
                          ),
                          if (snapshot.data!.link.isNotEmpty)
                            TextButton.icon(
                              onPressed: () {},
                              label: const Text("Open Link"),
                              icon: const Icon(Icons.link),
                            ),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
