// ignore: depend_on_referenced_packages
import 'package:supabase/supabase.dart';

class SupabaseService {
  final SupabaseClient client;

  SupabaseService()
      : client = SupabaseClient(
          'https://lryxclzvexwfhdcdijxc.supabase.co',
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxyeXhjbHp2ZXh3ZmhkY2RpanhjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQ0MjU3OTYsImV4cCI6MjAzMDAwMTc5Nn0.con_Q62xHQW8q6vqZ4BInFLG7BFZB8LT4Sc9WMTr7LY',
        );
}

final supabaseService = SupabaseService();
