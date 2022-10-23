import 'package:flutter/foundation.dart';
import 'package:http_interceptor/http_interceptor.dart';

// Classe usada para testes afim de visualizar o que estava sendo enviado e o que estava sendo recebido
class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    if (kDebugMode) {
      print('==== REQUISIÇÃO ====');
      print('Método: ${data.method}');
      print('Url: ${data.url}');
      print('Header: ${data.headers}');
      print('Body: ${data.body}');
      print('==== REQUISIÇÃO ====');
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (kDebugMode) {
      print('==== RESPOSTA ====');
      print('Método: ${data.method}');
      print('Status code: ${data.statusCode}');
      print('Header: ${data.headers}');
      print('Body: ${data.body}');
      print('==== RESPOSTA ====');
    }
    return data;
  }
}