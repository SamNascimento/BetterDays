import 'package:better_days/components/ambientais_button.dart';
import 'package:better_days/screens/specific_screens/ambiental_screen.dart';
import 'package:flutter/material.dart';

class AmbientaisScreen extends StatelessWidget {
  const AmbientaisScreen({Key? key}) : super(key: key);

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
            AmbientaisButton(
              nome: 'Plantar uma árvore',
              // Ao ser pressionado esse botão cria a tela daquele exercício e encaminha o usuário para a mesma
              onClick: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AmbientalScreen(
                    nome: 'Plantar uma árvore',
                    descricao: "Pegue uma semente de uma árvore e plante em qualquer "
                        "terreno propenso, se for plantar uma árvore em um terreno público utilize "
                        "sementes de árvores pequenas ou de plantas menores. É importante"
                        "plantar novas mudas dado que elas são responsáveis por tratar o ar "
                        "que respiramos.",
                  ),
                ),
              ),
            ),
            AmbientaisButton(
              nome: 'Regar uma planta na rua',
              // Ao ser pressionado esse botão cria a tela daquele exercício e encaminha o usuário para a mesma
              onClick: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AmbientalScreen(
                    nome: 'Regar uma planta na rua',
                    descricao: "Pegue uma garrafa de 1L e regue alguma planta ou árvore "
                        "em ambiente público",
                  ),
                ),
              ),
            ),
            AmbientaisButton(
              nome: 'Recolher lixo da rua',
              // Ao ser pressionado esse botão cria a tela daquele exercício e encaminha o usuário para a mesma
              onClick: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AmbientalScreen(
                    nome: 'Recolher lixo da rua',
                    descricao: "Colete resíduos que estão jogados na rua e na calçada "
                        "e jogue esses em pontos de coleta de lixo corretos. Essa atividade é "
                        "importante pois resíduos espalhados pelas vias públicas podem gerar surtos "
                        "de doenças, tal como a dengue, ou mesmo gerar alagamento dado o entupimento "
                        "dos canais de ecoamento da água.",
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
