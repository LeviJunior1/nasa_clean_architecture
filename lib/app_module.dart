import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

import 'package:nasa_clean_architecture/core/utils/date_input_converter.dart';
import 'package:nasa_clean_architecture/features/data/datasources/space_media_datasource_implementation.dart';
import 'package:nasa_clean_architecture/features/data/repositories/space_media_repository_implementation.dart';
import 'package:nasa_clean_architecture/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:nasa_clean_architecture/features/presenter/controllers/home_store.dart';
import 'package:nasa_clean_architecture/features/presenter/pages/home_page.dart';
import 'package:nasa_clean_architecture/features/presenter/pages/picture_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => HomeStore(i())),
    Bind.lazySingleton((i) => GetSpaceMediaFromDateUsecase(i())),
    Bind.lazySingleton(
        (i) => SpaceMediaRepositoryImplementation(datasource: i())),
    Bind.lazySingleton(
        (i) => SpaceMediaDatasouceImplementation(client: i(), converter: i())),
    Bind.lazySingleton((i) => http.Client()),
    Bind.lazySingleton((i) => DateInputConverter()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const HomePage()),
    ChildRoute('/picture', child: (_, args) => PicturePage.fromArgs(args.data)),
  ];
}
