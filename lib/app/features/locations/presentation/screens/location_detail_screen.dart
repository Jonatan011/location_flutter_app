import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:location_flutter_app/app/features/friends/presentation/state/friends_store.dart';
import 'package:location_flutter_app/app/shared/config/router/app_navigator.dart';
import 'package:location_flutter_app/app/shared/config/service_locator.dart';
import 'package:location_flutter_app/app/shared/design_system/color_palette.dart';
import 'package:location_flutter_app/app/shared/design_system/styles.dart';
import 'package:location_flutter_app/app/shared/utils/constants.dart';
import '../../domain/entities/location_model.dart';

class LocationDetailScreen extends StatelessWidget {
  final LocationModel location;

  LocationDetailScreen({super.key, required this.location});

  final friendsStore = serviceLocator<FriendsStore>();

  @override
  Widget build(BuildContext context) {
    friendsStore.fetchFriendsForLocations(location.id!);

    return Scaffold(
      appBar: AppBar(
        title: Text(location.name),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    location.name,
                    style: sectionTitleStyle.copyWith(fontSize: 24.sp),
                  ),
                  Icon(
                    location.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: location.isFavorite ? red : grey,
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Coordenadas
              _buildSectionHeader(
                icon: Icons.location_on,
                title: tr(kCoordinates),
                color: red,
              ),
              SizedBox(height: 8.h),
              Text('${tr(kLatitude)}: ${location.latitude.toStringAsFixed(6)}', style: detailItemContentStyle),
              Text('${tr(kLongitude)}: ${location.longitude.toStringAsFixed(6)}', style: detailItemContentStyle),
              Divider(height: 32.h, thickness: 1),

              // Descripción
              _buildSectionHeader(
                icon: Icons.description,
                title: tr(kDescription),
                color: blue,
              ),
              SizedBox(height: 8.h),
              Text(
                location.description ?? tr(kNoDescription),
                style: detailItemContentStyle,
              ),
              Divider(height: 32.h, thickness: 1),

              // Fotos
              _buildSectionHeader(
                icon: Icons.photo_library,
                title: tr(kPhotos),
                color: green,
              ),
              SizedBox(height: 8.h),
              _buildPhotosSection(),
              Divider(height: 32.h, thickness: 1),

              // Amigos asociados
              _buildSectionHeader(
                icon: Icons.group,
                title: tr(kAssociatedFriends),
                color: purple,
              ),
              SizedBox(height: 8.h),
              _buildAssociatedFriends(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24.sp),
        SizedBox(width: 8.w),
        Text(
          title,
          style: sectionTitleStyle.copyWith(fontSize: 18.sp),
        ),
      ],
    );
  }

  Widget _buildPhotosSection() {
    if (location.photos.isNotEmpty) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
        ),
        itemCount: location.photos.length,
        itemBuilder: (context, index) {
          final photo = location.photos[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.file(
              File(photo),
              fit: BoxFit.cover,
            ),
          );
        },
      );
    } else {
      return Center(
        child: Text(
          tr(kNoPhotos),
          style: detailItemContentStyle.copyWith(
            color: grey,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }
  }

  Widget _buildAssociatedFriends() {
    return Observer(
      builder: (_) {
        final friends = friendsStore.friendsForlocations;
        if (friendsStore.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (friends.isEmpty) {
          return Center(
            child: Text(
              tr(kNoAssociatedFriends),
              style: detailItemContentStyle.copyWith(
                color: grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: friends.length,
          itemBuilder: (context, index) {
            final friend = friends[index];
            return InkWell(
              onTap: () {
                goToFriendDetail(context, friend);
              },
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 8.h),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: friend.photo.isNotEmpty
                        ? FileImage(File(friend.photo))
                        : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
                  ),
                  title: Text('${friend.firstName} ${friend.lastName}', style: detailItemTitleStyle),
                  subtitle: Text(friend.email, style: hintTextStyle),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
