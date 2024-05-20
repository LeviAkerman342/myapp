import 'package:flutter/material.dart';
import 'package:myapp/feature/course/screens/dashboard_screen.dart';
import 'package:myapp/router/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://xywozykuxyqkubprtzql.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh5d296eWt1eHlxa3VicHJ0enFsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDg1MDY3NzUsImV4cCI6MjAyNDA4Mjc3NX0.pZHIMs4Jzm-h4dPzA8jqqiqZPKhOFKUCRoMljmKM54g',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      builder: (context, child) {
        return const DashboardScreen();
      },
    );
  }
}
