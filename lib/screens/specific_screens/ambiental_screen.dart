import 'package:better_days/components/ambientais_button.dart';
import 'package:flutter/material.dart';

class AmbientalScreen extends StatefulWidget {
  final String nome;
  final String descricao;

  const AmbientalScreen({
    Key? key,
    required this.nome,
    required this.descricao,
  }) : super(key: key);

  @override
  State<AmbientalScreen> createState() => _AmbientalScreenState();
}

class _AmbientalScreenState extends State<AmbientalScreen> {

  bool isCumprida = false;
  final String doneText = 'Você cumpriu a tarefa';
  final String undoneText = 'Você não fez essa tarefa';

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
            AmbientaisButton(
              nome: widget.nome,
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
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0, left: 32, right: 32),
              child: Material(
                color:  isCumprida ? const Color(0xFF5BB319) : Colors.red,
                borderRadius: BorderRadius.circular(24),
                child: SizedBox(
                  width: 300,
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          isCumprida ? Icons.done_all_outlined : Icons.close_outlined,
                          color: Colors.white,
                          size: 40,
                        ),
                        Flexible(
                          child: Text(
                            isCumprida ? doneText : undoneText,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (){
                    setState(() {});
                    isCumprida = !isCumprida;
                  },
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
                  child: const Text('TROCAR STATUS'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
