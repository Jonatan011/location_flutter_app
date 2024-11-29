import 'package:get_it/get_it.dart';
import 'package:location_flutter_app/app/features/friends/data/datasource/friends_datasouce.dart';
import 'package:location_flutter_app/app/features/friends/data/repository/friends_repository_impl.dart';
import 'package:location_flutter_app/app/features/friends/domain/repository/friends_repository.dart';
import 'package:location_flutter_app/app/features/friends/domain/use_cases/add_friend_use_case.dart';
import 'package:location_flutter_app/app/features/friends/domain/use_cases/assign_location_to_friend_use_case.dart';
import 'package:location_flutter_app/app/features/friends/domain/use_cases/delete_friend_use_case.dart';
import 'package:location_flutter_app/app/features/friends/domain/use_cases/get_friend_for_location_use_case.dart';
import 'package:location_flutter_app/app/features/friends/domain/use_cases/get_friends_use_case.dart';
import 'package:location_flutter_app/app/features/friends/domain/use_cases/get_location_for_friend_use_case.dart';
import 'package:location_flutter_app/app/features/friends/presentation/state/friends_store.dart';
import 'package:location_flutter_app/app/features/locations/data/datasource/locations_datasouce.dart';
import 'package:location_flutter_app/app/features/locations/data/repository/locations_repository_impl.dart';
import 'package:location_flutter_app/app/features/locations/domain/repository/locations_repository.dart';
import 'package:location_flutter_app/app/features/locations/domain/use_cases/add_location_use_case.dart';
import 'package:location_flutter_app/app/features/locations/domain/use_cases/get_favorites_use_case.dart';
import 'package:location_flutter_app/app/features/locations/domain/use_cases/get_locations_use_case.dart';
import 'package:location_flutter_app/app/features/locations/domain/use_cases/toggle_favorite_use_case.dart';
import 'package:location_flutter_app/app/features/locations/domain/use_cases/validations_use_case.dart';
import 'package:location_flutter_app/app/features/locations/presentation/state/location_validation_service.dart';
import 'package:location_flutter_app/app/features/locations/presentation/state/locations_store.dart';
import 'package:location_flutter_app/app/features/navigator_screen/presentation/state/bottom_navigation_store.dart';
import 'package:location_flutter_app/app/shared/database/drift_database.dart';

final serviceLocator = GetIt.instance;
void setupServiceLocator() {
  // Database
  serviceLocator.registerLazySingleton<AppDatabase>(() => AppDatabase());

  serviceLocator.registerSingleton<BottomNavigationStore>(BottomNavigationStore());

  // Locations - Datasource
  serviceLocator.registerLazySingleton<LocationsDatasource>(
    () => LocationsDatasource(serviceLocator<AppDatabase>()),
  );

  // Locations - Repositorio
  serviceLocator.registerLazySingleton<LocationsRepository>(
    () => LocationsRepositoryImpl(serviceLocator<LocationsDatasource>()),
  );

  // Locations - Use case
  serviceLocator.registerFactory(
    () => GetLocationsUseCase(serviceLocator<LocationsRepository>()),
  );
  serviceLocator.registerFactory(
    () => AddLocationUseCase(serviceLocator<LocationsRepository>()),
  );
  serviceLocator.registerLazySingleton<LocationValidationService>(() => LocationValidationService());

  serviceLocator.registerFactory(
    () => ValidateLocationUseCase(serviceLocator<LocationValidationService>()),
  );

  serviceLocator.registerFactory(
    () => GetFavoriteLocationsUseCase(serviceLocator<LocationsRepository>()),
  );
  serviceLocator.registerFactory(
    () => ToggleFavoriteStatusUseCase(serviceLocator<LocationsRepository>()),
  );
  // Locations - Store
  serviceLocator.registerLazySingleton(() => LocationsStore(
        serviceLocator<GetLocationsUseCase>(),
        serviceLocator<AddLocationUseCase>(),
        serviceLocator<ValidateLocationUseCase>(),
        serviceLocator<GetFavoriteLocationsUseCase>(),
        serviceLocator<ToggleFavoriteStatusUseCase>(),
      ));

  // Friends - Datasource
  serviceLocator.registerLazySingleton<FriendsDatasource>(
    () => FriendsDatasource(serviceLocator<AppDatabase>()),
  );

  // Friends - Repository
  serviceLocator.registerLazySingleton<FriendsRepository>(
    () => FriendsRepositoryImpl(serviceLocator<FriendsDatasource>()),
  );

  // Friends - Use case
  serviceLocator.registerFactory(
    () => GetFriendsUseCase(serviceLocator<FriendsRepository>()),
  );
  serviceLocator.registerFactory(
    () => AddFriendUseCase(serviceLocator<FriendsRepository>()),
  );

  serviceLocator.registerFactory(
    () => DeleteFriendUseCase(serviceLocator<FriendsRepository>()),
  );

  serviceLocator.registerFactory(
    () => AssignLocationToFriendUseCase(serviceLocator<FriendsRepository>()),
  );
  serviceLocator.registerFactory(
    () => GetLocationsForFriendUseCase(serviceLocator<FriendsRepository>()),
  );

  serviceLocator.registerFactory(
    () => GetFriendsForLocationUseCase(serviceLocator<FriendsRepository>()),
  );
  // Friends - Store
  serviceLocator.registerLazySingleton(() => FriendsStore(
        serviceLocator<GetFriendsUseCase>(),
        serviceLocator<AddFriendUseCase>(),
        serviceLocator<DeleteFriendUseCase>(),
        serviceLocator<AssignLocationToFriendUseCase>(),
        serviceLocator<GetLocationsForFriendUseCase>(),
        serviceLocator<GetFriendsForLocationUseCase>(),
      ));
}
