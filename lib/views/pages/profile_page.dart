import 'package:explore_flutter_2/data/constants.dart';
import 'package:explore_flutter_2/data/notifiers.dart';
import 'package:explore_flutter_2/views/pages/settings_page.dart';
import 'package:explore_flutter_2/views/pages/welcome_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          spacing: 10.0,
          children: [
            CircleAvatar(
              radius: 80.0,
              backgroundImage: AssetImage("assets/images/rei_2.jpeg"),
            ),
            Text("Ekik", style: KTextStyle.titleTealText),

            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Profile"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SettingsPage(title: "Settings");
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("logout"),
              onTap: () {
                selectedPageNotifier.value = 0;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WelcomePage();
                    },
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
