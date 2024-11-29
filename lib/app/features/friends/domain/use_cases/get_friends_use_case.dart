import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/features/friends/domain/entities/friend_model.dart';
import 'package:location_flutter_app/app/features/friends/domain/repository/friends_repository.dart';
import '../../../../shared/error/failure.dart';

class GetFriendsUseCase {
  final FriendsRepository repository;

  GetFriendsUseCase(this.repository);

  Future<Either<Failure, List<FriendModel>>> call() {
    return repository.getAllFriends();
  }
}
