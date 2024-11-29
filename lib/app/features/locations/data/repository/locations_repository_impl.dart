import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/features/locations/data/datasource/locations_datasouce.dart';
import 'package:location_flutter_app/app/features/locations/domain/entities/location_model.dart';
import 'package:location_flutter_app/app/features/locations/domain/repository/locations_repository.dart';
import 'package:location_flutter_app/app/shared/error/failure.dart';

class LocationsRepositoryImpl implements LocationsRepository {
  final LocationsDatasource datasource;

  LocationsRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<LocationModel>>> getAllLocation() async {
    try {
      final result = await datasource.getAllLocations();
      return Right(result.map((e) => LocationModel.fromEntity(e)).toList());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addLocation(LocationModel location) async {
    try {
      await datasource.addLocation(location);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LocationModel>>> getFavoriteLocations() async {
    try {
      final favorites = await datasource.getFavoriteLocations();
      return Right(favorites);
    } catch (e) {
      return Left(Failure('Error al obtener ubicaciones favoritas: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavoriteStatus(int locationId, bool isFavorite) async {
    try {
      await datasource.toggleFavoriteStatus(locationId, isFavorite);
      return const Right(null);
    } catch (e) {
      return Left(Failure('Error al alternar el estado de favorito: $e'));
    }
  }
}
