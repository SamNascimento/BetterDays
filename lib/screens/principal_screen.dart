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

  // Obtém os dados do usuário logado de forma local, sem necessitar de uma nova chamada a API
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
              // Cria os botões de navegação para as demais telas
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
                            onClick: () =>
                                Navigator.pushNamed(context, '/pomodoro')),
                        MenuButton(
                            icone: Icons.air_outlined,
                            nome: 'Respiração',
                            onClick: () =>
                                Navigator.pushNamed(context, '/respiracao')),
                        MenuButton(
                            icone: Icons.alarm,
                            nome: 'Alarmes',
                            onClick: () =>
                                Navigator.pushNamed(context, '/alarme')),
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
                            onClick: () =>
                                Navigator.pushNamed(context, '/exercicios')),
                        MenuButton(
                            icone: Icons.bookmark_added_outlined,
                            nome: 'Metas',
                            onClick: () =>
                                Navigator.pushNamed(context, '/metas')),
                        MenuButton(
                            icone: Icons.perm_contact_calendar_outlined,
                            nome: 'Diário',
                            onClick: () =>
                                Navigator.pushNamed(context, '/diario')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 350,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MenuButton(
                            icone: Icons.forest_outlined,
                            nome: 'Exercícios ambientais',
                            onClick: () =>
                                Navigator.pushNamed(context, '/ambiental'),
                            width: 350,
                            height: 100,
                          ),
                        ],
                      ),
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
                child: AlarmButton(
                  nome: 'Alarme 1',
                  onClick: () => Navigator.pushNamed(context, '/alarme'),
                ),
              ),
              // Cria um card com um resumo das metas atuais
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
