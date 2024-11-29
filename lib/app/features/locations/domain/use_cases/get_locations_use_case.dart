import 'package:dartz/dartz.dart';
import '../repository/locations_repository.dart';
import '../entities/location_model.dart';
import '../../../../shared/error/failure.dart';

class GetLocationsUseCase {
  final LocationsRepository repository;

  GetLocationsUseCase(this.repository);

  Future<Either<Failure, List<LocationModel>>> call() {
    return repository.getAllLocation();
  }
}
