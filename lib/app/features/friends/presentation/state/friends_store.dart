import 'dart:async';

import 'package:location_flutter_app/app/features/friends/domain/use_cases/delete_friend_use_case.dart';
import 'package:location_flutter_app/app/features/friends/domain/use_cases/assign_location_to_friend_use_case.dart';
import 'package:location_flutter_app/app/features/friends/domain/use_cases/get_friend_for_location_use_case.dart';
import 'package:location_flutter_app/app/features/friends/domain/use_cases/get_location_for_friend_use_case.dart';
import 'package:location_flutter_app/app/features/locations/domain/entities/location_model.dart';
import 'package:mobx/mobx.dart';
import '../../domain/entities/friend_model.dart';
import '../../domain/use_cases/add_friend_use_case.dart';
import '../../domain/use_cases/get_friends_use_case.dart';

part 'friends_store.g.dart';

class FriendsStore = _FriendsStore with _$FriendsStore;

abstract class _FriendsStore with Store {
  final GetFriendsUseCase getFriendsUseCase;
  final AddFriendUseCase addFriendUseCase;
  final DeleteFriendUseCase deleteFriendUseCase;
  final AssignLocationToFriendUseCase assignLocationToFriendUseCase;
  final GetLocationsForFriendUseCase getLocationsForFriendUseCase;
  final GetFriendsForLocationUseCase getFriendsForLocationUseCase;

  _FriendsStore(
    this.getFriendsUseCase,
    this.addFriendUseCase,
    this.deleteFriendUseCase,
    this.assignLocationToFriendUseCase,
    this.getLocationsForFriendUseCase,
    this.getFriendsForLocationUseCase,
  );

  @observable
  ObservableList<FriendModel> friends = ObservableList();

  @observable
  ObservableList<LocationModel> locationsForFriend = ObservableList();

  @observable
  ObservableList<FriendModel> friendsForlocations = ObservableList();

  @observable
  String photo = '';

  @observable
  bool isLoading = false;

  @observable
  ObservableList<FriendModel> filteredFriends = ObservableList();

  @observable
  ObservableList<int> selectedLocations = ObservableList<int>();

  @observable
  String? errorMessage;

  @computed
  bool get hasError => errorMessage != null;

  @computed
  bool get canAddFriend => friends.length < 5;

  @action
  Future<void> fetchFriends() async {
    errorMessage = null;
    _setLoading(true);
    final result = await getFriendsUseCase();
    result.fold(
      (failure) => _setError(failure.toString()),
      (friendsList) {
        friends = ObservableList.of(friendsList);
        filteredFriends = ObservableList.of(friendsList);
      },
    );
    _setLoading(false);
  }

  @action
  Future<void> fetchLocationsForFriend(int friendId) async {
    errorMessage = null;

    _setLoading(true);
    final result = await getLocationsForFriendUseCase(friendId);
    result.fold(
      (failure) => _setError(failure.toString()),
      (locations) => locationsForFriend = ObservableList.of(locations),
    );
    _setLoading(false);
  }

  @action
  Future<void> fetchFriendsForLocations(int locationId) async {
    errorMessage = null;

    _setLoading(true);
    final result = await getFriendsForLocationUseCase(locationId);
    result.fold(
      (failure) => _setError(failure.toString()),
      (locations) => friendsForlocations = ObservableList.of(locations),
    );
    _setLoading(false);
  }

  @action
  Future<void> addFriend(FriendModel friend) async {
    if (!canAddFriend) {
      _setError("Solo se pueden añadir un máximo de 5 amigos.");
      return;
    }

    _setLoading(true);

    final completer = Completer<void>(); // Para esperar a que todo se complete

    final result = await addFriendUseCase(friend);
    result.fold(
      (failure) {
        _setError(failure.toString());
        completer.complete(); // Completa incluso en caso de error
      },
      (_) async {
        await fetchFriends();
        try {
          // Asegúrate de que friends no esté vacío
          if (friends.isNotEmpty) {
            final newFriend = friends.lastWhere(
              (f) => f.firstName == friend.firstName && f.lastName == friend.lastName,
              orElse: () => throw Exception('Amigo no encontrado después de agregarlo.'),
            );
            // Asigna las ubicaciones al nuevo amigo
            await assignLocationsToFriend(newFriend.id!);
          }
        } catch (e) {
          _setError("Error al buscar el nuevo amigo: $e");
        } finally {
          completer.complete(); // Completa cuando todo se haya procesado
        }
      },
    );

    await completer.future; // Espera hasta que todo se haya completado
    _setLoading(false);
  }

