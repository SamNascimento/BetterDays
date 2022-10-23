import 'package:better_days/components/progress.dart';
import 'package:better_days/components/response_dialog.dart';
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
  // Controladores para checar e caputrar os dados dos campos
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  // Validador de estado de loading
  bool _sending = false;

  // Webclient para fazer comunicação com a API
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
                    // Verifica se os campos foram preenchidos corretamente
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
                    // Verifica se os campos foram preenchidos corretamente
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
                    // Verifica se os campos foram preenchidos corretamente
                    if (_formKey.currentState!.validate()) {
                      final String usuario = loginController.text;
                      final String senha = senhaController.text;

                      final Usuario user =
                          Usuario(loginUsuario: usuario, senhaUsuario: senha);

                      // Executa a chamada do método de login
                      _logar(user, context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5BB319),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  child: const Text('LOGAR'),
                ),
              ),
              // Define que o loading será exibido enquanto o status da requisição não concluir
              Visibility(
                visible: _sending,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Progress(),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Não tem login? Cadastre-se',
                  style:
                      const TextStyle(color: Color(0xFF5BB319), fontSize: 18),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                    // Redireciona para a tela de cadastro
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

  void _logar(Usuario usuarioCriado, BuildContext context) async {
    await _send(usuarioCriado, context);
  }

  Future _send(Usuario usuarioCriado, BuildContext context) async {
    setState(() {
      _sending = true;
    });

    await _webClient.logar(usuarioCriado).then((value) {
      Navigator.of(context).pushReplacementNamed(
        '/home',
      );
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
}
