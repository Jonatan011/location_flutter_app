import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/features/locations/domain/entities/location_model.dart';
import 'package:location_flutter_app/app/shared/error/failure.dart';

abstract class LocationsRepository {
  Future<Either<Failure, void>> addLocation(LocationModel location);
  Future<Either<Failure, List<LocationModel>>> getAllLocation();
  Future<Either<Failure, List<LocationModel>>> getFavoriteLocations();
  Future<Either<Failure, void>> toggleFavoriteStatus(int locationId, bool isFavorite);
}
