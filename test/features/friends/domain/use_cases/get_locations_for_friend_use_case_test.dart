import 'package:flutter_test/flutter_test.dart';
import 'package:location_flutter_app/app/features/friends/domain/use_cases/get_location_for_friend_use_case.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/features/locations/domain/entities/location_model.dart';
import 'package:location_flutter_app/app/shared/error/failure.dart';
import '../../../../mocks.mocks.dart';

void main() {
  late MockFriendsRepository mockFriendsRepository;
  late GetLocationsForFriendUseCase getLocationsForFriendUseCase;

  setUp(() {
    mockFriendsRepository = MockFriendsRepository();
    getLocationsForFriendUseCase = GetLocationsForFriendUseCase(mockFriendsRepository);
  });

  const friendId = 1;

  final locations = [
    LocationModel(
      name: 'Test Location',
      latitude: 10.0,
      longitude: 20.0,
      photos: [],
    ),
  ];

  test('Should call repository to get locations for friend and return success', () async {
    when(mockFriendsRepository.getLocationsForFriend(friendId)).thenAnswer((_) async => Right(locations));

    final result = await getLocationsForFriendUseCase(friendId);

    expect(result, Right(locations));
    verify(mockFriendsRepository.getLocationsForFriend(friendId)).called(1);
    verifyNoMoreInteractions(mockFriendsRepository);
  });

  test('Should call repository to get locations for friend and return failure', () async {
    final failure = Failure('Error al obtener ubicaciones para el amigo');

    when(mockFriendsRepository.getLocationsForFriend(friendId)).thenAnswer((_) async => Left(failure));

    final result = await getLocationsForFriendUseCase(friendId);

    expect(result, Left(failure));
    verify(mockFriendsRepository.getLocationsForFriend(friendId)).called(1);
    verifyNoMoreInteractions(mockFriendsRepository);
  });
}
