import 'package:better_days/components/alarm_button.dart';
import 'package:better_days/components/menu_button.dart';
import 'package:better_days/components/resumo_metas_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaPrincipalScreen extends StatefulWidget {
  const TelaPrincipalScreen({Key? key}) : super(key: key);

  @override
  State<TelaPrincipalScreen> createState() => _TelaPrincipalScreenState();
}

class _TelaPrincipalScreenState extends State<TelaPrincipalScreen> {
  int _idUsuario = 0;
  String _nome = '';

  void _obterDadosUsuarioLogado() async {
    final prefs = await SharedPreferences.getInstance();

    int idUsuario = (prefs.getInt('idUsuario') ?? 0);
    String nome = (prefs.getString('nome') ?? '');

    setState(() {
      _idUsuario = idUsuario;
      _nome = nome;
    });
  }

  @override
  void initState() {
    super.initState();
    _obterDadosUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF304FFE),
        title: const Text('Better Days'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Bem vindo $_nome',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MenuButton(
                            icone: Icons.watch_later_outlined,
                            nome: 'Pomodoro',
                            onClick: () => Navigator.pushNamed(context, '/pomodoro')),
                        MenuButton(
                            icone: Icons.air_outlined,
                            nome: 'Respiração',
                            onClick: () {}),
                        MenuButton(
                            icone: Icons.alarm, nome: 'Alarmes', onClick: () {}),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MenuButton(
                            icone: Icons.sports_gymnastics_outlined,
                            nome: 'Exercícios',
                            onClick: () {}),
                        MenuButton(
                            icone: Icons.bookmark_added_outlined,
                            nome: 'Metas',
                            onClick: () {}),
                        MenuButton(
                            icone: Icons.perm_contact_calendar_outlined,
                            nome: 'Diário',
                            onClick: () {}),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Próximos Alarmes',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AlarmButton(nome: 'Alarme 1', onClick: () {}),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ResumoMetasButton(idUsuario: _idUsuario),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
