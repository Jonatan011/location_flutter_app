import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/features/locations/domain/use_cases/add_location_use_case.dart';
import 'package:location_flutter_app/app/features/locations/domain/entities/location_model.dart';
import 'package:location_flutter_app/app/shared/error/failure.dart';
import '../../../../mocks.mocks.dart';

void main() {
  late MockLocationsRepository mockLocationsRepository;
  late AddLocationUseCase addLocationUseCase;

  setUp(() {
    mockLocationsRepository = MockLocationsRepository();
    addLocationUseCase = AddLocationUseCase(mockLocationsRepository);
  });

  final location = LocationModel(
    name: 'Test Location',
    latitude: 10.0,
    longitude: 20.0,
    photos: [],
  );

  test('Should call repository to add location and return success', () async {
    when(mockLocationsRepository.addLocation(location)).thenAnswer((_) async => const Right(null));

    final result = await addLocationUseCase(location);

    expect(result, const Right(null));
    verify(mockLocationsRepository.addLocation(location)).called(1);
    verifyNoMoreInteractions(mockLocationsRepository);
  });

  test('Should call repository to add location and return failure', () async {
    final failure = Failure('Error al añadir ubicación');

    when(mockLocationsRepository.addLocation(location)).thenAnswer((_) async => Left(failure));

    final result = await addLocationUseCase(location);

    expect(result, Left(failure));
    verify(mockLocationsRepository.addLocation(location)).called(1);
    verifyNoMoreInteractions(mockLocationsRepository);
  });
}
