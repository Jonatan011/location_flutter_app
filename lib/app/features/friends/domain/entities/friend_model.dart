import 'package:drift/drift.dart';
import 'package:location_flutter_app/app/shared/database/drift_database.dart';
import 'package:location_flutter_app/app/features/locations/domain/entities/location_model.dart';

class FriendModel {
  final int? id; // ID único (nullable para la creación)
  final String firstName; // Nombre
  final String lastName; // Apellido
  final String email; // Email
  final String phoneNumber; // Número de teléfono
  final String photo; // Ruta de la foto (opcional)
  final List<LocationModel> assignedLocations; // Ubicaciones asignadas

  const FriendModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.photo,
    this.assignedLocations = const [],
  });

  // Convertir desde la entidad (Drift)
  factory FriendModel.fromEntity(Friend entity, List<LocationModel>? locations) {
    return FriendModel(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      photo: entity.photo,
      assignedLocations: locations ?? [],
    );
  }
  // Convertir a Companion (Drift)
  FriendsCompanion toCompanion() {
    return FriendsCompanion(
      firstName: Value(firstName),
      lastName: Value(lastName),
      email: Value(email),
      phoneNumber: Value(phoneNumber),
      photo: Value(photo),
    );
  }
}
