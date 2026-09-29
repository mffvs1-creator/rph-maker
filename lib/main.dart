import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rpgmaker/home/loginpage.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  //sqfliteFfiInit(); para inutilizar o sqflite no desktop em outros sistemas
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const MeuAppRPG());
}

class MeuAppRPG extends StatelessWidget {
  const MeuAppRPG({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPH Maker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const LoginPage(),
    );
  }
}