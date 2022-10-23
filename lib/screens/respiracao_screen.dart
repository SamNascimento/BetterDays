import 'dart:async';

import 'package:flutter/material.dart';

class RespiracaoScreen extends StatefulWidget {
  const RespiracaoScreen({Key? key}) : super(key: key);

  @override
  State<RespiracaoScreen> createState() => _RespiracaoScreenState();
}

class _RespiracaoScreenState extends State<RespiracaoScreen> {
  Timer? _contagem;

  // Define o tamanho inicial do texto e do container
  double _tamanhoTexto = 48;
  double _alturaContainer = 100;
  double _larguraContainer = 250;

  bool _cresceu = false;
  bool _iniciouContagem = false;

  int _segundos = 10;

  Duration _duracaoContagem = const Duration(seconds: 5);
  final Duration _duracaoZerada = const Duration(seconds: 0);


  // Aumenta o tamanho do texto e do container gradativamente e depois os faz diminuir
  void _atualizarTamanho() async {
    if (_iniciouContagem == true) {
      return;
    }

    setState(() {
      _iniciouContagem = true;
      _cresceu = true;

      _tamanhoTexto = 64;
      _alturaContainer = 150;
      _larguraContainer = 325;
    });

    _iniciarContagem();

    await Future.delayed(const Duration(seconds: 6));

    setState(() {
      _cresceu = false;
      _tamanhoTexto = 48;
      _alturaContainer = 100;
      _larguraContainer = 250;
    });
  }

  // Começa a contagem regressiva
  void _iniciarContagem() {
    _contagem = Timer.periodic(
        const Duration(seconds: 1), (Timer timer) => _setContagem());
  }

  // Acompanha a contagem para verificar se a mesma já chegou a zero, e para ela nessas condições
  void _setContagem() {
    setState(() {
      if (_duracaoContagem == _duracaoZerada) {
        setState(() {
          _contagem!.cancel();

          _segundos = 10;

          _duracaoContagem = Duration(seconds: _segundos);

          _iniciouContagem = false;
        });
      } else {
        setState(() {
          _segundos--;

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
        title: const Text('Exercício de respiração'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedSize(
                duration: const Duration(seconds: 5),
                curve: Curves.linear,
                child: Container(
                  color: const Color(0xFF5BB319),
                  width: _larguraContainer,
                  height: _alturaContainer,
                  child: Center(
                    child: Text(
                      _cresceu ? 'Inspire' : 'Expire',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: _tamanhoTexto),
                    ),
                  ),
                ),
              ),
              Text(_segundos.toString(),
                  style: const TextStyle(
                      fontSize: 64, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: _atualizarTamanho,
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
        ),
      ),
    );
  }
}
