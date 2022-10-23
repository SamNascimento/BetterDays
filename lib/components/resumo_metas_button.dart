import 'package:better_days/components/progress.dart';
import 'package:better_days/http/webclients/listametas_webclient.dart';
import 'package:better_days/models/listametas.dart';
import 'package:flutter/material.dart';

// Cria um card com uma lista de metas resumidas para ser exibido na home
class ResumoMetasButton extends StatefulWidget {
  final int idUsuario;

  const ResumoMetasButton({Key? key, required this.idUsuario})
      : super(key: key);

  @override
  State<ResumoMetasButton> createState() => _ResumoMetasButtonState();
}

class _ResumoMetasButtonState extends State<ResumoMetasButton> {
  final ListaMetasWebClient _webClient = ListaMetasWebClient();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 350,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: InkWell(
              child: const Text('Resumo de Metas'),
              onTap: () => Navigator.pushNamed(context, '/metas'),
            ),
          ),
          backgroundColor: const Color(0xFFFF794A),
        ),
        body: Material(
          color: const Color(0xFFBF5C37),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, '/metas'),
            child: FutureBuilder<List<ListaMetas>>(
              future: _webClient.obterMetas(widget.idUsuario),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    break;

                  case ConnectionState.waiting:
                    return const Progress();

                  case ConnectionState.active:
                    break;

                  case ConnectionState.done:
                    final List<ListaMetas> listaMetas = snapshot.data ?? [];
                    if (listaMetas.isNotEmpty) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final ListaMetas listaMeta = listaMetas[index];
                          return CheckboxListTile(
                            title: Text(
                              listaMeta.titulo,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                            ),
                            value: listaMeta.isConcluido,
                            onChanged: (bool? value) {
                              if (listaMeta.idMetas != null) {
                                _webClient
                                    .alterarConclusaoMeta(listaMeta.idMetas!).then((meta) {
                                      setState(() {});
                                });
                              }
                            },
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
          ),
        ),
      ),
    );
  }
}
