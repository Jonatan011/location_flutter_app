import 'package:dartz/dartz.dart';
import 'package:location_flutter_app/app/features/locations/presentation/state/location_validation_service.dart';
import '../entities/location_model.dart';

class ValidateLocationUseCase {
  final LocationValidationService validationService;

  ValidateLocationUseCase(this.validationService);

  Future<Either<String, bool>> call(LocationModel location, List<LocationModel> existingLocations) async {
    // Validar nombre único
    final nameValidation = validationService.validateUniqueName(location.name, existingLocations);
    if (nameValidation.isLeft()) return nameValidation;

    // Validar coordenadas únicas
    final coordinateValidation = validationService.validateUniqueCoordinates(location.latitude, location.longitude, existingLocations);
    if (coordinateValidation.isLeft()) return coordinateValidation;

    // Validar radio de 500 metros
    final radiusValidation = validationService.validateWithinRadius(location.latitude, location.longitude, existingLocations);
    if (radiusValidation.isLeft()) return radiusValidation;

    // Validar límite de fotos
    final photoValidation = validationService.validatePhotoLimit(location.photos);
    if (photoValidation.isLeft()) return photoValidation;

    return const Right(true); // Todo válido
  }
}
