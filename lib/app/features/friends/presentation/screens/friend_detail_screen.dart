import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:location_flutter_app/app/features/friends/domain/entities/friend_model.dart';
import 'package:location_flutter_app/app/features/locations/presentation/state/locations_store.dart';
import 'package:location_flutter_app/app/shared/config/service_locator.dart';
import '../state/friends_store.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:location_flutter_app/app/shared/design_system/color_palette.dart';
import 'package:location_flutter_app/app/shared/design_system/styles.dart';
import 'package:location_flutter_app/app/shared/utils/constants.dart';

class FriendDetailScreen extends StatelessWidget {
  final FriendModel friend;

  FriendDetailScreen({super.key, required this.friend});

  final friendsStore = serviceLocator<FriendsStore>();
  final locationsStore = serviceLocator<LocationsStore>();

  @override
  Widget build(BuildContext context) {
    locationsStore.fetchLocations();
    friendsStore.fetchLocationsForFriend(friend.id!);

    Future<void> submit() async {
      await friendsStore.assignLocationsToFriend(friend.id!);

      if (friendsStore.hasError) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(friendsStore.errorMessage ?? tr(kSave))),
          );
        }
      } else {
        if (context.mounted) {
          friendsStore.fetchLocationsForFriend(friend.id!);
          context.pop();
        }
      }
    }

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        friendsStore.resetState();
        locationsStore.resetState();
      },
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title: Text("${kFriendDetailTitle.tr()} ${friend.firstName}"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildPhotoSection(),
              SizedBox(height: 16.h),
              _buildBasicInfo(),
              Divider(color: greyShade300),
              _buildAssignedLocations(context),
              SizedBox(height: 16.h),
              Observer(
                builder: (_) {
                  return ElevatedButton(
                    onPressed: friendsStore.isLoading ? null : submit,
                    child: friendsStore.isLoading ? const CircularProgressIndicator(color: white) : Text(tr(kSave)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoSection() {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 80.r,
          backgroundColor: colorPrimary.withOpacity(0.1),
          backgroundImage:
              friend.photo.isNotEmpty ? FileImage(File(friend.photo)) : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
        ),
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(tr(kBasicInfo), style: sectionTitleStyle),
        SizedBox(height: 8.h),
        _buildDetailItem(
          title: tr(kFullName),
          content: '${friend.firstName} ${friend.lastName}',
          icon: Icons.person,
        ),
        _buildDetailItem(
          title: tr(kEmail),
          content: friend.email,
          icon: Icons.email,
        ),
        _buildDetailItem(
          title: tr(kPhoneNumber),
          content: friend.phoneNumber,
          icon: Icons.phone,
        ),
      ],
    );
  }

  Widget _buildAssignedLocations(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(tr(kAssignedLocations), style: sectionTitleStyle),
        SizedBox(height: 8.h),
        Observer(
          builder: (_) {
            if (locationsStore.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (friendsStore.locationsForFriend.isEmpty) {
              return Text(tr(kNoAssignedLocations), style: hintTextStyle);
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: friendsStore.locationsForFriend.length,
              itemBuilder: (context, index) {
                final location = friendsStore.locationsForFriend[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.place, color: colorPrimary),
                    title: Text(location.name, style: detailItemTitleStyle),
                    subtitle: Text(
                      'Lat: ${location.latitude}, Long: ${location.longitude}',
                      style: detailItemContentStyle,
                    ),
                  ),
                );
              },
            );
          },
        ),
        Divider(color: greyShade300),
        Text(tr(kAssignNewLocations), style: sectionTitleStyle),
        SizedBox(height: 8.h),
        Observer(
          builder: (_) {
            if (locationsStore.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final availableLocations =
                locationsStore.locations.where((location) => !friendsStore.locationsForFriend.any((assigned) => assigned.id == location.id)).toList();

            if (availableLocations.isEmpty) {
              return Text(tr(kNoAvailableLocations), style: hintTextStyle);
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: availableLocations.length,
              itemBuilder: (context, index) {
                final location = availableLocations[index];
                return Observer(
                  builder: (_) => CheckboxListTile(
                    title: Text(location.name),
                    subtitle: Text('Lat: ${location.latitude}, Long: ${location.longitude}'),
                    value: friendsStore.selectedLocations.contains(location.id),
                    onChanged: (isSelected) {
                      if (isSelected == true) {
                        friendsStore.addLocation(location.id!);
                      } else {
                        friendsStore.removeLocation(location.id!);
                      }
                    },
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildDetailItem({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: colorPrimary, size: 28.r),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: detailItemTitleStyle),
                SizedBox(height: 4.h),
                Text(content, style: detailItemContentStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
