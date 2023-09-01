import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:nasa_clean_architecture/core/http_client/http_client.dart';
import 'package:nasa_clean_architecture/core/usecases/errors/exceptions.dart';
import 'package:nasa_clean_architecture/core/utils/date_input_converter.dart';
import 'package:nasa_clean_architecture/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_architecture/features/data/datasources/space_media_datasource_implementation.dart';
import 'package:nasa_clean_architecture/features/data/models/space_media_model.dart';

import '../../mocks/space_media_mock.dart';

class HttpClientMocking extends Mock implements HttpClient {}

main() {
  late ISpaceMediaDatasource datasource;
  late HttpClient client;

  setUp(() {
    client = HttpClientMocking();
    datasource = SpaceMediaDatasouceImplementation(
        client: client, converter: DateInputConverter());
  });

  final tDateTime = DateTime(2023, 08, 29);
  const urlExpected =
      'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2021-02-02';

  void successfulMock() {
    when(() => client.get(any())).thenAnswer(
      (_) async => HttpResponse(
        data: spaceMediaMock,
        statusCode: 200,
      ),
    );
  }

  test('Should call the get method with correct url', () async {
    // Arrange
    successfulMock();
    // Act
    await datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    verify(() => client.get(urlExpected)).called(1);
  });

  test('Should return a SpaceMediaModel when is successful', () async {
    // Arrange
    successfulMock();
    const tSpaceMediaModelExpected = SpaceMediaModel(
      description:
          "Why isn't spiral galaxy M66 symmetric?  Usually, density waves of gas, dust, and newly formed stars circle a spiral galaxy's center and create a nearly symmetric galaxy.  The differences between M66's spiral arms and the apparent displacement of its nucleus are all likely caused by previous close interactions and the tidal gravitational pulls of nearby galaxy neighbors M65 and NGC 3628. The galaxy, featured here in infrared light taken by the James Webb Space Telescope, spans about 100,000 light years, lies about 35 million light years distant, and is the largest galaxy in a group known as the Leo Triplet.  Like many spiral galaxies, the long and intricate dust lanes of M66 are seen intertwined with the bright stars and intergalactic dust that follow the spiral arms.",
      mediaType: "image",
      title: "Unusual Spiral Galaxy M66 from Webb",
      mediaUrl:
          "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_1080.jpg",
    );
    // Act
    final result = await datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    expect(result, tSpaceMediaModelExpected);
  });

  test(
    'Should throw a ServerException when the call in unccessful',
    () async {
      // Arrange
      when(() => client.get(any())).thenAnswer((_) async =>
          HttpResponse(data: 'something went wrong', statusCode: 400));
      // Act
      final result = datasource.getSpaceMediaFromDate(tDateTime);
      // Assert
      expect(() => result, throwsA(isA<ServerException>()));
    },
  );
}
