import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/features/friends/domain/entities/friend_model.dart';
import 'package:location_flutter_app/app/features/friends/domain/repository/friends_repository.dart';
import 'package:location_flutter_app/app/shared/error/failure.dart';

class GetFriendsForLocationUseCase {
  final FriendsRepository repository;

  GetFriendsForLocationUseCase(this.repository);

  Future<Either<Failure, List<FriendModel>>> call(int locationId) {
    return repository.getFriendForLocation(locationId);
  }
}
