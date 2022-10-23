import 'package:better_days/components/meta_button.dart';
import 'package:better_days/components/progress.dart';
import 'package:better_days/http/webclients/listametas_webclient.dart';
import 'package:better_days/models/listametas.dart';
import 'package:better_days/screens/specific_screens/meta_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MetasScreen extends StatefulWidget {
  const MetasScreen({Key? key}) : super(key: key);

  @override
  State<MetasScreen> createState() => _MetasScreenState();
}

class _MetasScreenState extends State<MetasScreen> {
  int _idUsuario = 0;

  // Webclient para fazer comunicação com a API
  final ListaMetasWebClient _webClient = ListaMetasWebClient();

  // Obtém os dados do usuário logado de forma local, sem necessitar de uma nova chamada a API
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
        title: const Text('Metas'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
                child: ElevatedButton(
                  // Redireciona para a tela de Meta caso o botão seja pressionado
                  onPressed: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => MetaScreen(
                          isCriacaoMeta: true,
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
                    'CRIAR META',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //Cria uma lista de cards para cada meta encontrado na API relacionado aquele Usuário
                  FutureBuilder<List<ListaMetas>>(
                    future: _webClient.obterMetas(_idUsuario),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          break;

                        case ConnectionState.waiting:
                          return const Progress();

                        case ConnectionState.active:
                          break;

                        case ConnectionState.done:
                          final List<ListaMetas> listaMetas =
                              snapshot.data ?? [];
                          if (listaMetas.isNotEmpty) {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final ListaMetas listaMeta = listaMetas[index];
                                return MetaButton(
                                  idMetas: listaMeta.idMetas!,
                                  idUsuario: listaMeta.idUsuario,
                                  titulo: listaMeta.titulo,
                                  descricao: listaMeta.descricao,
                                  isConcluido: listaMeta.isConcluido,
                                );
                              },
                              itemCount: listaMetas.length,
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
                                    'Não há metas registradas',
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
                                'Erro ao carregar metas',
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
