import 'package:better_days/components/progress.dart';
import 'package:better_days/components/response_dialog.dart';
import 'package:better_days/http/webclients/listametas_webclient.dart';
import 'package:better_days/models/listametas.dart';
import 'package:flutter/material.dart';

class MetaScreen extends StatefulWidget {
  int? idMetas;
  int? idUsuario;
  String? titulo;
  String? descricao;

  // Verifica se essa tela será destinada a criar uma meta ou a editar uma, executando diferentes ações dependendo do cenário
  final bool isCriacaoMeta;

  MetaScreen({
    Key? key,
    required this.isCriacaoMeta,
    this.idMetas,
    this.idUsuario,
    this.titulo,
    this.descricao,
  }) : super(key: key);

  @override
  State<MetaScreen> createState() => _MetaScreenState();
}

class _MetaScreenState extends State<MetaScreen> {
  // Controladores para checar e caputrar os dados dos campos
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  final ListaMetasWebClient _webClient = ListaMetasWebClient();

  // Validador de estado de loading
  bool _sending = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Caso seja uma tela de edição ele pega os atuais valores da meta e exibe para o usuário em um autopreenchimento dos campos
    if(!widget.isCriacaoMeta){
      if (widget.titulo != null) {
        _tituloController.text = widget.titulo!;
      }

      if (widget.descricao != null) {
        _descricaoController.text = widget.descricao!;
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
          title: const Text('Meta'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80.0, bottom: 40.0, left: 12.0, right: 12.0),
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
                      return 'Descrição é obrigatória';
                    }
                    return null;
                  },
                  controller: _descricaoController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 120.0, horizontal: 10.0),
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
                          final String descricaoText = _descricaoController.text;

                          if (widget.isCriacaoMeta) {
                            if (widget.idUsuario == null) {
                              _showFailureMessage(context, 'idUsuario é nulo');
                            } else {
                              final ListaMetas listaMetas = ListaMetas(
                                idUsuario: widget.idUsuario!,
                                titulo: tituloText,
                                descricao: descricaoText,
                                isConcluido: false,
                              );

                              // Executa a chamada do método de criação
                              _criarListaMetas(listaMetas, context, widget.isCriacaoMeta);
                            }
                          } else {
                            if (widget.idMetas == null) {
                              _showFailureMessage(context, 'idMetas é nulo');
                            } else {
                              final ListaMetas listaMetas = ListaMetas(
                                idUsuario: 0,
                                titulo: tituloText,
                                descricao: descricaoText,
                                isConcluido: false,
                              );

                              // Executa a chamada do método de edição
                              _editarListaMetas(
                                  widget.idMetas!, listaMetas, context, widget.isCriacaoMeta);
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

  void _criarListaMetas(ListaMetas listaMetas, BuildContext context, bool isCriacaoMeta) async {
    await _enviarCriacao(listaMetas, context, isCriacaoMeta);
  }

  Future _enviarCriacao(ListaMetas listaMetas, BuildContext context, bool isCriacaoMeta) async {
    setState(() {
      _sending = true;
    });

    await _webClient.criarMeta(listaMetas).then((value) {
      _showSuccesfulMessage(context, isCriacaoMeta);
    }).catchError((e) {
      _showFailureMessage(context, e.message);
    }, test: (e) => e is Exception).whenComplete(() {
      _sending = false;
    });

    setState(() {});
  }

  void _editarListaMetas(
      int idMetas, ListaMetas listaMetas, BuildContext context, bool isCriacaoMeta) async {
    await _enviarEdicao(idMetas, listaMetas, context, isCriacaoMeta);
  }

  Future _enviarEdicao(
      int idMetas, ListaMetas listaMetas, BuildContext context, bool isCriacaoMeta) async {
    setState(() {
      _sending = true;
    });

    await _webClient.editarMeta(idMetas, listaMetas).then((value) {
      _showSuccesfulMessage(context, isCriacaoMeta);
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

  void _showSuccesfulMessage(BuildContext context, bool isCriacaoMeta) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return SuccessDialog(isCriacaoMeta ? 'Meta criada com sucesso' : 'Meta editada com sucesso');
        }).then((value) => Navigator.pop(context));
  }
}
