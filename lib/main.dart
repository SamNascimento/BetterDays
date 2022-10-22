import 'package:better_days/screens/cadastro_screen.dart';
import 'package:better_days/screens/login_screen.dart';
import 'package:better_days/screens/pomodoro_screen.dart';
import 'package:better_days/screens/principal_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Better Days',
      home: const LoginScreen(),
      routes: {
        '/cadastro': (context) => const CadastroScreen(),
        '/home': (context) => const TelaPrincipalScreen(),
        '/pomodoro': (context) => const PomodoroScreen(),
      },
    );
  }
}
