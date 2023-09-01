import 'package:flutter_triple/flutter_triple.dart';

import 'package:nasa_clean_architecture/core/usecases/errors/failures.dart';
import 'package:nasa_clean_architecture/features/domain/entities/space_media.dart';
import 'package:nasa_clean_architecture/features/domain/usecases/get_space_media_from_date_usecase.dart';

class HomeStore extends NotifierStore<Failure, SpaceMediaEntity> {
  final GetSpaceMediaFromDateUsecase usecase;

  HomeStore(this.usecase)
      : super(
          const SpaceMediaEntity(
            description: '',
            mediaType: '',
            title: '',
            mediaUrl: '',
          ),
        );

  getSpaceMediaFromDate(DateTime? date) async {
    // executeEither(() => usecase(date)); // Não funcionau mas ok
    setLoading(true);
    final result = await usecase(date);
    result.fold(
      (error) => setError(error),
      (success) => update(success),
    );
    setLoading(false);
  }
}
