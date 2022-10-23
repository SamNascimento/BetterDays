import 'dart:convert';

import 'package:better_days/http/webclient.dart';
import 'package:better_days/models/diario.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class DiarioWebClient {
  // Busca os dados de um registro apartir do id dela e retorna os dados em caso de exito
  Future<Diario> obterAnotacaoDiario(int idDiario) async {
    final Response response = await client.get(
      '${baseUrl}diario/$idDiario/anotacao'.toUri(),
    );

    _validarErro(response);

    return Diario.fromJson(jsonDecode(response.body));
  }

  // Obtém uma lista de registros que tenham relação com aquele usuário
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

  // Executa o cadastro e retorna os dados do registro caso a ação ocorra com sucesso
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

  // Executa a edição e retorna os dados do registro caso a ação ocorra com sucesso
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

  // Deleta um registro
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
