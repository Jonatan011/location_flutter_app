import 'package:flutter_test/flutter_test.dart';
import 'package:location_flutter_app/app/features/locations/domain/use_cases/toggle_favorite_use_case.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/shared/error/failure.dart';
import '../../../../mocks.mocks.dart';

void main() {
  late MockLocationsRepository mockLocationsRepository;
  late ToggleFavoriteStatusUseCase toggleFavoriteStatusUseCase;

  setUp(() {
    mockLocationsRepository = MockLocationsRepository();
    toggleFavoriteStatusUseCase = ToggleFavoriteStatusUseCase(mockLocationsRepository);
  });

  const locationId = 1;
  const isFavorite = true;

  test('Should call repository to toggle favorite status and return success', () async {
    // Arrange
    when(mockLocationsRepository.toggleFavoriteStatus(locationId, isFavorite)).thenAnswer((_) async => const Right(null));

    // Act
    final result = await toggleFavoriteStatusUseCase(locationId, isFavorite);

    // Assert
    expect(result, const Right(null));
    verify(mockLocationsRepository.toggleFavoriteStatus(locationId, isFavorite)).called(1);
    verifyNoMoreInteractions(mockLocationsRepository);
  });

  test('Should call repository to toggle favorite status and return failure', () async {
    // Arrange
    final failure = Failure('Error al alternar estado de favorito');

    when(mockLocationsRepository.toggleFavoriteStatus(locationId, isFavorite)).thenAnswer((_) async => Left(failure));

    // Act
    final result = await toggleFavoriteStatusUseCase(locationId, isFavorite);

    // Assert
    expect(result, Left(failure));
    verify(mockLocationsRepository.toggleFavoriteStatus(locationId, isFavorite)).called(1);
    verifyNoMoreInteractions(mockLocationsRepository);
  });
}
