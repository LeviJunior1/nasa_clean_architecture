import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_architecture/core/usecases/errors/exceptions.dart';
import 'package:nasa_clean_architecture/core/usecases/errors/failures.dart';

import 'package:nasa_clean_architecture/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_architecture/features/data/models/space_media_model.dart';
import 'package:nasa_clean_architecture/features/data/repositories/space_media_repository_implementation.dart';

class MockSpaceMediaDatasource extends Mock implements ISpaceMediaDatasource {}

void main() {
  late SpaceMediaRepositoryImplementation repository;
  late ISpaceMediaDatasource datasource;

  setUp(() {
    datasource = MockSpaceMediaDatasource();
    repository = SpaceMediaRepositoryImplementation(datasource: datasource);
  });

  const tSpaceMediaModel = SpaceMediaModel(
    description:
        "Ringed planet Saturn will be at its 2023 opposition, opposite the Sun in Earth's skies, on August 27. ",
    mediaType: "image",
    title: "A Season of Saturn",
    mediaUrl:
        "https://apod.nasa.gov/apod/image/2308/SeasonSaturnapodacasely1024.jpg",
  );

  final tDate = DateTime(2021, 02, 02);

  test('Should return space media model when calls the datasource', () async {
    // Arrange
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => tSpaceMediaModel);
    // Act
    final result = await repository.getSpaceMediaFromDate(tDate);
    // Assert
    expect(result, const Right(tSpaceMediaModel));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });

  test(
      'Should return a server failure when call the datasource is unsuccessful',
      () async {
    // Arrange
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenThrow(ServerException());
    // Act
    final result = await repository.getSpaceMediaFromDate(tDate);
    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });
}
