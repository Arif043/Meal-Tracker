
import 'package:meal_tracker/application/home/home_bloc.dart';
import 'package:meal_tracker/domain/repositories/food_repository.dart';
import 'package:meal_tracker/infrastructure/repositories/food_repository_impl.dart';
import 'package:meal_tracker/infrastructure/service/local_database_service.dart';
import 'package:meal_tracker/infrastructure/service/open_food_facts_api.dart';
import 'package:meal_tracker/infrastructure/service/sp_service.dart';
import 'package:get_it/get_it.dart';

import 'application/home/add/add_bloc.dart';
import 'application/target/target_bloc.dart';

final i = GetIt.I;

Future<void> init() async {

  // Services
  i.registerSingletonAsync<LocalDatabaseService>(() async {
    final service = LocalDatabaseService();
    await service.init();
    return service;
  });
  i.registerLazySingleton<SpService>(() => SpService());
  i.registerLazySingleton<OpenFoodFactsApi>(() => OpenFoodFactsApi());
  
  // Repositories
  i.registerSingletonWithDependencies<FoodRepository>(() => FoodRepositoryImpl(i<OpenFoodFactsApi>(), i<LocalDatabaseService>()), dependsOn: [LocalDatabaseService]);

  //Blocs
  i.registerFactory<HomeBloc>(() => HomeBloc(i<FoodRepository>()));
  i.registerFactory<AddBloc>(() => AddBloc(i<FoodRepository>()));
  i.registerFactory<TargetBloc>(() => TargetBloc(i<SpService>()));

  await i.allReady();
}