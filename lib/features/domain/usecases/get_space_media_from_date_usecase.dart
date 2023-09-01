import 'package:dartz/dartz.dart';

import 'package:nasa_clean_architecture/core/usecases/errors/failures.dart';
import 'package:nasa_clean_architecture/core/usecases/usecase.dart';
import 'package:nasa_clean_architecture/features/domain/entities/space_media.dart';
import 'package:nasa_clean_architecture/features/domain/repositories/space_media_repository.dart';

class GetSpaceMediaFromDateUsecase
    implements Usecase<SpaceMediaEntity, DateTime> {
  final ISpaceMediaRepository repository;

  GetSpaceMediaFromDateUsecase(this.repository);

  @override
  Future<Either<Failure, SpaceMediaEntity>> call(DateTime? date) async {
    // Validações - exemplo: formato de e-mail que tenha a ve com regra de negócio
    // Validações de api no data layer
    // Nesse exemplo verificar a data por exemplo
    // Chamar o repository
    return date != null
        ? await repository.getSpaceMediaFromDate(date)
        : Left(NullParamsFailure());
  }
}
