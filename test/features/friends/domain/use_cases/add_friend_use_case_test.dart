import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/features/friends/domain/use_cases/add_friend_use_case.dart';
import 'package:location_flutter_app/app/features/friends/domain/entities/friend_model.dart';
import 'package:location_flutter_app/app/shared/error/failure.dart';
import '../../../../mocks.mocks.dart';

void main() {
  late MockFriendsRepository mockFriendsRepository;
  late AddFriendUseCase addFriendUseCase;

  setUp(() {
    mockFriendsRepository = MockFriendsRepository();
    addFriendUseCase = AddFriendUseCase(mockFriendsRepository);
  });

  const friend = FriendModel(
    firstName: 'John',
    lastName: 'Doe',
    email: 'john.doe@example.com',
    phoneNumber: '1234567890',
    photo: 'photo_path.jpg',
  );

  test('Should call repository to add friend and return success', () async {
    when(mockFriendsRepository.addFriend(friend)).thenAnswer((_) async => const Right(null));

    final result = await addFriendUseCase(friend);

    expect(result, const Right(null));
    verify(mockFriendsRepository.addFriend(friend)).called(1);
    verifyNoMoreInteractions(mockFriendsRepository);
  });

  test('Should call repository to add friend and return failure', () async {
    final failure = Failure('Error al añadir amigo');

    when(mockFriendsRepository.addFriend(friend)).thenAnswer((_) async => Left(failure));

    final result = await addFriendUseCase(friend);

    expect(result, Left(failure));
    verify(mockFriendsRepository.addFriend(friend)).called(1);
    verifyNoMoreInteractions(mockFriendsRepository);
  });
}
