import 'package:dartz/dartz.dart';
import '../repository/locations_repository.dart';
import '../../../../shared/error/failure.dart';

class ToggleFavoriteStatusUseCase {
  final LocationsRepository repository;

  ToggleFavoriteStatusUseCase(this.repository);

  Future<Either<Failure, void>> call(int locationId, bool isFavorite) {
    return repository.toggleFavoriteStatus(locationId, isFavorite);
  }
}
