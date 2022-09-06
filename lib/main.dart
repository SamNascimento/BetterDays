import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tarefas'),
        ),
        body: ListView(
          children: const [
            Task(
              nomeTarefa: 'Aprender Flutter',
            ),
            Task(
              nomeTarefa: 'Aprender .NET',
            ),
            Task(
              nomeTarefa: 'Meditar',
            ),
            Task(
              nomeTarefa: 'Correr',
            ),
          ],
        ),
      ),
    );
  }
}

class Task extends StatelessWidget {
  final String nomeTarefa;

  const Task({Key? key, required this.nomeTarefa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double margem = 8;

    return Padding(
      padding: const EdgeInsets.all(margem),
      child: Container(
        child: Stack(
          children: [
            Container(
              color: Colors.blue,
              height: 140,
            ),
            Container(
              color: Colors.white,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.grey,
                    width: 72,
                  ),
                  Container(
                      width: 200,
                      child: Text(
                        nomeTarefa,
                        style: const TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Icon(Icons.arrow_upward_rounded)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
