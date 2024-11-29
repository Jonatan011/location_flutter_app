// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LocationsStore on _LocationsStore, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_LocationsStore.hasError'))
          .value;
  Computed<bool>? _$isReadyToSubmitComputed;

  @override
  bool get isReadyToSubmit =>
      (_$isReadyToSubmitComputed ??= Computed<bool>(() => super.isReadyToSubmit,
              name: '_LocationsStore.isReadyToSubmit'))
          .value;
  Computed<List<LocationModel>>? _$dynamicFavoriteLocationsComputed;

  @override
  List<LocationModel> get dynamicFavoriteLocations =>
      (_$dynamicFavoriteLocationsComputed ??= Computed<List<LocationModel>>(
              () => super.dynamicFavoriteLocations,
              name: '_LocationsStore.dynamicFavoriteLocations'))
          .value;

  late final _$locationsAtom =
      Atom(name: '_LocationsStore.locations', context: context);

  @override
  ObservableList<LocationModel> get locations {
    _$locationsAtom.reportRead();
    return super.locations;
  }

  @override
  set locations(ObservableList<LocationModel> value) {
    _$locationsAtom.reportWrite(value, super.locations, () {
      super.locations = value;
    });
  }

  late final _$photosAtom =
      Atom(name: '_LocationsStore.photos', context: context);

  @override
  ObservableList<String> get photos {
    _$photosAtom.reportRead();
    return super.photos;
  }

  @override
  set photos(ObservableList<String> value) {
    _$photosAtom.reportWrite(value, super.photos, () {
      super.photos = value;
    });
  }

  late final _$favoriteLocationsAtom =
      Atom(name: '_LocationsStore.favoriteLocations', context: context);

  @override
  ObservableList<LocationModel> get favoriteLocations {
    _$favoriteLocationsAtom.reportRead();
    return super.favoriteLocations;
  }

  @override
  set favoriteLocations(ObservableList<LocationModel> value) {
    _$favoriteLocationsAtom.reportWrite(value, super.favoriteLocations, () {
      super.favoriteLocations = value;
    });
  }

  late final _$isFavoriteLoadingAtom =
      Atom(name: '_LocationsStore.isFavoriteLoading', context: context);

  @override
  bool get isFavoriteLoading {
    _$isFavoriteLoadingAtom.reportRead();
    return super.isFavoriteLoading;
  }

  @override
  set isFavoriteLoading(bool value) {
    _$isFavoriteLoadingAtom.reportWrite(value, super.isFavoriteLoading, () {
      super.isFavoriteLoading = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_LocationsStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$filteredLocationsAtom =
      Atom(name: '_LocationsStore.filteredLocations', context: context);

  @override
  ObservableList<LocationModel> get filteredLocations {
    _$filteredLocationsAtom.reportRead();
    return super.filteredLocations;
  }

  @override
  set filteredLocations(ObservableList<LocationModel> value) {
    _$filteredLocationsAtom.reportWrite(value, super.filteredLocations, () {
      super.filteredLocations = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_LocationsStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$latitudeAtom =
      Atom(name: '_LocationsStore.latitude', context: context);

  @override
  double? get latitude {
    _$latitudeAtom.reportRead();
    return super.latitude;
  }

  @override
  set latitude(double? value) {
    _$latitudeAtom.reportWrite(value, super.latitude, () {
      super.latitude = value;
    });
  }

  late final _$longitudeAtom =
      Atom(name: '_LocationsStore.longitude', context: context);

  @override
  double? get longitude {
    _$longitudeAtom.reportRead();
    return super.longitude;
  }

  @override
  set longitude(double? value) {
    _$longitudeAtom.reportWrite(value, super.longitude, () {
      super.longitude = value;
    });
  }

  late final _$fetchLocationsAsyncAction =
      AsyncAction('_LocationsStore.fetchLocations', context: context);

  @override
  Future<void> fetchLocations() {
    return _$fetchLocationsAsyncAction.run(() => super.fetchLocations());
  }

  late final _$addLocationAsyncAction =
      AsyncAction('_LocationsStore.addLocation', context: context);

  @override
  Future<void> addLocation(LocationModel location) {
    return _$addLocationAsyncAction.run(() => super.addLocation(location));
  }

  late final _$fetchFavoriteLocationsAsyncAction =
      AsyncAction('_LocationsStore.fetchFavoriteLocations', context: context);

  @override
  Future<void> fetchFavoriteLocations() {
    return _$fetchFavoriteLocationsAsyncAction
        .run(() => super.fetchFavoriteLocations());
  }

  late final _$toggleFavoriteAsyncAction =
      AsyncAction('_LocationsStore.toggleFavorite', context: context);

  @override
  Future<void> toggleFavorite(int locationId, bool isFavorite) {
    return _$toggleFavoriteAsyncAction
        .run(() => super.toggleFavorite(locationId, isFavorite));
  }

  late final _$setLoadingAsyncAction =
      AsyncAction('_LocationsStore.setLoading', context: context);

  @override
  Future<void> setLoading(bool value) {
    return _$setLoadingAsyncAction.run(() => super.setLoading(value));
  }

  late final _$_LocationsStoreActionController =
      ActionController(name: '_LocationsStore', context: context);

  @override
  void addPhotoWithLocation(String photoPath, double lat, double long) {
    final _$actionInfo = _$_LocationsStoreActionController.startAction(
        name: '_LocationsStore.addPhotoWithLocation');
    try {
      return super.addPhotoWithLocation(photoPath, lat, long);
    } finally {
      _$_LocationsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removePhoto(String photoPath) {
    final _$actionInfo = _$_LocationsStoreActionController.startAction(
        name: '_LocationsStore.removePhoto');
    try {
      return super.removePhoto(photoPath);
    } finally {
      _$_LocationsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void searchLocation(String query) {
    final _$actionInfo = _$_LocationsStoreActionController.startAction(
        name: '_LocationsStore.searchLocation');
    try {
      return super.searchLocation(query);
    } finally {
      _$_LocationsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetState() {
    final _$actionInfo = _$_LocationsStoreActionController.startAction(
        name: '_LocationsStore.resetState');
    try {
      return super.resetState();
    } finally {
      _$_LocationsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
locations: ${locations},
photos: ${photos},
favoriteLocations: ${favoriteLocations},
isFavoriteLoading: ${isFavoriteLoading},
isLoading: ${isLoading},
filteredLocations: ${filteredLocations},
errorMessage: ${errorMessage},
latitude: ${latitude},
longitude: ${longitude},
hasError: ${hasError},
isReadyToSubmit: ${isReadyToSubmit},
dynamicFavoriteLocations: ${dynamicFavoriteLocations}
    ''';
  }
}
