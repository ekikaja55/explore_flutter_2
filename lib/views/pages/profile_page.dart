import 'package:explore_flutter_2/data/constants.dart';
import 'package:explore_flutter_2/data/notifiers.dart';
import 'package:explore_flutter_2/services/auth_service.dart';
import 'package:explore_flutter_2/views/pages/settings_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().currentUser;
    if (user != null) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            spacing: 10.0,
            children: [
              CircleAvatar(
                radius: 80.0,
                backgroundImage: user.photoURL != null
                    ? NetworkImage(user.photoURL!)
                    : AssetImage("assets/images/rei_1.jpeg") as ImageProvider,
              ),
              Text(user.displayName!, style: KTextStyle.titleTealText),
              Text(user.email!, style: KTextStyle.titleTealText),
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
                onTap: () async {
                  bool isSuccess = await AuthService().signOut();
                  if (isSuccess) {
                    selectedPageNotifier.value = 0;
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Gagal logout, coba lagi")),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
    } else {
      return Center(child: Text("Gagal Load Data"));
    }
  }
}
