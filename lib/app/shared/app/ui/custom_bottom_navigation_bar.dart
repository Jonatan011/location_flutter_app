import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:location_flutter_app/app/features/navigator_screen/presentation/state/bottom_navigation_store.dart';
import 'package:location_flutter_app/app/shared/config/router/route_names.dart';

import 'package:location_flutter_app/app/shared/config/service_locator.dart';
import 'package:location_flutter_app/app/shared/design_system/styles.dart';
import 'package:location_flutter_app/app/shared/utils/constants.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location_flutter_app/app/shared/design_system/color_palette.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final BottomNavigationStore navigationStore = serviceLocator<BottomNavigationStore>();

  CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: const BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: black26,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Observer(
        builder: (_) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                Icons.place,
                tr(kSavedLocations),
                0,
                blue,
                blueShade100,
                () {
                  navigationStore.setSelectedIndex(0);
                  context.go(kRouteLocation);
                },
              ),
              _buildNavItem(
                context,
                Icons.favorite,
                tr(kFavoriteLocations),
                1,
                red,
                redShade100,
                () {
                  context.go(kRouteLocationFavorites);
                  navigationStore.setSelectedIndex(1);
                },
              ),
              _buildNavItem(
                context,
                Icons.people,
                tr(kFriendsTooltip),
                2,
                green,
                greenShade100,
                () {
                  context.go(kRouteFriends);
                  navigationStore.setSelectedIndex(2);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
    Color activeColor,
    Color backgroundColor,
    VoidCallback onTap,
  ) {
    final isSelected = navigationStore.selectedIndex == index;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56.h,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? backgroundColor : transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? activeColor : grey,
              size: 28.sp,
            ),
            if (isSelected) ...[
              SizedBox(width: 8.w),
              Text(
                label,
                style: styleTextNavigation.copyWith(
                  color: activeColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
