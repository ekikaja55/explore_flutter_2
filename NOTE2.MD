import 'package:flutter/material.dart';

void main() {
runApp(const Main());
}

class Main extends StatelessWidget {
const Main({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
theme: ThemeData(
colorScheme: ColorScheme.fromSeed(
seedColor: Colors.teal,
brightness: Brightness.dark,
),
),
home: SafeArea(
child: Scaffold(
appBar: AppBar(
title: Text("Tutur.id"),
// leading: Icon(Icons.menu),
centerTitle: true,
actions: [
// Text("login"),
// Icon(Icons.login),
],
),
drawer: Drawer(
child: Column(
children: [
// DrawerHeader(child: Text("Tutur.id")),
ListTile(title: Text('Logout')),
],
),
),
floatingActionButton: Column(
mainAxisSize: MainAxisSize.min,
children: [
FloatingActionButton(
onPressed: () {
print("FAB msg diklik");
},
child: Icon(Icons.message),
),
SizedBox(height: 10.0),
FloatingActionButton(
onPressed: () {
print("FAB add diklik");
},
child: Icon(Icons.add),
),
],
),
bottomNavigationBar: NavigationBar(
destinations: [
NavigationDestination(icon: Icon(Icons.home), label: "home"),
NavigationDestination(icon: Icon(Icons.person), label: "profile"),
],
selectedIndex: 1,
onDestinationSelected: (int value) {
print("menu yang dipilih index ke : $value");
},
),
),
),
);
}
}
