import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:location_flutter_app/app/features/friends/presentation/state/friends_store.dart';
import 'package:location_flutter_app/app/shared/config/router/app_navigator.dart';
import 'package:location_flutter_app/app/shared/design_system/color_palette.dart';
import 'package:location_flutter_app/app/shared/design_system/styles.dart';
import 'package:location_flutter_app/app/shared/utils/constants.dart';

class FriendSearchDelegate extends SearchDelegate {
  final FriendsStore store;

  FriendSearchDelegate(this.store);

  @override
  String get searchFieldLabel => tr(kTrFriendSearchHint);

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear, color: red),
          onPressed: () => query = '',
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back, color: colorPrimary),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) {
    store.searchFriends(query);
    return _buildFriendList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    store.searchFriends(query);
    return _buildFriendList(context);
  }

  Widget _buildFriendList(BuildContext context) {
    return Observer(
      builder: (_) {
        if (store.filteredFriends.isEmpty) {
          return _buildEmptyState();
        }
        return ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          itemCount: store.filteredFriends.length,
          separatorBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: const Divider(color: grey, thickness: 1),
          ),
          itemBuilder: (context, index) {
            final friend = store.filteredFriends[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: colorPrimary,
                  child: Text(
                    friend.firstName[0],
                    style: titleSecondaryStyle.copyWith(color: white),
                  ),
                ),
                title: Text(
                  '${friend.firstName} ${friend.lastName}',
                  style: titleSecondaryStyle,
                ),
                subtitle: Text(
                  friend.email,
                  style: bodyStyle,
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  store.searchFriends(friend.firstName);
                  goToFriendDetail(context, friend);
                  close(context, friend);
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person_off, size: 80, color: grey),
          SizedBox(height: 16.h),
          Text(
            tr(kTrNoFriendsFound),
            style: textNormalStyle,
          ),
        ],
      ),
    );
  }
}
