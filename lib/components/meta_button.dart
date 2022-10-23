import 'package:better_days/components/response_dialog.dart';
import 'package:better_days/http/webclients/listametas_webclient.dart';
import 'package:better_days/screens/specific_screens/meta_screen.dart';
import 'package:flutter/material.dart';

// Cria um card com os dados de uma meta específica
class MetaButton extends StatefulWidget {
  final int idMetas;
  final int idUsuario;
  final String titulo;
  final String descricao;
  bool isConcluido;

  MetaButton({
    Key? key,
    required this.idMetas,
    required this.idUsuario,
    required this.titulo,
    required this.descricao,
    required this.isConcluido,
  }) : super(key: key);

  @override
  State<MetaButton> createState() => _MetaButtonState();
}

class _MetaButtonState extends State<MetaButton> {
  final ListaMetasWebClient _webClient = ListaMetasWebClient();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: SizedBox(
        height: 350,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: CheckboxListTile(
              title: Text(
                widget.titulo,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              value: widget.isConcluido,
              onChanged: (bool? value) {
                _webClient.alterarConclusaoMeta(widget.idMetas).then((meta) {
                  setState(() { widget.isConcluido = !widget.isConcluido; });
                });
              },
            ),
            backgroundColor: const Color(0xFFFF794A),
          ),
          body: Material(
            color: const Color(0xFFBF5C37),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: Center(
                    child: Text(
                      'Descrição: ${widget.descricao}',
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(
                            MaterialPageRoute(
                              builder: (context) => MetaScreen(
                                isCriacaoMeta: false,
                                idMetas: widget.idMetas,
                                titulo: widget.titulo,
                                descricao: widget.descricao,
                              ),
                            ),
                          )
                              .then((value) {
                            setState(() {});
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text(
                          'Editar meta',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _webClient.deletarMeta(widget.idMetas);
                          _showSuccesfulMessage(context);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text(
                          'Excluir meta',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccesfulMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return const SuccessDialog('Meta excluída com sucesso');
        }).then((value) => Navigator.pop(context));
  }
}
