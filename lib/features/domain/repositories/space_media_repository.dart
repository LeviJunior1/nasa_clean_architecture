import 'package:dartz/dartz.dart';

import 'package:nasa_clean_architecture/core/usecases/errors/failures.dart';
import 'package:nasa_clean_architecture/features/domain/entities/space_media.dart';

abstract class ISpaceMediaRepository {
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(
      DateTime date);
}
