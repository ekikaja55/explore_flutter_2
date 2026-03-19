import 'package:explore_flutter_2/data/constants.dart';
import 'package:explore_flutter_2/views/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
          print("lebar layar saat ini : ${widthScreen}");
          return Center(
            child: FractionallySizedBox(
              widthFactor: widthScreen > 500 ? 0.5 : 1.0,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  spacing: 20.0,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/lotties/onboarding.json"),
                    Text(
                      "Mulai perjalanan anda di Tutur.id",
                      style: KTextStyle.descText,
                      textAlign: TextAlign.justify,
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginPage();
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 40.0),
                      ),
                      child: Text("Next"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
