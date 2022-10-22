import 'dart:async';

import 'package:better_days/components/exercicios_button.dart';
import 'package:flutter/material.dart';

class ExercicioScreen extends StatefulWidget {
  final String image;
  final String nome;
  final String descricao;
  final BoxFit boxFit;

  const ExercicioScreen({
    Key? key,
    required this.image,
    required this.nome,
    required this.boxFit,
    required this.descricao,
  }) : super(key: key);

  @override
  State<ExercicioScreen> createState() => _ExercicioScreenState();
}

class _ExercicioScreenState extends State<ExercicioScreen> {
  Timer? _contagem;

  int _segundos = 60;

  bool _contagemIniciou = false;

  Duration _duracaoContagem = const Duration(seconds: 60);
  final Duration _duracaoZerada = const Duration(seconds: 0);

  void _iniciarContagem() {
    if (_contagemIniciou == true) {
      return;
    }

    _contagem = Timer.periodic(
        const Duration(seconds: 1), (Timer timer) => _setContagem());
  }

  void _setContagem() {
    setState(() {
      if (_duracaoContagem == _duracaoZerada) {
        setState(() {
          _contagem!.cancel();

          _contagemIniciou = false;

          _segundos = 60;

          _duracaoContagem = Duration(seconds: _segundos);
        });
      } else {
        setState(() {
          _segundos--;

          _contagemIniciou = true;

          _duracaoContagem = Duration(seconds: _segundos);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF304FFE),
        title: const Text('Exercício'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ExerciciosButton(
              image: widget.image,
              nome: widget.nome,
              boxFit: widget.boxFit,
              onClick: (){},
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  'Descrição: ${widget.descricao}',
                  style: const TextStyle(fontSize: 22),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 48.0),
                child: Text(
                  _segundos.toString(),
                  style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _iniciarContagem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5BB319),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    textStyle: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  child: const Text('INICIAR'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
