import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:location_flutter_app/app/features/friends/domain/entities/friend_model.dart';
import 'package:location_flutter_app/app/features/locations/domain/entities/location_model.dart';
import 'package:location_flutter_app/app/shared/config/router/route_names.dart';

goToLocation(BuildContext context) => context.push(kRouteLocation);
goToCreateLocation(BuildContext context) => context.push(kRouteCreateLocation);
goTofriends(BuildContext context) => context.push(kRouteFriends);
goToCreatefriend(BuildContext context) => context.push(kRouteCreateFriend);
goToLocationFavorites(BuildContext context) => context.push(kRouteLocationFavorites);

void goToFriendDetail(BuildContext context, FriendModel friend) {
  context.push(kRouteFriendDetail, extra: friend);
}

void goToLocationDetail(BuildContext context, LocationModel location) {
  context.push(kRouteLocationDetail, extra: location);
}
