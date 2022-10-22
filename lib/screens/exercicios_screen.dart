import 'package:better_days/components/exercicios_button.dart';
import 'package:better_days/screens/specific_screens/exercicio_screen.dart';
import 'package:flutter/material.dart';

class ExerciciosScreen extends StatelessWidget {
  const ExerciciosScreen({Key? key}) : super(key: key);

  final String _descricao = 'Apoie-se sobre os seus cotovelos no chão com o corpo o mais reto '
      'possível colocando a ponta dos pés igualmente no chão. Segure essa '
      'forma por aproximados 30 segundos.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF304FFE),
        title: const Text('Exercícios'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ExerciciosButton(
              image: 'assets/images/prancha.png',
              nome: 'Prancha',
              boxFit: BoxFit.cover,
              onClick: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExercicioScreen(
                    image: 'assets/images/prancha.png',
                    nome: 'Prancha',
                    boxFit: BoxFit.cover,
                    descricao: _descricao,
                  ),
                ),
              ),
            ),
            ExerciciosButton(
              image: 'assets/images/ponte.png',
              nome: 'Ponte',
              boxFit: BoxFit.fitHeight,
              onClick: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExercicioScreen(
                    image: 'assets/images/ponte.png',
                    nome: 'Ponte',
                    boxFit: BoxFit.fitHeight,
                    descricao: _descricao,
                  ),
                ),
              ),
            ),
            ExerciciosButton(
              image: 'assets/images/alongamento_de_joelho.png',
              nome: 'Alongamento de Joelho',
              boxFit: BoxFit.fitHeight,
              onClick: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExercicioScreen(
                    image: 'assets/images/alongamento_de_joelho.png',
                    nome: 'Alongamento de Joelho',
                    boxFit: BoxFit.fitHeight,
                    descricao: _descricao,
                  ),
                ),
              ),
            ),
            ExerciciosButton(
              image: 'assets/images/alongamento_de_dorsal.png',
              nome: 'Alongamento de Dorsal',
              boxFit: BoxFit.fitHeight,
              onClick: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExercicioScreen(
                    image: 'assets/images/alongamento_de_dorsal.png',
                    nome: 'Alongamento de Dorsal',
                    boxFit: BoxFit.fitHeight,
                    descricao: _descricao,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
