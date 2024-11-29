import 'package:flutter_test/flutter_test.dart';
import 'package:location_flutter_app/app/features/locations/domain/use_cases/get_favorites_use_case.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/features/locations/domain/entities/location_model.dart';
import 'package:location_flutter_app/app/shared/error/failure.dart';

import '../../../../mocks.mocks.dart';

void main() {
  late MockLocationsRepository mockLocationsRepository;
  late GetFavoriteLocationsUseCase getFavoriteLocationsUseCase;

  setUp(() {
    mockLocationsRepository = MockLocationsRepository();
    getFavoriteLocationsUseCase = GetFavoriteLocationsUseCase(mockLocationsRepository);
  });

  final favoriteLocations = [
    LocationModel(id: 1, name: 'Location 1', latitude: 10.0, longitude: 20.0, isFavorite: true, photos: []),
    LocationModel(id: 2, name: 'Location 2', latitude: 15.0, longitude: 25.0, isFavorite: true, photos: []),
  ];

  test('Should call repository to get favorite locations and return success', () async {
    // Arrange
    when(mockLocationsRepository.getFavoriteLocations()).thenAnswer((_) async => Right(favoriteLocations));

    // Act
    final result = await getFavoriteLocationsUseCase();

    // Assert
    expect(result, Right(favoriteLocations));
    verify(mockLocationsRepository.getFavoriteLocations()).called(1);
    verifyNoMoreInteractions(mockLocationsRepository);
  });

  test('Should call repository to get favorite locations and return failure', () async {
    // Arrange
    final failure = Failure('Error al obtener ubicaciones favoritas');

    when(mockLocationsRepository.getFavoriteLocations()).thenAnswer((_) async => Left(failure));

    // Act
    final result = await getFavoriteLocationsUseCase();

    // Assert
    expect(result, Left(failure));
    verify(mockLocationsRepository.getFavoriteLocations()).called(1);
    verifyNoMoreInteractions(mockLocationsRepository);
  });
}
