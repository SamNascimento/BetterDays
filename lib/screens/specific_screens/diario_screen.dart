import 'package:better_days/components/progress.dart';
import 'package:better_days/components/response_dialog.dart';
import 'package:better_days/http/webclients/diario_webclient.dart';
import 'package:better_days/models/diario.dart';
import 'package:flutter/material.dart';

class DiarioScreen extends StatefulWidget {
  int? idDiario;
  int? idUsuario;
  String? titulo;
  String? nota;

  // Verifica se essa tela será destinada a criar uma meta ou a editar uma, executando diferentes ações dependendo do cenário
  final bool isCriacaoRegistro;

  DiarioScreen({
    Key? key,
    required this.isCriacaoRegistro,
    this.idDiario,
    this.idUsuario,
    this.titulo,
    this.nota,
  }) : super(key: key);

  @override
  State<DiarioScreen> createState() => _DiarioScreenState();
}

class _DiarioScreenState extends State<DiarioScreen> {
  // Controladores para checar e caputrar os dados dos campos
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _notaController = TextEditingController();

  final DiarioWebClient _webClient = DiarioWebClient();

  // Validador de estado de loading
  bool _sending = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Caso seja uma tela de edição ele pega os atuais valores da meta e exibe para o usuário em um autopreenchimento dos campos
    if (!widget.isCriacaoRegistro) {
      if (widget.titulo != null) {
        _tituloController.text = widget.titulo!;
      }

      if (widget.nota != null) {
        _notaController.text = widget.nota!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF304FFE),
          title: const Text('Registro'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 80.0, bottom: 40.0, left: 12.0, right: 12.0),
                child: TextFormField(
                  validator: (String? texto) {
                    // Verifica se os campos foram preenchidos corretamente
                    if (texto != null && texto.isEmpty) {
                      return 'Título é obrigatório';
                    }
                    return null;
                  },
                  controller: _tituloController,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                    hintText: 'Título',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  validator: (String? texto) {
                    // Verifica se os campos foram preenchidos corretamente
                    if (texto != null && texto.isEmpty) {
                      return 'Nota é obrigatória';
                    }
                    return null;
                  },
                  controller: _notaController,
                  decoration: const InputDecoration(
                    labelText: 'Texto',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 120.0, horizontal: 10.0),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(
                      // Sai da tela atual e cancela a ação de criação/edição
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5BB319),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        textStyle: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      child: const Text('DESCARTAR'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Caso todos os campos tiverem corretos o programa segue com a ação de criação ou edição
                        if (_formKey.currentState!.validate()) {
                          final String tituloText = _tituloController.text;
                          final String notaText = _notaController.text;

                          if (widget.isCriacaoRegistro) {
                            if (widget.idUsuario == null) {
                              _showFailureMessage(context, 'idUsuario é nulo');
                            } else {
                              final Diario registro = Diario(
                                idUsuario: widget.idUsuario!,
                                titulo: tituloText,
                                nota: notaText,
                              );

                              // Executa a chamada do método de criação
                              _criarRegistroDiario(
                                  registro, context, widget.isCriacaoRegistro);
                            }
                          } else {
                            if (widget.idDiario == null) {
                              _showFailureMessage(context, 'idDiario é nulo');
                            } else {
                              final Diario registro = Diario(
                                idUsuario: 0,
                                titulo: tituloText,
                                nota: notaText,
                              );

                              // Executa a chamada do método de edição
                              _editarRegistroDiario(widget.idDiario!, registro,
                                  context, widget.isCriacaoRegistro);
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5BB319),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        textStyle: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      child: const Text('SALVAR'),
                    ),
                  ),
                ],
              ),
              // Define que o loading será exibido enquanto o status da requisição não concluir
              Visibility(
                visible: _sending,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Progress(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _criarRegistroDiario(
      Diario registro, BuildContext context, bool isCriacaoRegistro) async {
    await _enviarCriacao(registro, context, isCriacaoRegistro);
  }

  Future _enviarCriacao(
      Diario registro, BuildContext context, bool isCriacaoRegistro) async {
    setState(() {
      _sending = true;
    });

    await _webClient.criarAnotacaoDiario(registro).then((value) {
      _showSuccesfulMessage(context, isCriacaoRegistro);
    }).catchError((e) {
      _showFailureMessage(context, e.message);
    }, test: (e) => e is Exception).whenComplete(() {
      _sending = false;
    });

    setState(() {});
  }

  void _editarRegistroDiario(int idDiario, Diario registro,
      BuildContext context, bool isCriacaoRegistro) async {
    await _enviarEdicao(idDiario, registro, context, isCriacaoRegistro);
  }

  Future _enviarEdicao(int idDiario, Diario registro, BuildContext context,
      bool isCriacaoRegistro) async {
    setState(() {
      _sending = true;
    });

    await _webClient.editarAnotacaoDiario(idDiario, registro).then((value) {
      _showSuccesfulMessage(context, isCriacaoRegistro);
    }).catchError((e) {
      _showFailureMessage(context, e.message);
    }, test: (e) => e is Exception).whenComplete(() {
      _sending = false;
    });

    setState(() {});
  }

  void _showFailureMessage(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }

  void _showSuccesfulMessage(BuildContext context, bool isCriacaoRegistro) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return SuccessDialog(isCriacaoRegistro
              ? 'Registro criado com sucesso'
              : 'Registro editado com sucesso');
        }).then((value) => Navigator.pop(context));
  }
}
