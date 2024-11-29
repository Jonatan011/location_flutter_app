import 'package:drift/drift.dart';
import 'package:location_flutter_app/app/shared/database/drift_database.dart';

class LocationModel {
  final int? id;
  final String name;
  final double latitude;
  final double longitude;
  final List<String> photos;
  final String? description;
  final bool isFavorite;

  LocationModel({
    this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.photos,
    this.description,
    this.isFavorite = false,
  });

  // Método copyWith
  LocationModel copyWith({
    int? id,
    String? name,
    double? latitude,
    double? longitude,
    List<String>? photos,
    String? description,
    bool? isFavorite,
  }) {
    return LocationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      photos: photos ?? this.photos,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  // Convertir a Companion para Drift
  LocationsCompanion toCompanion() {
    return LocationsCompanion(
      name: Value(name),
      latitude: Value(latitude),
      longitude: Value(longitude),
      photos: Value(photos.join(',')), // Convierte de List a String
      description: Value(description),
    );
  }

  // Convertir desde entidad de Drift
  factory LocationModel.fromEntity(Location entity) {
    return LocationModel(
      id: entity.id,
      name: entity.name,
      latitude: entity.latitude,
      longitude: entity.longitude,
      photos: entity.photos.split(','), // Deserializar texto a lista
      description: entity.description,
      isFavorite: entity.isFavorite,
    );
  }
}
