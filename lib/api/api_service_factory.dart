import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'api_service.dart';

@injectable
class ApiServiceFactory {
  ApiService get() => ApiService(Dio());
}