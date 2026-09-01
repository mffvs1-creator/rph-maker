import 'package:rpgmaker/home/shared_preds.dart';
import 'package:rpgmaker/home/teia_inicial.dart';
import 'package:rpgmaker/home/loginpage.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SharedPrefs prefs = SharedPrefs();

  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  checkStatus() async {
    bool status = await prefs.getUserStatus();
    await Future.delayed(Duration(seconds: 3));
    if (status == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginPage();
          },
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginPage();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF323C81),
      body: Center(
        child: Image.network(
          'https://static.vecteezy.com/system/resources/thumbnails/015/081/534/small/white-rolling-dice-3d-rendering-isometric-icon-png.png',
        ),
      ),
    );
  }
}