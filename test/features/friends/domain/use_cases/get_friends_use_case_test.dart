import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/features/friends/domain/use_cases/get_friends_use_case.dart';
import 'package:location_flutter_app/app/features/friends/domain/entities/friend_model.dart';
import 'package:location_flutter_app/app/shared/error/failure.dart';
import '../../../../mocks.mocks.dart';

void main() {
  late MockFriendsRepository mockFriendsRepository;
  late GetFriendsUseCase getFriendsUseCase;

  setUp(() {
    mockFriendsRepository = MockFriendsRepository();
    getFriendsUseCase = GetFriendsUseCase(mockFriendsRepository);
  });

  final friends = [
    const FriendModel(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      phoneNumber: '1234567890',
      photo: 'photo1.jpg',
    ),
    const FriendModel(
      firstName: 'Jane',
      lastName: 'Smith',
      email: 'jane.smith@example.com',
      phoneNumber: '0987654321',
      photo: 'photo2.jpg',
    ),
  ];

  test('Should call repository to get friends and return success', () async {
    when(mockFriendsRepository.getAllFriends()).thenAnswer((_) async => Right(friends));

    final result = await getFriendsUseCase();

    expect(result, Right(friends));
    verify(mockFriendsRepository.getAllFriends()).called(1);
    verifyNoMoreInteractions(mockFriendsRepository);
  });

  test('Should call repository to get friends and return failure', () async {
    final failure = Failure('Error al obtener amigos');

    when(mockFriendsRepository.getAllFriends()).thenAnswer((_) async => Left(failure));

    final result = await getFriendsUseCase();

    expect(result, Left(failure));
    verify(mockFriendsRepository.getAllFriends()).called(1);
    verifyNoMoreInteractions(mockFriendsRepository);
  });
}
