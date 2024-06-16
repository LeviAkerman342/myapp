import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/core/data/model/api/api_service.dart';

class UserSelectionScreen extends StatefulWidget {
  const UserSelectionScreen({super.key});

  @override
  _UserSelectionScreenState createState() => _UserSelectionScreenState();
}

class _UserSelectionScreenState extends State<UserSelectionScreen> {
  late Future<List<Map<String, dynamic>>> usersFuture;

  @override
  void initState() {
    super.initState();
    usersFuture = AuthenticationRepository().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select User'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found'));
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user['name']),
                  onTap: () {
                    context.push('/chat', extra: {'user': user});
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
