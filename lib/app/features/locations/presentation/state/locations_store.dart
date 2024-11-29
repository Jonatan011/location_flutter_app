import 'package:location_flutter_app/app/features/locations/domain/use_cases/get_favorites_use_case.dart';
import 'package:location_flutter_app/app/features/locations/domain/use_cases/toggle_favorite_use_case.dart';
import 'package:mobx/mobx.dart';
import 'package:location_flutter_app/app/features/locations/domain/use_cases/validations_use_case.dart';
import 'package:location_flutter_app/app/features/locations/domain/entities/location_model.dart';
import 'package:location_flutter_app/app/features/locations/domain/use_cases/get_locations_use_case.dart';
import 'package:location_flutter_app/app/features/locations/domain/use_cases/add_location_use_case.dart';
part 'locations_store.g.dart';

class LocationsStore = _LocationsStore with _$LocationsStore;

abstract class _LocationsStore with Store {
  final GetLocationsUseCase getLocationsUseCase;
  final AddLocationUseCase addLocationUseCase;
  final ValidateLocationUseCase validateLocationUseCase;
  final GetFavoriteLocationsUseCase getFavoriteLocationsUseCase;
  final ToggleFavoriteStatusUseCase toggleFavoriteStatusUseCase;

  _LocationsStore(
    this.getLocationsUseCase,
    this.addLocationUseCase,
    this.validateLocationUseCase,
    this.getFavoriteLocationsUseCase,
    this.toggleFavoriteStatusUseCase,
  );

  @observable
  ObservableList<LocationModel> locations = ObservableList();

  @observable
  ObservableList<String> photos = ObservableList();

  @observable
  ObservableList<LocationModel> favoriteLocations = ObservableList();

  @observable
  bool isFavoriteLoading = false;

  @observable
  bool isLoading = false;

  @observable
  ObservableList<LocationModel> filteredLocations = ObservableList();

  @observable
  String? errorMessage;

  @observable
  double? latitude;

  @observable
  double? longitude;

  @action
  Future<void> fetchLocations() async {
    setLoading(true);
    errorMessage = null;

    try {
      final result = await getLocationsUseCase();
      result.fold(
        (failure) {
          errorMessage = failure.toString();
        },
        (locationList) {
          locations = ObservableList.of(locationList);
        },
      );
    } catch (e) {
      errorMessage = 'Ocurrió un error al obtener las ubicaciones: $e';
    } finally {
      setLoading(false);
    }
  }

  @action
  Future<void> addLocation(LocationModel location) async {
    setLoading(true);
    errorMessage = null;

    try {
      final validation = await validateLocationUseCase(location, locations);
      validation.fold(
        (error) {
          errorMessage = error;
        },
        (_) async {
          final result = await addLocationUseCase(location);
          result.fold(
            (failure) => errorMessage = failure.toString(),
            (_) => fetchLocations(),
          );
        },
      );
    } catch (e) {
      errorMessage = 'Ocurrió un error al agregar la ubicación: $e';
    } finally {
      setLoading(false);
    }
  }

  @action
  void addPhotoWithLocation(String photoPath, double lat, double long) {
    if (photos.length < 3) {
      photos.add(photoPath);
      latitude = lat;
      longitude = long;
    } else {
      errorMessage = 'No puedes añadir más de 3 fotos.';
    }
  }

  @action
  void removePhoto(String photoPath) {
    photos.remove(photoPath);

    // Si no hay más fotos, limpiar latitud y longitud
    if (photos.isEmpty) {
      latitude = null;
      longitude = null;
    }
  }

  @action
  void searchLocation(String query) {
    if (query.isEmpty) {
      filteredLocations = ObservableList.of([...locations]);
    } else {
      final result = locations.where((location) => location.name.toLowerCase().contains(query.toLowerCase())).toList();

      filteredLocations = ObservableList.of(result);
    }
  }

  @action
  Future<void> fetchFavoriteLocations() async {
    setLoading(true);
    errorMessage = null;

    try {
      final result = await getFavoriteLocationsUseCase();
      result.fold(
        (failure) {
          errorMessage = failure.toString();
        },
        (favoritesList) {
          favoriteLocations = ObservableList.of(favoritesList);
        },
      );
    } catch (e) {
      errorMessage = 'Ocurrió un error al obtener las ubicaciones favoritas: $e';
    } finally {
      setLoading(false);
    }
  }

  @action
  Future<void> toggleFavorite(int locationId, bool isFavorite) async {
    isFavoriteLoading = true;
    errorMessage = null;

    try {
      final result = await toggleFavoriteStatusUseCase(locationId, isFavorite);
      result.fold(
        (failure) {
          errorMessage = failure.toString();
        },
        (_) {
          // Actualizar el estado en la lista general
          final index = locations.indexWhere((location) => location.id == locationId);
          if (index != -1) {
            locations[index] = locations[index].copyWith(isFavorite: !locations[index].isFavorite);
          }

          // Actualizar la lista de favoritos
          if (!isFavorite) {
            favoriteLocations.removeWhere((location) => location.id == locationId);
          } else {
            final updatedLocation = locations.firstWhere((location) => location.id == locationId);
            favoriteLocations.add(updatedLocation);
          }
        },
      );
    } catch (e) {
      errorMessage = 'Ocurrió un error al alternar el estado de favorito: $e';
    } finally {
      isFavoriteLoading = false;
    }
  }

  @action
  void resetState() {
    photos.clear();
    latitude = null;
    longitude = null;
    errorMessage = null;
  }

  @action
  Future<void> setLoading(bool value) async {
    isLoading = value;
  }

  @computed
  bool get hasError => errorMessage != null;

  @computed
  bool get isReadyToSubmit => photos.isNotEmpty && latitude != null && longitude != null;

  @computed
  List<LocationModel> get dynamicFavoriteLocations => locations.where((location) => location.isFavorite).toList();
}
