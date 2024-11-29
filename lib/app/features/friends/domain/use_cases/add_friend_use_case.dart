import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/features/friends/domain/entities/friend_model.dart';
import 'package:location_flutter_app/app/features/friends/domain/repository/friends_repository.dart';
import '../../../../shared/error/failure.dart';

class AddFriendUseCase {
  final FriendsRepository repository;

  AddFriendUseCase(this.repository);

  Future<Either<Failure, void>> call(FriendModel friend) {
    return repository.addFriend(friend);
  }
}
