import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:location_flutter_app/app/features/locations/presentation/state/locations_store.dart';
import 'package:location_flutter_app/app/shared/config/router/app_navigator.dart';
import 'package:location_flutter_app/app/shared/config/service_locator.dart';
import 'package:location_flutter_app/app/shared/design_system/color_palette.dart';
import 'package:location_flutter_app/app/shared/design_system/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:location_flutter_app/app/shared/utils/constants.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final store = serviceLocator<LocationsStore>();

  @override
  void initState() {
    super.initState();
    store.fetchFavoriteLocations(); // Carga las ubicaciones favoritas
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(tr(kFavoriteLocations)),
        centerTitle: true,
      ),
      body: Observer(
        builder: (_) {
          if (store.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (store.favoriteLocations.isEmpty) {
            return _buildEmptyState();
          }

          return _buildFavoriteList();
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.favorite_border, color: grey, size: 48),
          SizedBox(height: 16.h),
          Text(
            tr(kNoFavorites),
            style: emptyMessageStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: store.favoriteLocations.length,
      itemBuilder: (context, index) {
        final location = store.favoriteLocations[index];
        return InkWell(
          onTap: () {
            goToLocationDetail(context, location);
          },
          child: Card(
            margin: EdgeInsets.only(bottom: 16.h),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16.w),
              leading: CircleAvatar(
                backgroundColor: redShade100,
                child: const Icon(Icons.favorite, color: red),
              ),
              title: Text(
                location.name,
                style: locationTitleStyle,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  Text('${tr(kLatitude)}: ${location.latitude}'),
                  Text('${tr(kLongitude)}: ${location.longitude}'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
