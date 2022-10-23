import 'package:better_days/http/interceptors/logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

const String baseUrl = 'https://samnascimento.dev/api/';

final Client client = InterceptedClient.build(
  interceptors: [
    LoggingInterceptor(),
  ],
  requestTimeout: const Duration(seconds: 10),
);
