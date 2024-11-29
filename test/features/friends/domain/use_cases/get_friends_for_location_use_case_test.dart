import 'package:flutter_test/flutter_test.dart';
import 'package:location_flutter_app/app/features/friends/domain/use_cases/get_friend_for_location_use_case.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/features/friends/domain/entities/friend_model.dart';
import 'package:location_flutter_app/app/shared/error/failure.dart';
import '../../../../mocks.mocks.dart';

void main() {
  late MockFriendsRepository mockFriendsRepository;
  late GetFriendsForLocationUseCase getFriendsForLocationUseCase;

  setUp(() {
    mockFriendsRepository = MockFriendsRepository();
    getFriendsForLocationUseCase = GetFriendsForLocationUseCase(mockFriendsRepository);
  });

  const locationId = 1;

  final friends = [
    const FriendModel(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      phoneNumber: '1234567890',
      photo: 'photo1.jpg',
    ),
  ];

  test('Should call repository to get friends for location and return success', () async {
    when(mockFriendsRepository.getFriendForLocation(locationId)).thenAnswer((_) async => Right(friends));

    final result = await getFriendsForLocationUseCase(locationId);

    expect(result, Right(friends));
    verify(mockFriendsRepository.getFriendForLocation(locationId)).called(1);
    verifyNoMoreInteractions(mockFriendsRepository);
  });

  test('Should call repository to get friends for location and return failure', () async {
    final failure = Failure('Error al obtener amigos para la ubicación');

    when(mockFriendsRepository.getFriendForLocation(locationId)).thenAnswer((_) async => Left(failure));

    final result = await getFriendsForLocationUseCase(locationId);

    expect(result, Left(failure));
    verify(mockFriendsRepository.getFriendForLocation(locationId)).called(1);
    verifyNoMoreInteractions(mockFriendsRepository);
  });
}
