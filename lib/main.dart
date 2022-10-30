import 'package:better_days/screens/alarme_screen.dart';
import 'package:better_days/screens/ambientais_screen.dart';
import 'package:better_days/screens/cadastro_screen.dart';
import 'package:better_days/screens/diarios_screen.dart';
import 'package:better_days/screens/exercicios_screen.dart';
import 'package:better_days/screens/login_screen.dart';
import 'package:better_days/screens/metas_screen.dart';
import 'package:better_days/screens/pomodoro_screen.dart';
import 'package:better_days/screens/principal_screen.dart';
import 'package:better_days/screens/respiracao_screen.dart';
import 'package:flutter/material.dart';

void main() {
  // Executa o aplicativo
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Better Days',
      // Roda a tela de login como tela principal ao início
      home: const LoginScreen(),
      // Rotas nomeadas que serão usadas para navegar entre telas
      routes: {
        '/cadastro': (context) => const CadastroScreen(),
        '/home': (context) => const TelaPrincipalScreen(),
        '/pomodoro': (context) => const PomodoroScreen(),
        '/respiracao': (context) => const RespiracaoScreen(),
        '/alarme': (context) => const AlarmeScreen(),
        '/exercicios': (context) => const ExerciciosScreen(),
        '/metas': (context) => const MetasScreen(),
        '/diario': (context) => const DiariosScreen(),
        '/ambiental': (context) => const AmbientaisScreen(),
      },
    );
  }
}
