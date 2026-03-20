import 'package:explore_flutter_2/views/widget_tree.dart';
import 'package:explore_flutter_2/views/widgets/google_sign_in_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();
  final String _confirmedName = "123";
  final String _confirmedPass = "123";

  bool _isObscured = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            spacing: 20.0,
            children: [
              Lottie.asset("assets/lotties/login.json"),
              TextField(
                controller: _controllerName,
                decoration: InputDecoration(
                  labelText: "Username",
                  hintText: "Masukan username anda",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              TextField(
                obscureText: _isObscured,
                controller: _controllerPass,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Masukan password anda",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                    icon: Icon(
                      _isObscured ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  onLogin();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 40.0),
                ),
                child: Text("Login"),
              ),
              GoogleSignInWidget(),
            ],
          ),
        ),
      ),
    );
  }

  void onLogin() {
    ScaffoldMessenger.of(context).clearSnackBars();
    if (_controllerName.text.isEmpty || _controllerPass.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("Pesan Sistem"), Text("Harap isi inputan!")],
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_controllerName.text == _confirmedName &&
        _controllerPass.text == _confirmedPass) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WidgetTree();
          },
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Pesan Sistem"),
              Text("Username atau password salah!"),
            ],
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
  }
}
