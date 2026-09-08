import 'package:flutter/material.dart';
import 'package:rpgmaker/home/register_page.dart';
import 'package:rpgmaker/home/teia_inicial.dart';
import 'package:rpgmaker/USER/User_DAO.dart';
import 'package:rpgmaker/home/shared_preds.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SharedPrefs prefs = SharedPrefs();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/telalogin.png', fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Entre ou cadastre-se no RPG Maker',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 24),
                  TextField(
                    controller: userController,
                    decoration: InputDecoration(
                      hintText: 'Usuário',
                      // focusedBorder: buildUserOutlineInputBorder(),
                      // border: buildUserOutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      // focusedBorder: buildPasswordOutlineInputBorder(),
                      // border: buildPasswordOutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF102A5E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // <-- Radius
                      ),
                    ),
                    onPressed: onPressed,
                    child: Text(
                      'Entrar',
                      style: TextStyle(
                        color: Colors.indigoAccent,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // <-- Radius
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return RegisterPage();
                          },
                        ),
                      );
                    },

                    child: Text(
                      'Cadastrar Usuário',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onPressed() async {
    String username = userController.text;
    String password = passwordController.text;

    bool isAuth = await UserDao().login(username, password);

    if (isAuth) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ),
      );

      prefs.setUserStatus(true);
    } else {
      print('Usuario e/ou Senha incorreto');
    }
  }
}
