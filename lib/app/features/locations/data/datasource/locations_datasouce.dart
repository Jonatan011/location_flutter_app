import 'package:location_flutter_app/app/features/locations/domain/entities/location_model.dart';
import 'package:location_flutter_app/app/shared/database/drift_database.dart';

class LocationsDatasource {
  final AppDatabase _db;

  LocationsDatasource(this._db);

  Future<List<Location>> getAllLocations() => _db.getAllLocations();

  Future<int> addLocation(LocationModel location) {
    // Convierte el modelo a un Companion
    final companion = location.toCompanion();
    return _db.addLocation(companion);
  }

  // Obtener ubicaciones favoritas
  Future<List<LocationModel>> getFavoriteLocations() async {
    final favorites = await _db.getFavoriteLocations();
    return favorites.map(LocationModel.fromEntity).toList();
  }

  // Alternar estado de favorito
  Future<int> toggleFavoriteStatus(int locationId, bool isFavorite) {
    return _db.toggleFavoriteStatus(locationId, isFavorite);
  }
}
