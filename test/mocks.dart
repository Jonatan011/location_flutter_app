import 'package:location_flutter_app/app/features/friends/domain/repository/friends_repository.dart';
import 'package:location_flutter_app/app/features/locations/domain/repository/locations_repository.dart';
import 'package:location_flutter_app/app/features/locations/presentation/state/location_validation_service.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  LocationsRepository,
  LocationValidationService,
  FriendsRepository,
])
void main() {}
