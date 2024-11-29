import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/features/locations/domain/entities/location_model.dart';

class LocationValidationService {
  // Validación del nombre único
  Either<String, bool> validateUniqueName(String name, List<LocationModel> existingLocations) {
    final exists = existingLocations.any((loc) => loc.name == name);
    return exists ? const Left('El nombre ya está en uso.') : const Right(true);
  }

  // Validación de coordenadas únicas
  Either<String, bool> validateUniqueCoordinates(double latitude, double longitude, List<LocationModel> existingLocations) {
    final exists = existingLocations.any((loc) => loc.latitude == latitude && loc.longitude == longitude);
    return exists ? const Left('Ya existe una ubicación con las mismas coordenadas.') : const Right(true);
  }

  // Validación de radio de 500 metros
  Either<String, bool> validateWithinRadius(
    double latitude,
    double longitude,
    List<LocationModel> existingLocations, {
    double radius = 500,
  }) {
    for (final loc in existingLocations) {
      final distance = _calculateDistance(latitude, longitude, loc.latitude, loc.longitude);
      if (distance <= radius) {
        return const Left('Ya existe una ubicación en un radio de 500 metros.');
      }
    }
    return const Right(true);
  }

  // Validación del máximo de fotos
  Either<String, bool> validatePhotoLimit(List<String> photos, {int maxPhotos = 3}) {
    return photos.length > maxPhotos ? const Left('No se pueden añadir más de 3 fotos.') : const Right(true);
  }

  // Cálculo de distancia entre dos puntos (en metros)
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const earthRadius = 6371000; // Radio de la Tierra en metros
    final dLat = _degToRad(lat2 - lat1);
    final dLon = _degToRad(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) + cos(_degToRad(lat1)) * cos(_degToRad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  // Convertir grados a radianes
  double _degToRad(double degree) => degree * pi / 180;
}
