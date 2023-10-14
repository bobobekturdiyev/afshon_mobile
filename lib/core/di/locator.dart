import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../util/interceptor.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  Dio dio = Dio();
  dio.interceptors.addAll([
    CustomInterceptor(),
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
    ),
  ]);

  dio.options.followRedirects = true;
  dio.options.maxRedirects = 5;
  dio.options.contentType = 'application/json';
  dio.options.headers.addAll({
    "Accept": "application/json",
  });

  locator.registerSingleton<Dio>(dio);
}
