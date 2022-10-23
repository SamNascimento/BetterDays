import 'dart:convert';

import 'package:better_days/http/webclient.dart';
import 'package:better_days/models/usuario.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioWebClient {
  // Executa o login e retorna os dados do usuário logado caso a ação ocorra com sucesso
  Future<Usuario> logar(Usuario usuario) async {
    final String usuarioJson = jsonEncode(usuario.toJson());

    final prefs = await SharedPreferences.getInstance();

    final Response response = await client.post(
      '${baseUrl}usuario/logar'.toUri(),
      headers: {
        'Content-type': 'application/json',
      },
      body: usuarioJson,
    );

    _validarErro(response);

    final Usuario usuarioLogado = Usuario.fromJson(jsonDecode(response.body));

    await prefs.setInt('idUsuario', usuarioLogado.idUsuario!);
    await prefs.setString('nome', usuarioLogado.nome!);

    return usuarioLogado;
  }

  // Executa o cadastro e retorna os dados do usuário logado caso a ação ocorra com sucesso
  Future<Usuario> cadastrar(Usuario usuario) async {
    final String usuarioJson = jsonEncode(usuario.toJson());

    final Response response = await client.post(
      '${baseUrl}usuario/cadastrar'.toUri(),
      headers: {
        'Content-type': 'application/json',
      },
      body: usuarioJson,
    );

    _validarErro(response);

    return Usuario.fromJson(jsonDecode(response.body));
  }

  void _validarErro(Response response) {
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }
}
