import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/features/friends/domain/use_cases/delete_friend_use_case.dart';
import 'package:location_flutter_app/app/shared/error/failure.dart';
import '../../../../mocks.mocks.dart';

void main() {
  late MockFriendsRepository mockFriendsRepository;
  late DeleteFriendUseCase deleteFriendUseCase;

  setUp(() {
    mockFriendsRepository = MockFriendsRepository();
    deleteFriendUseCase = DeleteFriendUseCase(mockFriendsRepository);
  });

  const friendId = 1;

  test('Should call repository to delete friend and return success', () async {
    when(mockFriendsRepository.deleteFriend(friendId)).thenAnswer((_) async => const Right(null));

    final result = await deleteFriendUseCase(friendId);

    expect(result, const Right(null));
    verify(mockFriendsRepository.deleteFriend(friendId)).called(1);
    verifyNoMoreInteractions(mockFriendsRepository);
  });

  test('Should call repository to delete friend and return failure', () async {
    final failure = Failure('Error al eliminar amigo');

    when(mockFriendsRepository.deleteFriend(friendId)).thenAnswer((_) async => Left(failure));

    final result = await deleteFriendUseCase(friendId);

    expect(result, Left(failure));
    verify(mockFriendsRepository.deleteFriend(friendId)).called(1);
    verifyNoMoreInteractions(mockFriendsRepository);
  });
}
