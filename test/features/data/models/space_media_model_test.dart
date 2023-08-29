import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:nasa_clean_architecture/features/data/models/space_media_model.dart';
import 'package:nasa_clean_architecture/features/domain/entities/space_media.dart';

import '../../mocks/space_media_mock.dart';

void main() {
  const tSpaceMediaModel = SpaceMediaModel(
    description:
        "Why isn't spiral galaxy M66 symmetric?  Usually, density waves of gas, dust, and newly formed stars circle a spiral galaxy's center and create a nearly symmetric galaxy.  The differences between M66's spiral arms and the apparent displacement of its nucleus are all likely caused by previous close interactions and the tidal gravitational pulls of nearby galaxy neighbors M65 and NGC 3628. The galaxy, featured here in infrared light taken by the James Webb Space Telescope, spans about 100,000 light years, lies about 35 million light years distant, and is the largest galaxy in a group known as the Leo Triplet.  Like many spiral galaxies, the long and intricate dust lanes of M66 are seen intertwined with the bright stars and intergalactic dust that follow the spiral arms.",
    mediaType: "image",
    title: "Unusual Spiral Galaxy M66 from Webb",
    mediaUrl:
        "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_1080.jpg",
  );

  test('Should be a subclass of SpaceMediaEntity', () {
    expect(tSpaceMediaModel, isA<SpaceMediaEntity>());
  });

  test('Should return a valid model', () {
    // Arrange
    final Map<String, dynamic> jsonMap = jsonDecode(spaceMediaMock);
    // Act
    final result = SpaceMediaModel.fromJson(jsonMap);
    // Assert
    expect(result, tSpaceMediaModel);
  });

  test('Shoud return a json map containing the proper data', () {
    // Arrange
    final expectedMap = {
      "explanation":
          "Why isn't spiral galaxy M66 symmetric?  Usually, density waves of gas, dust, and newly formed stars circle a spiral galaxy's center and create a nearly symmetric galaxy.  The differences between M66's spiral arms and the apparent displacement of its nucleus are all likely caused by previous close interactions and the tidal gravitational pulls of nearby galaxy neighbors M65 and NGC 3628. The galaxy, featured here in infrared light taken by the James Webb Space Telescope, spans about 100,000 light years, lies about 35 million light years distant, and is the largest galaxy in a group known as the Leo Triplet.  Like many spiral galaxies, the long and intricate dust lanes of M66 are seen intertwined with the bright stars and intergalactic dust that follow the spiral arms.",
      "media_type": "image",
      "title": "Unusual Spiral Galaxy M66 from Webb",
      "url": "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_1080.jpg"
    };
    // Act
    final result = tSpaceMediaModel.toJson();
    // Assert
    expect(result, expectedMap);
  });
}
