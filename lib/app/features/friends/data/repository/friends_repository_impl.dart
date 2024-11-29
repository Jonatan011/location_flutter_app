import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/features/friends/data/datasource/friends_datasouce.dart';
import 'package:location_flutter_app/app/features/friends/domain/entities/friend_model.dart';
import 'package:location_flutter_app/app/features/locations/domain/entities/location_model.dart';
import 'package:location_flutter_app/app/features/friends/domain/repository/friends_repository.dart';
import 'package:location_flutter_app/app/shared/error/failure.dart';

class FriendsRepositoryImpl implements FriendsRepository {
  final FriendsDatasource datasource;

  FriendsRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<FriendModel>>> getAllFriends() async {
    try {
      final result = await datasource.getAllFriends();

      // Obtener ubicaciones asociadas para cada amigo
      final friendsWithLocations = await Future.wait(result.map((friend) async {
        final locations = await datasource.getLocationsForFriend(friend.id);
        return FriendModel.fromEntity(
          friend,
          locations.map((location) => LocationModel.fromEntity(location)).toList(),
        );
      }));

      return Right(friendsWithLocations);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addFriend(FriendModel friend) async {
    try {
      await datasource.addFriend(friend);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFriend(int id) async {
    try {
      await datasource.deleteFriend(id);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> assignLocationToFriend(int friendId, int locationId) async {
    try {
      await datasource.assignLocationToFriend(friendId, locationId);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LocationModel>>> getLocationsForFriend(int friendId) async {
    try {
      final result = await datasource.getLocationsForFriend(friendId);
      return Right(result.map((location) => LocationModel.fromEntity(location)).toList());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FriendModel>>> getFriendForLocation(int locationId) async {
    try {
      final result = await datasource.getFriendForLocation(locationId);
      return Right(result.map((friend) => FriendModel.fromEntity(friend, null)).toList());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
