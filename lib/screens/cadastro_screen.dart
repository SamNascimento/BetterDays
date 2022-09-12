import 'package:flutter/material.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({Key? key}) : super(key: key);

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF304FFE),
          title: const Text('Cadastro'),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: 600,
            width: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (String? texto) {
                      if (texto != null && texto.isEmpty) {
                        return 'Nome é obrigatório';
                      }
                      return null;
                    },
                    controller: nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                      hintText: 'Primeiro nome',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (String? texto) {
                      if (texto != null && texto.isEmpty) {
                        return 'Usuário é obrigatório';
                      }
                      return null;
                    },
                    controller: loginController,
                    decoration: const InputDecoration(
                      labelText: 'Login',
                      border: OutlineInputBorder(),
                      hintText: 'Usuário',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    validator: (String? texto) {
                      if (texto != null && texto.isEmpty) {
                        return 'Senha é obrigatória';
                      }
                      return null;
                    },
                    controller: senhaController,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                      hintText: 'Senha',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 60,
                    bottom: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()){}
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5BB319),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    child: const Text('CADASTRAR'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