  @action
  Future<void> assignLocationsToFriend(int friendId) async {
    _setLoading(true);
    errorMessage = null;

    try {
      // Validar el número actual de ubicaciones asignadas
      final currentLocationsResult = await getLocationsForFriendUseCase(friendId);
      final currentLocations = currentLocationsResult.fold(
        (failure) {
          _setError("Error al obtener ubicaciones actuales: ${failure.toString()}");
          return null;
        },
        (locations) => locations,
      );

      // Si ocurrió un error al obtener las ubicaciones actuales, detener el flujo
      if (currentLocations == null) {
        return;
      }

      // Verificar límite de ubicaciones
      if (currentLocations.length + selectedLocations.length > 5) {
        _setError("Un amigo no puede tener más de 5 ubicaciones asignadas.");
        return;
      }

      // Ejecutar las asignaciones en paralelo y esperar a que todas se completen
      final assignFutures = selectedLocations.map((locationId) async {
        final result = await assignLocationToFriendUseCase(friendId, locationId);
        result.fold(
          (failure) {
            // Registrar el error, pero no detener el flujo
            _setError("Error al asignar ubicación ID $locationId: ${failure.toString()}");
          },
          (_) => null,
        );
      }).toList();

      await Future.wait(assignFutures);

      // Actualizar la lista de ubicaciones asignadas para el amigo
      await fetchLocationsForFriend(friendId);
    } catch (e) {
      _setError("Error inesperado al asignar ubicaciones: $e");
    } finally {
      _setLoading(false);
    }
  }

  @action
  Future<void> fetchLocationsForFriendAndUpdateUI(int friendId) async {
    errorMessage = null;
    _setLoading(true);

    try {
      // Obtener ubicaciones asociadas
      final result = await getLocationsForFriendUseCase(friendId);

      result.fold(
        (failure) {
          _setError(failure.toString());
        },
        (locations) {
          locationsForFriend = ObservableList.of(locations);
        },
      );
    } catch (e) {
      _setError("Error al obtener ubicaciones para el amigo: $e");
    } finally {
      _setLoading(false);
    }
  }

  @action
  void resetState() {
    selectedLocations.clear();
    photo = '';
    errorMessage = null;
  }

  @action
  Future<void> deleteFriend(int friendId) async {
    errorMessage = null;

    _setLoading(true);
    final result = await deleteFriendUseCase(friendId);
    result.fold(
      (failure) => _setError(failure.toString()),
      (_) => fetchFriends(),
    );
    _setLoading(false);
  }

  @action
  void setPhoto(String photoPath) {
    photo = photoPath;
  }

  @action
  void clearError() {
    errorMessage = null;
  }

  // Métodos auxiliares para gestionar estados y errores
  @action
  void _setLoading(bool value) {
    isLoading = value;
  }

// Métodos auxiliares para gestionar ubicaciones seleccionadas
  @action
  void addLocation(int locationId) {
    if (!selectedLocations.contains(locationId)) {
      selectedLocations.add(locationId);
    }
  }

  @action
  void removeLocation(int locationId) {
    selectedLocations.remove(locationId);
  }

  @action
  void searchFriends(String query) {
    if (query.isEmpty) {
      filteredFriends = ObservableList.of([...friends]);
    } else {
      final result = friends
          .where((friend) =>
              friend.firstName.toLowerCase().contains(query.toLowerCase()) ||
              friend.lastName.toLowerCase().contains(query.toLowerCase()) ||
              friend.email.toLowerCase().contains(query.toLowerCase()))
          .toList();

      filteredFriends = ObservableList.of(result);
    }
  }

  @action
  void _setError(String? message) {
    errorMessage = message;
    isLoading = false;
  }
}
