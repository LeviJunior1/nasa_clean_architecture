import 'dart:convert';

import 'package:nasa_clean_architecture/core/http_client/http_client.dart';
import 'package:nasa_clean_architecture/core/usecases/errors/exceptions.dart';
import 'package:nasa_clean_architecture/core/utils/converters/date_to_string_converter.dart';
import 'package:nasa_clean_architecture/core/utils/keys/nasa_api_keys.dart';
import 'package:nasa_clean_architecture/features/data/datasources/endpoints/nasa_endpoints.dart';
import 'package:nasa_clean_architecture/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_architecture/features/data/models/space_media_model.dart';

class NasaDatasourceImplementation implements ISpaceMediaDatasource {
  final HttpClient client;

  NasaDatasourceImplementation({
    required this.client,
  });

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final response = await client.get(
      NasaEndpoints.apod(
        NasaApiKeys.apiKey,
        DateToStringConverter.convert(date),
      ),
    );

    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.data));
    } else {
      throw ServerException();
    }
    // } else if (response.statusCode == 500) {
    //   // Posso colocar outras possiveis exceções
    //   // throw BadRequestException();
    // }
  }
}
