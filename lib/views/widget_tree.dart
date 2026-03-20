import 'package:explore_flutter_2/data/notifiers.dart';
import 'package:explore_flutter_2/views/pages/home_page.dart';
import 'package:explore_flutter_2/views/pages/profile_page.dart';
import 'package:explore_flutter_2/views/pages/settings_page.dart';
import 'package:explore_flutter_2/views/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<Widget> pages = [HomePage(), ProfilePage()];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        if (selectedPageNotifier.value != 0) {
          selectedPageNotifier.value = 0;
          return;
        }

        bool? shouldPop = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Yakin Keluar"),
            content: Text("Kamu Keluar App Loh"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Batal"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Yakin"),
              ),
            ],
          ),
        );


        if (shouldPop == true) {
          // Navigator.of(context).pop();
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}
