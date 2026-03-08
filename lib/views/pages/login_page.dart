import 'package:explore_flutter_2/views/widget_tree.dart';
import 'package:explore_flutter_2/views/widgets/hero_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPass = TextEditingController();
  String _confirmedName = "ekikaja55";
  String _confirmedPass = "123";

  bool _isObscured = true;
  @override
  void initState() {
    // TODO: implement initState
    print("Triggering init state");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
              HeroWidget(
                title: "Login",
                imgUrl: "assets/images/rei_2.jpeg",
                tag: "hero2",
              ),
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
