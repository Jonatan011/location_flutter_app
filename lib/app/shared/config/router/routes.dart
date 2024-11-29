import 'package:go_router/go_router.dart';
import 'package:location_flutter_app/app/features/friends/domain/entities/friend_model.dart';
import 'package:location_flutter_app/app/features/friends/presentation/screens/create_friend_screen.dart';
import 'package:location_flutter_app/app/features/friends/presentation/screens/friend_detail_screen.dart';
import 'package:location_flutter_app/app/features/friends/presentation/screens/friends_screen.dart';
import 'package:location_flutter_app/app/features/locations/domain/entities/location_model.dart';
import 'package:location_flutter_app/app/features/locations/presentation/screens/create_location_screen.dart';
import 'package:location_flutter_app/app/features/locations/presentation/screens/location_favorites_screen.dart';
import 'package:location_flutter_app/app/features/locations/presentation/screens/locations_screen.dart';
import 'package:location_flutter_app/app/features/locations/presentation/screens/location_detail_screen.dart';
import 'package:location_flutter_app/app/features/navigator_screen/presentation/navigator_screen.dart';
import 'package:location_flutter_app/app/features/splash/ui/splash_screen.dart';
import 'package:location_flutter_app/app/shared/config/router/route_names.dart';

final GoRouter router = GoRouter(
  initialLocation: kRouteSplash,
  routes: [
    // Splash Screen
    GoRoute(
      path: kRouteSplash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(path: kRouteCreateLocation, builder: (context, state) => const CreateLocationScreen()),
    GoRoute(path: kRouteCreateFriend, builder: (context, state) => const AddFriendScreen()),

    GoRoute(
      path: kRouteLocationDetail,
      builder: (context, state) => LocationDetailScreen(
        location: state.extra! as LocationModel,
      ),
    ),
    GoRoute(
      path: kRouteFriendDetail,
      builder: (context, state) => FriendDetailScreen(
        friend: state.extra as FriendModel,
      ),
    ),

    // Define el ShellRoute
    ShellRoute(
      builder: (context, state, child) {
        return NavigatorScreen(child: child);
      },
      routes: [
        GoRoute(path: kRouteLocation, builder: (context, state) => const LocationScreen()),
        GoRoute(path: kRouteFriends, builder: (context, state) => const FriendScreen()),
        GoRoute(path: kRouteLocationFavorites, builder: (context, state) => const FavoritesScreen()),
      ],
    ),
  ],
);
