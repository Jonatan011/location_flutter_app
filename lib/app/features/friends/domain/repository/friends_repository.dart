import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/features/friends/domain/entities/friend_model.dart';
import 'package:location_flutter_app/app/features/locations/domain/entities/location_model.dart';
import '../../../../shared/error/failure.dart';

abstract class FriendsRepository {
  // Métodos relacionados con amigos
  Future<Either<Failure, List<FriendModel>>> getAllFriends();
  Future<Either<Failure, void>> addFriend(FriendModel friend);
  Future<Either<Failure, void>> deleteFriend(int id);

  // Métodos relacionados con relaciones entre amigos y ubicaciones
  Future<Either<Failure, void>> assignLocationToFriend(int friendId, int locationId);
  Future<Either<Failure, List<LocationModel>>> getLocationsForFriend(int friendId);
  Future<Either<Failure, List<FriendModel>>> getFriendForLocation(int locationId);
}
