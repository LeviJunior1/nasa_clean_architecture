import 'package:http/http.dart' as http;

import 'package:nasa_clean_architecture/core/http_client/http_client.dart';

class HttpImplementation extends HttpClient {
  final client = http.Client();

  @override
  Future<HttpResponse> get(String url) async {
    final response = await client.get(Uri.parse(url));
    return HttpResponse(
      data: response.body,
      statusCode: response.statusCode,
    );
  }

  @override
  Future<HttpResponse> post(String url, [Map<String, dynamic>? body]) {
    // TODO: implement post
    throw UnimplementedError();
  }
}
