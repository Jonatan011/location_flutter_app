import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

part 'drift_database.g.dart'; // Este archivo será generado automáticamente

// Definición de la tabla de ubicaciones
class Locations extends Table {
  IntColumn get id => integer().autoIncrement()(); // ID único
  TextColumn get name => text().withLength(min: 1, max: 50)(); // Nombre único
  RealColumn get latitude => real()(); // Latitud
  RealColumn get longitude => real()(); // Longitud
  TextColumn get photos => text()(); // Lista de fotos como JSON
  TextColumn get description => text().nullable()(); // Descripción opcional
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))(); // Nuevo campo para favoritos
}

// Definición de la tabla de amigos
class Friends extends Table {
  IntColumn get id => integer().autoIncrement()(); // ID único
  TextColumn get firstName => text().withLength(min: 1, max: 50)(); // Primer nombre
  TextColumn get lastName => text().withLength(min: 1, max: 50)(); // Apellido
  TextColumn get email => text()(); // Correo electrónico
  TextColumn get phoneNumber => text()(); // Número de teléfono
  TextColumn get photo => text()(); // Foto
}

// Definición de la tabla de relaciones entre amigos y ubicaciones
class FriendLocationRelations extends Table {
  IntColumn get id => integer().autoIncrement()(); // ID único
  IntColumn get friendId => integer().customConstraint('REFERENCES friends(id) ON DELETE CASCADE NOT NULL')(); // Relación con amigos
  IntColumn get locationId => integer().customConstraint('REFERENCES locations(id) ON DELETE CASCADE NOT NULL')(); // Relación con ubicaciones
}

@DriftDatabase(tables: [Locations, Friends, FriendLocationRelations])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Consultas personalizadas para Locations
  Future<List<Location>> getAllLocations() => select(locations).get();
  Future<int> addLocation(Insertable<Location> location) => into(locations).insert(location);
  Future<int> deleteLocation(int id) => (delete(locations)..where((tbl) => tbl.id.equals(id))).go();

  // Consultas personalizadas para Friends
  Future<List<Friend>> getAllFriends() => select(friends).get();
  Future<int> addFriend(Insertable<Friend> friend) => into(friends).insert(friend);
  Future<int> deleteFriend(int id) => (delete(friends)..where((tbl) => tbl.id.equals(id))).go();

  // Consultas para relaciones
  Future<int> addFriendLocationRelation(Insertable<FriendLocationRelation> relation) => into(friendLocationRelations).insert(relation);

  Future<List<Location>> getLocationsForFriend(int friendId) {
    final query = select(locations).join([
      innerJoin(friendLocationRelations, friendLocationRelations.locationId.equalsExp(locations.id)),
    ])
      ..where(friendLocationRelations.friendId.equals(friendId));

    return query.map((row) => row.readTable(locations)).get();
  }

  Future<List<Friend>> getFriendsForLocation(int locationId) {
    final query = select(friends).join([
      innerJoin(friendLocationRelations, friendLocationRelations.friendId.equalsExp(friends.id)),
    ])
      ..where(friendLocationRelations.locationId.equals(locationId));

    return query.map((row) => row.readTable(friends)).get();
  }

  Future<List<Location>> getFavoriteLocations() {
    return (select(locations)..where((tbl) => tbl.isFavorite.equals(true))).get();
  }

  Future<int> toggleFavoriteStatus(int locationId, bool isFavorite) {
    return (update(locations)..where((tbl) => tbl.id.equals(locationId))).write(
      LocationsCompanion(
        isFavorite: Value(isFavorite),
      ),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File('${dbFolder.path}/app.db');
    return NativeDatabase(file);
  });
}
