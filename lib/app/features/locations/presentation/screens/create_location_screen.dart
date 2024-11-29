import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_flutter_app/app/features/locations/domain/entities/location_model.dart';
import 'package:location_flutter_app/app/features/locations/presentation/state/locations_store.dart';
import 'package:location_flutter_app/app/shared/config/service_locator.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:location_flutter_app/app/shared/design_system/color_palette.dart';

import 'package:location_flutter_app/app/shared/design_system/styles.dart';
import 'package:location_flutter_app/app/shared/utils/constants.dart';

class CreateLocationScreen extends StatefulWidget {
  const CreateLocationScreen({super.key});

  @override
  State<CreateLocationScreen> createState() => _CreateLocationScreenState();
}

class _CreateLocationScreenState extends State<CreateLocationScreen> {
  final store = serviceLocator<LocationsStore>();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  Future<void> _takePhoto() async {
    if (store.photos.length >= 3) {
      _showSnackBar(tr(kMaxPhotosError));
      return;
    }
    store.setLoading(true);
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final position = await getCurrentLocation();
        if (position != null) {
          store.addPhotoWithLocation(pickedFile.path, position.latitude, position.longitude);
        } else {
          _showSnackBar(tr(kLocationError));
        }
      }
    } catch (e) {
      _showSnackBar(tr(kTakingPhotoError));
    } finally {
      store.setLoading(false);
    }
  }

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw Exception(tr(kLocationError));
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) throw Exception(tr(kLocationError));
    }
    if (permission == LocationPermission.deniedForever) throw Exception(tr(kLocationError));
    return await Geolocator.getCurrentPosition(locationSettings: const LocationSettings(accuracy: LocationAccuracy.best));
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      if (store.photos.isEmpty) {
        _showSnackBar(tr(kAtLeastOnePhoto));
        return;
      }
      if (store.latitude == null || store.longitude == null) {
        _showSnackBar(tr(kLocationError));
        return;
      }
      final newLocation = LocationModel(
        name: _nameController.text,
        latitude: store.latitude!,
        longitude: store.longitude!,
        description: _descriptionController.text,
        photos: store.photos.toList(),
      );
      await store.addLocation(newLocation);
      if (store.hasError) {
        _showSnackBar(store.errorMessage!);
      } else {
        if (context.mounted) context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        store.resetState();
      },
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title: Text(tr(kCreateLocationTitle)),
          centerTitle: true,
        ),
        body: Observer(
          builder: (_) {
            return Padding(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildTextField(
                        controller: _nameController,
                        label: tr(kNameLabel),
                        validator: (value) => value == null || value.isEmpty ? tr(kNameRequired) : null,
                      ),
                      _buildTextField(
                        controller: _descriptionController,
                        label: tr(kDescriptionLabel),
                        maxLines: 3,
                      ),
                      SizedBox(height: 16.h),
                      _buildPhotoSection(),
                      SizedBox(height: 16.h),
                      ElevatedButton(
                        onPressed: store.isLoading ? null : _submit,
                        child: store.isLoading ? const CircularProgressIndicator(color: white) : Text(tr(kSave)),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextFormField(
        controller: controller,
        style: inputTextStyle,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: hintTextStyle,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
        maxLines: maxLines,
      ),
    );
  }

  Widget _buildPhotoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(tr(kPhotosTitle), style: sectionTitleStyle),
        SizedBox(height: 8.h),
        Observer(
          builder: (_) {
            return Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: store.photos.map((photo) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.file(File(photo), width: 100.w, height: 100.w, fit: BoxFit.cover),
                    Positioned(
                      top: -8.h,
                      right: -8.w,
                      child: GestureDetector(
                        onTap: () => store.removePhoto(photo),
                        child: CircleAvatar(
                          radius: 12.r,
                          backgroundColor: red,
                          child: Icon(Icons.close, size: 16.sp, color: white),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            );
          },
        ),
        SizedBox(height: 8.h),
        ElevatedButton.icon(
          onPressed: store.isLoading ? null : _takePhoto,
          icon: const Icon(Icons.camera_alt),
          label: Text(tr(kTakePhoto)),
        ),
      ],
    );
  }
}
