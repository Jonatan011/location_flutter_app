import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location_flutter_app/app/features/friends/domain/entities/friend_model.dart';
import 'package:location_flutter_app/app/features/locations/presentation/state/locations_store.dart';
import 'package:location_flutter_app/app/shared/config/service_locator.dart';
import 'package:location_flutter_app/app/shared/design_system/color_palette.dart';
import '../state/friends_store.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:location_flutter_app/app/shared/design_system/styles.dart';
import 'package:location_flutter_app/app/shared/utils/constants.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final friendsStore = serviceLocator<FriendsStore>();
  final locationsStore = serviceLocator<LocationsStore>();
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    locationsStore.fetchLocations();
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      friendsStore.setPhoto(pickedFile.path);
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final newFriend = FriendModel(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        photo: friendsStore.photo,
      );

      await friendsStore.addFriend(newFriend);

      if (friendsStore.hasError) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(friendsStore.errorMessage ?? tr(kSave))),
          );
        }
      } else {
        friendsStore.resetState();
        if (context.mounted) context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        friendsStore.resetState();
      },
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title: Text(tr(kAddFriendTitle)),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(tr(kFriendInfo), style: sectionTitleStyle),
                  SizedBox(height: 16.h),
                  _buildTextField(
                    controller: _firstNameController,
                    label: tr(kNameRequired),
                    validator: (value) => value == null || value.isEmpty ? tr(kNameRequired) : null,
                  ),
                  _buildTextField(
                    controller: _lastNameController,
                    label: tr(kLastNameRequired),
                    validator: (value) => value == null || value.isEmpty ? tr(kLastNameRequired) : null,
                  ),
                  _buildTextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    label: tr(kEmailRequired),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return tr(kEmailRequired);
                      }
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      return !emailRegex.hasMatch(value) ? tr(kInvalidEmail) : null;
                    },
                  ),
                  _buildTextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    label: tr(kPhoneRequired),
                    validator: (value) => value == null || value.isEmpty ? tr(kPhoneRequired) : null,
                  ),
                  SizedBox(height: 16.h),
                  Text(tr(kPhotoTitle), style: sectionTitleStyle),
                  SizedBox(height: 8.h),
                  Observer(
                    builder: (_) {
                      final photo = friendsStore.photo;
                      return photo.isEmpty
                          ? Text(tr(kNoPhotoSelected), textAlign: TextAlign.center, style: hintTextStyle)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image.file(
                                File(photo),
                                width: 120.w,
                                height: 200.h,
                                fit: BoxFit.cover,
                              ),
                            );
                    },
                  ),
                  SizedBox(height: 8.h),
                  ElevatedButton.icon(
                    onPressed: _pickPhoto,
                    icon: const Icon(Icons.photo_library),
                    label: Text(tr(kPickPhoto)),
                  ),
                  SizedBox(height: 16.h),
                  Text(tr(kAssignLocations), style: sectionTitleStyle),
                  SizedBox(height: 8.h),
                  Observer(
                    builder: (_) {
                      if (locationsStore.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: locationsStore.locations.length,
                        itemBuilder: (context, index) {
                          final location = locationsStore.locations[index];
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
                  SizedBox(height: 16.h),
                  Observer(
                    builder: (_) {
                      return ElevatedButton(
                        onPressed: friendsStore.isLoading ? null : _submit,
                        child: friendsStore.isLoading ? const CircularProgressIndicator(color: Colors.white) : Text(tr(kSave)),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextFormField(
        controller: controller,
        style: inputTextStyle,
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: hintTextStyle,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }
}
