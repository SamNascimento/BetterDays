import 'dart:convert';

import 'package:better_days/http/webclient.dart';
import 'package:better_days/models/diario.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class DiarioWebClient {
  Future<Diario> obterAnotacaoDiario(int idDiario) async {
    final Response response = await client.get(
      '${baseUrl}diario/$idDiario/anotacao'.toUri(),
    );

    _validarErro(response);

    return Diario.fromJson(jsonDecode(response.body));
  }

  Future<List<Diario>> obterDiario(int idUsuario) async {
    final Response response = await client.get(
      '${baseUrl}diario/usuario/$idUsuario'.toUri(),
    );

    _validarErro(response);

    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Diario> diario =
    decodedJson.map((e) => Diario.fromJson(e)).toList();

    return diario;
  }

  Future<Diario> criarAnotacaoDiario(Diario diario) async {
    final String diarioJson = jsonEncode(diario.toJson());

    final Response response = await client.post(
      '${baseUrl}diario'.toUri(),
      headers: {
        'Content-type': 'application/json',
      },
      body: diarioJson,
    );

    _validarErro(response);

    return Diario.fromJson(jsonDecode(response.body));
  }

  Future<Diario> editarAnotacaoDiario(int idDiario, Diario diario) async {
    final String diarioJson = jsonEncode(diario.toJson());

    final Response response = await client.post(
      '${baseUrl}diario/editar/$idDiario'.toUri(),
      headers: {
        'Content-type': 'application/json',
      },
      body: diarioJson,
    );

    _validarErro(response);

    return Diario.fromJson(jsonDecode(response.body));
  }

  Future deletarAnotacaoDiario(int idDiario) async {
    final Response response = await client.delete(
      '${baseUrl}diario/deletar/$idDiario'.toUri(),
    );

    _validarErro(response);
  }

  void _validarErro(Response response) {
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }
}
