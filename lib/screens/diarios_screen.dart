import 'package:better_days/components/diario_button.dart';
import 'package:better_days/components/progress.dart';
import 'package:better_days/http/webclients/diario_webclient.dart';
import 'package:better_days/models/diario.dart';
import 'package:better_days/screens/specific_screens/diario_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiariosScreen extends StatefulWidget {
  const DiariosScreen({Key? key}) : super(key: key);

  @override
  State<DiariosScreen> createState() => _DiariosScreenState();
}

class _DiariosScreenState extends State<DiariosScreen> {
  int _idUsuario = 0;
  final DiarioWebClient _webClient = DiarioWebClient();

  void _obterDadosUsuarioLogado() async {
    final prefs = await SharedPreferences.getInstance();

    int idUsuario = (prefs.getInt('idUsuario') ?? 0);

    setState(() {
      _idUsuario = idUsuario;
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
        title: const Text('Diário'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => DiarioScreen(
                          isCriacaoRegistro: true,
                          idUsuario: _idUsuario,
                        ),
                      ),
                    )
                        .then((value) {
                      setState(() {});
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7BFF17),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text(
                    'CRIAR REGISTRO',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FutureBuilder<List<Diario>>(
                    future: _webClient.obterDiario(_idUsuario),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          break;

                        case ConnectionState.waiting:
                          return const Progress();

                        case ConnectionState.active:
                          break;

                        case ConnectionState.done:
                          final List<Diario> diario = snapshot.data ?? [];
                          if (diario.isNotEmpty) {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final Diario registro = diario[index];
                                return DiarioButton(
                                  idDiario: registro.idDiario!,
                                  idUsuario: registro.idUsuario,
                                  titulo: registro.titulo,
                                  nota: registro.nota,
                                  dataRegistro: registro.dataRegistro!,
                                );
                              },
                              itemCount: diario.length,
                            );
                          }

                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 24.0),
                                  child: Text(
                                    'Não há registros no diário',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ),
                              ],
                            ),
                          );
                      }

                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 24.0),
                              child: Text(
                                'Erro ao carregar registros',
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
