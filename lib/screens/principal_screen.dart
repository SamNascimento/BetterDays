import 'package:better_days/components/alarm_button.dart';
import 'package:better_days/components/menu_button.dart';
import 'package:better_days/http/webclients/listametas_webclient.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaPrincipalScreen extends StatefulWidget {
  const TelaPrincipalScreen({Key? key}) : super(key: key);

  @override
  State<TelaPrincipalScreen> createState() => _TelaPrincipalScreenState();
}

class _TelaPrincipalScreenState extends State<TelaPrincipalScreen> {
  final ListaMetasWebClient _webClient = ListaMetasWebClient();

  //int _idUsuario = 0;
  String _nome = '';

  void _obterDadosUsuarioLogado() async {
    final prefs = await SharedPreferences.getInstance();

    //int idUsuario = (prefs.getInt('idUsuario') ?? 1);
    String nome = (prefs.getString('nome') ?? 'a');

    setState(() {
      //_idUsuario = idUsuario;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Text(
                'Bem vindo $_nome',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MenuButton(
                        icone: Icons.watch_later_outlined,
                        nome: 'Pomodoro',
                        onClick: () {}),
                    MenuButton(
                        icone: Icons.ac_unit_outlined,
                        nome: 'Respiração',
                        onClick: () {}),
                    MenuButton(
                        icone: Icons.alarm, nome: 'Alarmes', onClick: () {}),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ],
            ),
            const Text(
              'Próximos Alarmes',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            AlarmButton(nome: 'Alarme 1', onClick: () {}),
          ],
        ),
      ),
    );
  }
}
