import 'package:dartz/dartz.dart';
import '../entities/location_model.dart';
import '../repository/locations_repository.dart';
import '../../../../shared/error/failure.dart';

class GetFavoriteLocationsUseCase {
  final LocationsRepository repository;

  GetFavoriteLocationsUseCase(this.repository);

  Future<Either<Failure, List<LocationModel>>> call() {
    return repository.getFavoriteLocations();
  }
}
