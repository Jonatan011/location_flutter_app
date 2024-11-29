import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/features/locations/domain/entities/location_model.dart';
import 'package:location_flutter_app/app/features/friends/domain/repository/friends_repository.dart';
import 'package:location_flutter_app/app/shared/error/failure.dart';

class GetLocationsForFriendUseCase {
  final FriendsRepository repository;

  GetLocationsForFriendUseCase(this.repository);

  Future<Either<Failure, List<LocationModel>>> call(int friendId) async {
    return repository.getLocationsForFriend(friendId);
  }
}
