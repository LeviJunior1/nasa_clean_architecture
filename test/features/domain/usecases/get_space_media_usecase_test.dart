import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:nasa_clean_architecture/core/usecases/errors/failures.dart';
import 'package:nasa_clean_architecture/features/domain/entities/space_media.dart';
import 'package:nasa_clean_architecture/features/domain/repositories/space_media_repository.dart';
import 'package:nasa_clean_architecture/features/domain/usecases/get_space_media_from_date_usecase.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

// https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY

void main() {
  late GetSpaceMediaFromDateUsecase usecase;
  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromDateUsecase(repository);
  });

  const tSpaceMedia = SpaceMediaEntity(
    description:
        "Ringed planet Saturn will be at its 2023 opposition, opposite the Sun in Earth's skies, on August 27. ",
    mediaType: "image",
    title: "A Season of Saturn",
    mediaUrl:
        "https://apod.nasa.gov/apod/image/2308/SeasonSaturnapodacasely1024.jpg",
  );

  final tDate = DateTime(2021, 02, 02);

  test(
    'Should get space media entity for a given date from the repository',
    () async {
      when(() => repository.getSpaceMediaFromDate(tDate)).thenAnswer(
        (_) async => const Right<Failure, SpaceMediaEntity>(tSpaceMedia),
      );

      final result = await usecase(tDate);

      // Espera que o resultado seja um Right de SpaceMedia
      expect(result, const Right(tSpaceMedia));
      // Verifica se o método foi chamado
      verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
    },
  );

  test(
    'Should return a ServerFailure when don\'t succeed',
    () async {
      // Arrange
      when(() => repository.getSpaceMediaFromDate(tDate)).thenAnswer(
        (_) async => Left<Failure, SpaceMediaEntity>(ServerFailure()),
      );

      // Act
      final result = await usecase(tDate);

      // Assert
      // Espera que o resultado seja um Right de SpaceMedia
      expect(result, Left(ServerFailure()));
      // Verifica se o método foi chamado
      verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
    },
  );
}
