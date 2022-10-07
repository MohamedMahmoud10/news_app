import 'package:get_it/get_it.dart';
import 'package:news_app/data_layer/api_services/api_services.dart';

import '../cubits/news_cubit/news_cubit.dart';
import '../data_layer/repositry/repositry.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<NewsCubit>(() => NewsCubit(getIt()));
  getIt.registerLazySingleton<Repositry>(() => Repositry(getIt()));
  getIt.registerLazySingleton<ApiServices>(() => ApiServices());
}
