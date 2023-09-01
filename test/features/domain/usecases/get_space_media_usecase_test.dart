import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:nasa_clean_architecture/core/usecases/errors/failures.dart';
import 'package:nasa_clean_architecture/features/domain/entities/space_media.dart';
import 'package:nasa_clean_architecture/features/domain/repositories/space_media_repository.dart';
import 'package:nasa_clean_architecture/features/domain/usecases/get_space_media_from_date_usecase.dart';

import '../../mocks/date_mock.dart';
import '../../mocks/space_media_entity_mock.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUsecase usecase;
  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromDateUsecase(repository);
  });

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

  test(
    'Should return a NullParamsFailure when receives a null params',
    () async {
      // Arrange
      // Act
      final result = await usecase(null);

      // Assert
      // Espera que o resultado seja um Right de SpaceMedia
      expect(result, Left(NullParamsFailure()));
      // Verifica se o método foi chamado
      verifyNever(() => repository.getSpaceMediaFromDate(tDate));
    },
  );
}
