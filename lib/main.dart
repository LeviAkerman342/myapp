import 'package:flutter/material.dart';
import 'package:myapp/feature/chat/data/database_helper.dart';
import 'package:myapp/feature/chat/data/repositories/local_chat_repository.dart';
import 'package:provider/provider.dart';
import 'router/router.dart';


void main() {
  final databaseHelper = DatabaseHelper();
  final chatRepository = LocalChatRepository(databaseHelper);

  runApp(
    MultiProvider(
      providers: [
        Provider<LocalChatRepository>(
          create: (_) => chatRepository,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
