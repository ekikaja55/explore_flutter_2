import 'package:explore_flutter_2/data/notifiers.dart';
import 'package:explore_flutter_2/views/pages/home_page.dart';
import 'package:explore_flutter_2/views/pages/profile_page.dart';
import 'package:explore_flutter_2/views/pages/settings_page.dart';
import 'package:explore_flutter_2/views/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';

List<Widget> pages = [HomePage(), ProfilePage()];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tutur.id"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              isDarkNotifier.value = !isDarkNotifier.value;
            },
            icon: ValueListenableBuilder(
              valueListenable: isDarkNotifier,
              builder: (context, isDark, child) {
                return Icon(isDark ? Icons.light_mode : Icons.dark_mode);
              },
            ),
          ),
          IconButton(
            onPressed: () {
              print("Settings Diklik");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SettingsPage(title: "Settings");
                  },
                ),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      bottomNavigationBar: NavbarWidget(),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
    );
  }
}
