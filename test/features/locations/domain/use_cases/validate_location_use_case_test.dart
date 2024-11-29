import 'package:flutter_test/flutter_test.dart';
import 'package:location_flutter_app/app/features/locations/domain/use_cases/validations_use_case.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/features/locations/domain/entities/location_model.dart';
import '../../../../mocks.mocks.dart';

void main() {
  late MockLocationValidationService mockValidationService;
  late ValidateLocationUseCase validateLocationUseCase;

  setUp(() {
    mockValidationService = MockLocationValidationService();
    validateLocationUseCase = ValidateLocationUseCase(mockValidationService);
  });

  final location = LocationModel(
    name: 'Test Location',
    latitude: 10.0,
    longitude: 20.0,
    photos: ['photo1.jpg', 'photo2.jpg'],
  );

  final existingLocations = [
    LocationModel(name: 'Location 1', latitude: 10.1, longitude: 20.1, photos: []),
    LocationModel(name: 'Location 2', latitude: 10.2, longitude: 20.2, photos: []),
  ];

  test('Should fail validation if name is not unique', () async {
    when(mockValidationService.validateUniqueName(location.name, existingLocations)).thenReturn(const Left('El nombre ya existe.'));

    final result = await validateLocationUseCase(location, existingLocations);

    expect(result, const Left('El nombre ya existe.'));
    verify(mockValidationService.validateUniqueName(location.name, existingLocations)).called(1);
  });

  test('Should fail validation if coordinates are not unique', () async {
    when(mockValidationService.validateUniqueName(location.name, existingLocations)).thenReturn(const Right(true));
    when(mockValidationService.validateUniqueCoordinates(location.latitude, location.longitude, existingLocations))
        .thenReturn(const Left('Las coordenadas ya están registradas.'));

    final result = await validateLocationUseCase(location, existingLocations);

    expect(result, const Left('Las coordenadas ya están registradas.'));
    verify(mockValidationService.validateUniqueCoordinates(location.latitude, location.longitude, existingLocations)).called(1);
  });

  test('Should fail validation if location is within 500 meters', () async {
    when(mockValidationService.validateUniqueName(location.name, existingLocations)).thenReturn(const Right(true));
    when(mockValidationService.validateUniqueCoordinates(location.latitude, location.longitude, existingLocations)).thenReturn(const Right(true));
    when(mockValidationService.validateWithinRadius(location.latitude, location.longitude, existingLocations))
        .thenReturn(const Left('La ubicación está dentro de un radio de 500 metros.'));

    final result = await validateLocationUseCase(location, existingLocations);

    expect(result, const Left('La ubicación está dentro de un radio de 500 metros.'));
    verify(mockValidationService.validateWithinRadius(location.latitude, location.longitude, existingLocations)).called(1);
  });

  test('Should fail validation if photo limit is exceeded', () async {
    when(mockValidationService.validateUniqueName(location.name, existingLocations)).thenReturn(const Right(true));
    when(mockValidationService.validateUniqueCoordinates(location.latitude, location.longitude, existingLocations)).thenReturn(const Right(true));
    when(mockValidationService.validateWithinRadius(location.latitude, location.longitude, existingLocations)).thenReturn(const Right(true));
    when(mockValidationService.validatePhotoLimit(location.photos)).thenReturn(const Left('No se pueden añadir más de 3 fotos.'));

    final result = await validateLocationUseCase(location, existingLocations);

    expect(result, const Left('No se pueden añadir más de 3 fotos.'));
    verify(mockValidationService.validatePhotoLimit(location.photos)).called(1);
  });

  test('Should pass validation for a unique location', () async {
    when(mockValidationService.validateUniqueName(location.name, existingLocations)).thenReturn(const Right(true));
    when(mockValidationService.validateUniqueCoordinates(location.latitude, location.longitude, existingLocations)).thenReturn(const Right(true));
    when(mockValidationService.validateWithinRadius(location.latitude, location.longitude, existingLocations)).thenReturn(const Right(true));
    when(mockValidationService.validatePhotoLimit(location.photos)).thenReturn(const Right(true));

    final result = await validateLocationUseCase(location, existingLocations);

    expect(result, const Right(true));
    verify(mockValidationService.validateUniqueName(location.name, existingLocations)).called(1);
    verify(mockValidationService.validateUniqueCoordinates(location.latitude, location.longitude, existingLocations)).called(1);
    verify(mockValidationService.validateWithinRadius(location.latitude, location.longitude, existingLocations)).called(1);
    verify(mockValidationService.validatePhotoLimit(location.photos)).called(1);
  });
}
