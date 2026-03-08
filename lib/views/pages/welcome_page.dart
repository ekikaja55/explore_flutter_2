import 'package:explore_flutter_2/views/pages/login_page.dart';
import 'package:explore_flutter_2/views/widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20.0,
          children: [
            Lottie.asset("assets/lotties/welcome.json"),
            FittedBox(
              child: Text(
                "Tutur.Id",
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 50.0,
                  letterSpacing: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WidgetTree();
                    },
                  ),
                );
              },
              style: FilledButton.styleFrom(
                minimumSize: Size(double.infinity, 40.0),
              ),
              child: Text("Get Started"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              },
              style: TextButton.styleFrom(
                minimumSize: Size(double.infinity, 40.0),
              ),
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
