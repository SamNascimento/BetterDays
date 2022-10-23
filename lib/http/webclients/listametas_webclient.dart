import 'dart:convert';

import 'package:better_days/http/webclient.dart';
import 'package:better_days/models/listametas.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class ListaMetasWebClient {
  // Busca os dados de uma meta apartir do id dela e retorna os dados em caso de exito
  Future<ListaMetas> obterMeta(int idMetas) async {
    final Response response = await client.get(
      '${baseUrl}meta/$idMetas'.toUri(),
    );

    _validarErro(response);

    return ListaMetas.fromJson(jsonDecode(response.body));
  }

  // Obtém uma lista de Metas que tenham relação com aquele usuário
  Future<List<ListaMetas>> obterMetas(int idUsuario) async {
    final Response response = await client.get(
      '${baseUrl}meta/usuario/$idUsuario'.toUri(),
    );

    _validarErro(response);

    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<ListaMetas> listaMetas =
        decodedJson.map((e) => ListaMetas.fromJson(e)).toList();

    return listaMetas;
  }

  // Executa o cadastro e retorna os dados da meta caso a ação ocorra com sucesso
  Future<ListaMetas> criarMeta(ListaMetas listaMetas) async {
    final String listaMetasJson = jsonEncode(listaMetas.toJson());

    final Response response = await client.post(
      '${baseUrl}meta'.toUri(),
      headers: {
        'Content-type': 'application/json',
      },
      body: listaMetasJson,
    );

    _validarErro(response);

    return ListaMetas.fromJson(jsonDecode(response.body));
  }

  // Executa a edição e retorna os dados da meta caso a ação ocorra com sucesso
  Future<ListaMetas> editarMeta(int idMetas, ListaMetas listaMetas) async {
    final String listaMetasJson = jsonEncode(listaMetas.toJson());

    final Response response = await client.post(
      '${baseUrl}meta/editar/$idMetas'.toUri(),
      headers: {
        'Content-type': 'application/json',
      },
      body: listaMetasJson,
    );

    _validarErro(response);

    return ListaMetas.fromJson(jsonDecode(response.body));
  }

  // Altera o status de conclusão de uma meta baseado no ID dela
  Future<ListaMetas> alterarConclusaoMeta(int idMetas) async {
    final Response response = await client.put(
      '${baseUrl}meta/changeconclusao/$idMetas'.toUri(),
    );

    _validarErro(response);

    return ListaMetas.fromJson(jsonDecode(response.body));
  }

  // Deleta uma meta
  Future deletarMeta(int idMetas) async {
    final Response response = await client.delete(
      '${baseUrl}meta/deletar/$idMetas'.toUri(),
    );

    _validarErro(response);
  }

  void _validarErro(Response response) {
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }
}
