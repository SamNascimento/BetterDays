import 'dart:convert';

import 'package:better_days/http/webclient.dart';
import 'package:better_days/models/usuario.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class UsuarioWebClient {
  Future<Usuario> logar(Usuario usuario) async {
    final String usuarioJson = jsonEncode(usuario.toJson());

    final Response response = await client.post(
      '${baseUrl}usuario/logar'.toUri(),
      headers: {
        'Content-type': 'application/json',
      },
      body: usuarioJson,
    );

    _validarErro(response);

    return Usuario.fromJson(jsonDecode(response.body));
  }

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
