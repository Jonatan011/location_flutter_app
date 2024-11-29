import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/features/locations/domain/entities/location_model.dart';
import 'package:location_flutter_app/app/features/locations/domain/repository/locations_repository.dart';

import '../../../../shared/error/failure.dart';

class AddLocationUseCase {
  final LocationsRepository repository;

  AddLocationUseCase(this.repository);

  Future<Either<Failure, void>> call(LocationModel location) {
    return repository.addLocation(location);
  }
}
