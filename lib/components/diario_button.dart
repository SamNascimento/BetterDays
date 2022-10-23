import 'package:better_days/components/response_dialog.dart';
import 'package:better_days/http/webclients/diario_webclient.dart';
import 'package:better_days/screens/specific_screens/diario_screen.dart';
import 'package:flutter/material.dart';

class DiarioButton extends StatefulWidget {
  final int idDiario;
  final int idUsuario;
  final String dataRegistro;
  final String titulo;
  final String nota;

  DiarioButton({
    Key? key,
    required this.idUsuario,
    required this.titulo,
    required this.idDiario,
    required this.dataRegistro,
    required this.nota,
  }) : super(key: key);

  @override
  State<DiarioButton> createState() => _DiarioButtonState();
}

class _DiarioButtonState extends State<DiarioButton> {
  final DiarioWebClient _webClient = DiarioWebClient();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: SizedBox(
        height: 350,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      widget.titulo,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      widget.dataRegistro.substring(0, 10),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: Center(
                    child: Text(
                      widget.nota,
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
                              builder: (context) => DiarioScreen(
                                isCriacaoRegistro: false,
                                idDiario: widget.idDiario,
                                titulo: widget.titulo,
                                nota: widget.nota,
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
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text(
                          'Editar registro',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _webClient.deletarAnotacaoDiario(widget.idDiario);
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
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text(
                          'Excluir registro',
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
          return const SuccessDialog('Registro excluído com sucesso');
        }).then((value) => Navigator.pop(context));
  }
}
