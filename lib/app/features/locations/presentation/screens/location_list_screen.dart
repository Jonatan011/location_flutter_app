import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:location_flutter_app/app/features/locations/presentation/widgets/location_search_delegate_widget.dart';
import 'package:location_flutter_app/app/shared/config/router/app_navigator.dart';
import 'package:location_flutter_app/app/shared/config/service_locator.dart';
import 'package:location_flutter_app/app/shared/design_system/color_palette.dart';
import '../state/locations_store.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:location_flutter_app/app/shared/design_system/styles.dart';
import 'package:location_flutter_app/app/shared/utils/constants.dart';

class LocationsListScreen extends StatefulWidget {
  const LocationsListScreen({super.key});

  @override
  _LocationsListScreenState createState() => _LocationsListScreenState();
}

class _LocationsListScreenState extends State<LocationsListScreen> {
  final store = serviceLocator<LocationsStore>();

  @override
  void initState() {
    super.initState();
    store.fetchLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(tr(kSavedLocations)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: tr(kSearchTooltip),
            onPressed: () {
              showSearch(
                context: context,
                delegate: LocationsSearchDelegate(store),
              );
            },
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (store.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (store.hasError) {
            return _buildErrorSection();
          }

          if (store.locations.isEmpty) {
            return _buildEmptyState();
          }

          return _buildLocationList();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          goToCreateLocation(context);
        },
        icon: const Icon(Icons.add),
        label: Text(tr(kNewLocation)),
      ),
    );
  }

  Widget _buildErrorSection() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: red, size: 48),
          SizedBox(height: 16.h),
          Text(
            store.errorMessage ?? tr(kUnknownError),
            style: errorMessageStyle,
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {
              store.fetchLocations();
            },
            child: Text(tr(kRetry)),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_off, color: grey, size: 48),
          SizedBox(height: 16.h),
          Text(
            tr(kNoLocations),
            style: emptyMessageStyle,
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {
              goToCreateLocation(context);
            },
            child: Text(tr(kAddLocation)),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: store.locations.length,
      itemBuilder: (context, index) {
        final location = store.locations[index];
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
                backgroundColor: blueShade100,
                child: const Icon(Icons.place, color: blue),
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
              trailing: IconButton(
                icon: Icon(
                  location.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: location.isFavorite ? red : grey,
                ),
                onPressed: () {
                  store.toggleFavorite(location.id!, !location.isFavorite);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
