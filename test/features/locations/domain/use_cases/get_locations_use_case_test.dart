import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/features/locations/domain/use_cases/get_locations_use_case.dart';
import 'package:location_flutter_app/app/features/locations/domain/entities/location_model.dart';
import 'package:location_flutter_app/app/shared/error/failure.dart';
import '../../../../mocks.mocks.dart';

void main() {
  late MockLocationsRepository mockLocationsRepository;
  late GetLocationsUseCase getLocationsUseCase;

  setUp(() {
    mockLocationsRepository = MockLocationsRepository();
    getLocationsUseCase = GetLocationsUseCase(mockLocationsRepository);
  });

  final locations = [
    LocationModel(name: 'Location 1', latitude: 10.1, longitude: 20.1, photos: []),
    LocationModel(name: 'Location 2', latitude: 15.5, longitude: 25.3, photos: []),
  ];

  test('Should call repository to get locations and return success', () async {
    when(mockLocationsRepository.getAllLocation()).thenAnswer((_) async => Right(locations));

    final result = await getLocationsUseCase();

    expect(result, Right(locations));
    verify(mockLocationsRepository.getAllLocation()).called(1);
    verifyNoMoreInteractions(mockLocationsRepository);
  });

  test('Should call repository to get locations and return failure', () async {
    final failure = Failure('Error al obtener ubicaciones');

    when(mockLocationsRepository.getAllLocation()).thenAnswer((_) async => Left(failure));

    final result = await getLocationsUseCase();

    expect(result, Left(failure));
    verify(mockLocationsRepository.getAllLocation()).called(1);
    verifyNoMoreInteractions(mockLocationsRepository);
  });
}
