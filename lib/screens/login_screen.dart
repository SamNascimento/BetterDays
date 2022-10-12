import 'package:better_days/http/webclients/usuario_webclient.dart';
import 'package:better_days/models/usuario.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  final UsuarioWebClient _webClient = UsuarioWebClient();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF304FFE),
          title: const Text('Better Days'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
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
                padding: const EdgeInsets.all(12.0),
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
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()){
                      final String usuario = loginController.text;
                      final String senha = senhaController.text;

                      final Usuario user = Usuario(loginUsuario: usuario, senhaUsuario: senha);

                      _webClient.logar(user);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5BB319),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  child: const Text('LOGAR'),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Não tem login? Cadastre-se',
                  style: const TextStyle(color: Color(0xFF5BB319), fontSize: 18),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushNamed(
                        '/cadastro',
                      );
                    },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
