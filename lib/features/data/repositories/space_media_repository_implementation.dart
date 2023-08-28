import 'package:dartz/dartz.dart';
import 'package:nasa_clean_architecture/core/usecases/errors/exceptions.dart';

import 'package:nasa_clean_architecture/core/usecases/errors/failures.dart';
import 'package:nasa_clean_architecture/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_architecture/features/domain/entities/space_media.dart';
import 'package:nasa_clean_architecture/features/domain/repositories/space_media_repository.dart';

class SpaceMediaRepositoryImplementation implements ISpaceMediaRepository {
  final ISpaceMediaDatasource datasource;

  SpaceMediaRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(
      DateTime date) async {
    try {
      final result = await datasource.getSpaceMediaFromDate(date);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
    // } on InvalidCredentialsException {
    //   return Left(InvalidCredentialsFailure);
    // }
  }
}
