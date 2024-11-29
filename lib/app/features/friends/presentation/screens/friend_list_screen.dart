import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:location_flutter_app/app/features/friends/domain/entities/friend_model.dart';
import 'package:location_flutter_app/app/features/friends/presentation/state/friends_store.dart';
import 'package:location_flutter_app/app/features/friends/presentation/widgets/friend_search_delegate_widget.dart';
import 'package:location_flutter_app/app/shared/config/router/app_navigator.dart';
import '../../../../shared/config/service_locator.dart';

class FriendsListScreen extends StatefulWidget {
  const FriendsListScreen({super.key});

  @override
  State<FriendsListScreen> createState() => _FriendsListScreenState();
}

class _FriendsListScreenState extends State<FriendsListScreen> {
  final store = serviceLocator<FriendsStore>();

  @override
  void initState() {
    super.initState();
    store.fetchFriends();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amigos'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: FriendSearchDelegate(store),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: store.fetchFriends,
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          final listFilter = store.friends;
          if (store.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (store.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    store.errorMessage ?? 'Error desconocido',
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: store.fetchFriends,
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          if (listFilter.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.group_off, size: 48, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No se encontraron amigos.',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: listFilter.length,
            itemBuilder: (context, index) {
              final friend = listFilter[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16.0),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.blue.shade100,
                    backgroundImage: friend.photo.isNotEmpty
                        ? FileImage(File(friend.photo))
                        : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
                  ),
                  title: Text(
                    '${friend.firstName} ${friend.lastName}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(friend.email),
                      Text(friend.phoneNumber),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteFriend(friend.id ?? 0),
                  ),
                  onTap: () {
                    _navigateToFriendDetail(context, friend);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToAddFriend(context),
        icon: const Icon(Icons.add),
        label: const Text('Añadir Amigo'),
      ),
    );
  }

  void _deleteFriend(int friendId) async {
    await store.deleteFriend(friendId);
    if (store.hasError) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(store.errorMessage ?? 'Error al eliminar el amigo')),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Amigo eliminado exitosamente')),
        );
      }
    }
  }

  void _navigateToAddFriend(BuildContext context) {
    goToCreatefriend(context);
  }

  void _navigateToFriendDetail(BuildContext context, FriendModel friend) {
    goToFriendDetail(context, friend);
  }
}
