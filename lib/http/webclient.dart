import 'package:better_days/http/interceptors/logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

// Caminho padrão da API
const String baseUrl = 'https://samnascimento.dev/api/';

final Client client = InterceptedClient.build(
  interceptors: [
    LoggingInterceptor(),
  ],
  // Seta um timeout
  requestTimeout: const Duration(seconds: 10),
);
