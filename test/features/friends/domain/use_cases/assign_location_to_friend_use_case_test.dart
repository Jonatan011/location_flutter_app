import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/features/friends/domain/use_cases/assign_location_to_friend_use_case.dart';
import 'package:location_flutter_app/app/shared/error/failure.dart';
import '../../../../mocks.mocks.dart';

void main() {
  late MockFriendsRepository mockFriendsRepository;
  late AssignLocationToFriendUseCase assignLocationToFriendUseCase;

  setUp(() {
    mockFriendsRepository = MockFriendsRepository();
    assignLocationToFriendUseCase = AssignLocationToFriendUseCase(mockFriendsRepository);
  });

  const friendId = 1;
  const locationId = 2;

  test('Should call repository to assign location to friend and return success', () async {
    when(mockFriendsRepository.assignLocationToFriend(friendId, locationId)).thenAnswer((_) async => const Right(null));

    final result = await assignLocationToFriendUseCase(friendId, locationId);

    expect(result, const Right(null));
    verify(mockFriendsRepository.assignLocationToFriend(friendId, locationId)).called(1);
    verifyNoMoreInteractions(mockFriendsRepository);
  });

  test('Should call repository to assign location to friend and return failure', () async {
    final failure = Failure('Error al asignar ubicación');

    when(mockFriendsRepository.assignLocationToFriend(friendId, locationId)).thenAnswer((_) async => Left(failure));

    final result = await assignLocationToFriendUseCase(friendId, locationId);

    expect(result, Left(failure));
    verify(mockFriendsRepository.assignLocationToFriend(friendId, locationId)).called(1);
    verifyNoMoreInteractions(mockFriendsRepository);
  });
}
