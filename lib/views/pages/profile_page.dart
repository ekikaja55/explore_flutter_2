import 'package:explore_flutter_2/data/notifiers.dart';
import 'package:explore_flutter_2/views/pages/welcome_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ListTile(
        title: Text("logout"),
        onTap: () {
          selectedPageNotifier.value = 0;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return WelcomePage();
              },
            ),
          );
        },
      ),
    );
  }
}
