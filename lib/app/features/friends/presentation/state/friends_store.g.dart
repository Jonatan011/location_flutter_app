// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FriendsStore on _FriendsStore, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError => (_$hasErrorComputed ??=
          Computed<bool>(() => super.hasError, name: '_FriendsStore.hasError'))
      .value;
  Computed<bool>? _$canAddFriendComputed;

  @override
  bool get canAddFriend =>
      (_$canAddFriendComputed ??= Computed<bool>(() => super.canAddFriend,
              name: '_FriendsStore.canAddFriend'))
          .value;

  late final _$friendsAtom =
      Atom(name: '_FriendsStore.friends', context: context);

  @override
  ObservableList<FriendModel> get friends {
    _$friendsAtom.reportRead();
    return super.friends;
  }

  @override
  set friends(ObservableList<FriendModel> value) {
    _$friendsAtom.reportWrite(value, super.friends, () {
      super.friends = value;
    });
  }

  late final _$locationsForFriendAtom =
      Atom(name: '_FriendsStore.locationsForFriend', context: context);

  @override
  ObservableList<LocationModel> get locationsForFriend {
    _$locationsForFriendAtom.reportRead();
    return super.locationsForFriend;
  }

  @override
  set locationsForFriend(ObservableList<LocationModel> value) {
    _$locationsForFriendAtom.reportWrite(value, super.locationsForFriend, () {
      super.locationsForFriend = value;
    });
  }

  late final _$friendsForlocationsAtom =
      Atom(name: '_FriendsStore.friendsForlocations', context: context);

  @override
  ObservableList<FriendModel> get friendsForlocations {
    _$friendsForlocationsAtom.reportRead();
    return super.friendsForlocations;
  }

  @override
  set friendsForlocations(ObservableList<FriendModel> value) {
    _$friendsForlocationsAtom.reportWrite(value, super.friendsForlocations, () {
      super.friendsForlocations = value;
    });
  }

  late final _$photoAtom = Atom(name: '_FriendsStore.photo', context: context);

  @override
  String get photo {
    _$photoAtom.reportRead();
    return super.photo;
  }

  @override
  set photo(String value) {
    _$photoAtom.reportWrite(value, super.photo, () {
      super.photo = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_FriendsStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$filteredFriendsAtom =
      Atom(name: '_FriendsStore.filteredFriends', context: context);

  @override
  ObservableList<FriendModel> get filteredFriends {
    _$filteredFriendsAtom.reportRead();
    return super.filteredFriends;
  }

  @override
  set filteredFriends(ObservableList<FriendModel> value) {
    _$filteredFriendsAtom.reportWrite(value, super.filteredFriends, () {
      super.filteredFriends = value;
    });
  }

  late final _$selectedLocationsAtom =
      Atom(name: '_FriendsStore.selectedLocations', context: context);

  @override
  ObservableList<int> get selectedLocations {
    _$selectedLocationsAtom.reportRead();
    return super.selectedLocations;
  }

  @override
  set selectedLocations(ObservableList<int> value) {
    _$selectedLocationsAtom.reportWrite(value, super.selectedLocations, () {
      super.selectedLocations = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_FriendsStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$fetchFriendsAsyncAction =
      AsyncAction('_FriendsStore.fetchFriends', context: context);

  @override
  Future<void> fetchFriends() {
    return _$fetchFriendsAsyncAction.run(() => super.fetchFriends());
  }

  late final _$fetchLocationsForFriendAsyncAction =
      AsyncAction('_FriendsStore.fetchLocationsForFriend', context: context);

  @override
  Future<void> fetchLocationsForFriend(int friendId) {
    return _$fetchLocationsForFriendAsyncAction
        .run(() => super.fetchLocationsForFriend(friendId));
  }

  late final _$fetchFriendsForLocationsAsyncAction =
      AsyncAction('_FriendsStore.fetchFriendsForLocations', context: context);

  @override
  Future<void> fetchFriendsForLocations(int locationId) {
    return _$fetchFriendsForLocationsAsyncAction
        .run(() => super.fetchFriendsForLocations(locationId));
  }

  late final _$addFriendAsyncAction =
      AsyncAction('_FriendsStore.addFriend', context: context);

  @override
  Future<void> addFriend(FriendModel friend) {
    return _$addFriendAsyncAction.run(() => super.addFriend(friend));
  }

  late final _$assignLocationsToFriendAsyncAction =
      AsyncAction('_FriendsStore.assignLocationsToFriend', context: context);

  @override
  Future<void> assignLocationsToFriend(int friendId) {
    return _$assignLocationsToFriendAsyncAction
        .run(() => super.assignLocationsToFriend(friendId));
  }

  late final _$fetchLocationsForFriendAndUpdateUIAsyncAction = AsyncAction(
      '_FriendsStore.fetchLocationsForFriendAndUpdateUI',
      context: context);

  @override
  Future<void> fetchLocationsForFriendAndUpdateUI(int friendId) {
    return _$fetchLocationsForFriendAndUpdateUIAsyncAction
        .run(() => super.fetchLocationsForFriendAndUpdateUI(friendId));
  }

  late final _$deleteFriendAsyncAction =
      AsyncAction('_FriendsStore.deleteFriend', context: context);

  @override
  Future<void> deleteFriend(int friendId) {
    return _$deleteFriendAsyncAction.run(() => super.deleteFriend(friendId));
  }

  late final _$_FriendsStoreActionController =
      ActionController(name: '_FriendsStore', context: context);

  @override
  void resetState() {
    final _$actionInfo = _$_FriendsStoreActionController.startAction(
        name: '_FriendsStore.resetState');
    try {
      return super.resetState();
    } finally {
      _$_FriendsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhoto(String photoPath) {
    final _$actionInfo = _$_FriendsStoreActionController.startAction(
        name: '_FriendsStore.setPhoto');
    try {
      return super.setPhoto(photoPath);
    } finally {
      _$_FriendsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearError() {
    final _$actionInfo = _$_FriendsStoreActionController.startAction(
        name: '_FriendsStore.clearError');
    try {
      return super.clearError();
    } finally {
      _$_FriendsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setLoading(bool value) {
    final _$actionInfo = _$_FriendsStoreActionController.startAction(
        name: '_FriendsStore._setLoading');
    try {
      return super._setLoading(value);
    } finally {
      _$_FriendsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addLocation(int locationId) {
    final _$actionInfo = _$_FriendsStoreActionController.startAction(
        name: '_FriendsStore.addLocation');
    try {
      return super.addLocation(locationId);
    } finally {
      _$_FriendsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeLocation(int locationId) {
    final _$actionInfo = _$_FriendsStoreActionController.startAction(
        name: '_FriendsStore.removeLocation');
    try {
      return super.removeLocation(locationId);
    } finally {
      _$_FriendsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void searchFriends(String query) {
    final _$actionInfo = _$_FriendsStoreActionController.startAction(
        name: '_FriendsStore.searchFriends');
    try {
      return super.searchFriends(query);
    } finally {
      _$_FriendsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setError(String? message) {
    final _$actionInfo = _$_FriendsStoreActionController.startAction(
        name: '_FriendsStore._setError');
    try {
      return super._setError(message);
    } finally {
      _$_FriendsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
friends: ${friends},
locationsForFriend: ${locationsForFriend},
friendsForlocations: ${friendsForlocations},
photo: ${photo},
isLoading: ${isLoading},
filteredFriends: ${filteredFriends},
selectedLocations: ${selectedLocations},
errorMessage: ${errorMessage},
hasError: ${hasError},
canAddFriend: ${canAddFriend}
    ''';
  }
}
