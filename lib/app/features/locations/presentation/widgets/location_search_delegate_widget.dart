import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location_flutter_app/app/features/locations/presentation/state/locations_store.dart';
import 'package:location_flutter_app/app/shared/config/router/app_navigator.dart';
import 'package:location_flutter_app/app/shared/design_system/color_palette.dart';
import 'package:location_flutter_app/app/shared/design_system/styles.dart';
import 'package:location_flutter_app/app/shared/utils/constants.dart';

class LocationsSearchDelegate extends SearchDelegate {
  final LocationsStore store;

  LocationsSearchDelegate(this.store);

  @override
  String get searchFieldLabel => tr(kTrWelcome);

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
    store.searchLocation(query);
    return _buildLocationList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    store.searchLocation(query);
    return _buildLocationList(context);
  }

  Widget _buildLocationList(BuildContext context) {
    return Observer(
      builder: (_) {
        if (store.filteredLocations.isEmpty) {
          return _buildEmptyState();
        }
        return ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          itemCount: store.filteredLocations.length,
          separatorBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: const Divider(color: grey, thickness: 1),
          ),
          itemBuilder: (context, index) {
            final location = store.filteredLocations[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: colorPrimary,
                  child: const Icon(Icons.location_on, color: white),
                ),
                title: Text(
                  location.name,
                  style: titleSecondaryStyle,
                ),
                subtitle: Text(
                  '${tr(kTrLongitude)}: ${location.longitude}',
                  style: bodyStyle,
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  store.searchLocation(location.name);
                  goToLocationDetail(context, location);
                  close(context, location);
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
          const Icon(Icons.search_off, size: 80, color: grey),
          SizedBox(height: 16.h),
          Text(
            tr(kTrNoResults),
            style: textNormalStyle,
          ),
        ],
      ),
    );
  }
}
