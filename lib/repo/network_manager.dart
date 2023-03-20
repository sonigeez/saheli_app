import 'package:dio/dio.dart';
import 'package:saheli_app/repo/networking_urls.dart';

class NetworkManager {
  static final dio = Dio(BaseOptions(baseUrl: NetworkingUrls.baseUrl));
}
