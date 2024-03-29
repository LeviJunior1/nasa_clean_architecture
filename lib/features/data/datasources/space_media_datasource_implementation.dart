import 'dart:convert';

import 'package:nasa_clean_architecture/core/usecases/errors/exceptions.dart';
import 'package:nasa_clean_architecture/core/utils/date_input_converter.dart';
import 'package:nasa_clean_architecture/features/data/datasources/endpoints/nasa_endpoints.dart';
import 'package:nasa_clean_architecture/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_architecture/features/data/models/space_media_model.dart';
import 'package:http/http.dart' as http;

class SpaceMediaDatasouceImplementation implements ISpaceMediaDatasource {
  final DateInputConverter converter;
  final http.Client client;

  SpaceMediaDatasouceImplementation({
    required this.converter,
    required this.client,
  });

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final dateConverted = converter.format(date);
    print(dateConverted);
    final response = await client.get(NasaEndpoints.getSpaceMedia(
      'DEMO_KEY',
      dateConverted,
    ));
    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
