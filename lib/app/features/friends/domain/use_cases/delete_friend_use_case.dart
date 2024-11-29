import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/shared/error/failure.dart';
import '../repository/friends_repository.dart';

class DeleteFriendUseCase {
  final FriendsRepository repository;

  DeleteFriendUseCase(this.repository);

  Future<Either<Failure, void>> call(int friendId) async {
    return repository.deleteFriend(friendId);
  }
}
