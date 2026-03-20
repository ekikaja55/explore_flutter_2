import 'package:explore_flutter_2/services/auth_service.dart';
import 'package:explore_flutter_2/utils/my_logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GoogleSignInWidget extends StatelessWidget {
  const GoogleSignInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> googleSignIn() async {
      try {
        User? user = await AuthService().signInWithGoogle();

        if (user != null) {
          MyLogger().i(
            "Google Sign In Widget ->  sukses login data user : $user ",
          );

          if (context.mounted) {
            Navigator.popUntil(context, (route) => route.isFirst);
          }
        }
      } catch (e) {
        MyLogger().e(e);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error : $e")));
      }
    }

    return ElevatedButton(
      onPressed: () {
        MyLogger().i("Btn Sign In Diklik");
        googleSignIn();
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Continue With Google",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
