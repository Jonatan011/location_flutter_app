import 'package:drift/drift.dart';
import 'package:location_flutter_app/app/features/friends/domain/entities/friend_model.dart';
import 'package:location_flutter_app/app/shared/database/drift_database.dart';

class FriendsDatasource {
  final AppDatabase database;

  FriendsDatasource(this.database);

  // Obtener todos los amigos
  Future<List<Friend>> getAllFriends() => database.getAllFriends();

  // Agregar un amigo
  Future<int> addFriend(FriendModel friend) {
    // Convierte el modelo a un Companion para insertar
    final companion = friend.toCompanion();
    return database.addFriend(companion);
  }

  // Eliminar un amigo (se eliminarán automáticamente las relaciones asociadas por ON DELETE CASCADE)
  Future<int> deleteFriend(int id) => database.deleteFriend(id);

  // Obtener ubicaciones asociadas a un amigo
  Future<List<Location>> getLocationsForFriend(int friendId) => database.getLocationsForFriend(friendId);

  // Obtener ubicaciones asociadas a un amigo
  Future<List<Friend>> getFriendForLocation(int location) => database.getFriendsForLocation(location);

  // Asignar una ubicación a un amigo
  Future<int> assignLocationToFriend(int friendId, int locationId) => database.addFriendLocationRelation(
        FriendLocationRelationsCompanion(
          friendId: Value(friendId),
          locationId: Value(locationId),
        ),
      );

  // Eliminar una relación entre un amigo y una ubicación específica
  Future<int> removeLocationFromFriend(int friendId, int locationId) {
    return (database.delete(database.friendLocationRelations)..where((tbl) => tbl.friendId.equals(friendId) & tbl.locationId.equals(locationId)))
        .go();
  }
}
