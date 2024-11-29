import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/features/friends/domain/repository/friends_repository.dart';
import 'package:location_flutter_app/app/shared/error/failure.dart';

class AssignLocationToFriendUseCase {
  final FriendsRepository repository;

  AssignLocationToFriendUseCase(this.repository);

  Future<Either<Failure, void>> call(int friendId, int locationId) async {
    return repository.assignLocationToFriend(friendId, locationId);
  }
}
