import 'package:myapp/feature/auntification/login/interface/registration_strategy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../supabase/supabase_service.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class GetRegistrationStrategy implements RegistrationStrategy {
  @override
  Future<void> register(BuildContext context, String name, String email,
      String password, File? image) async {
    final Uri url = Uri.parse(
        'https://learning-courses-back-end.onrender.com/api/v1/Authentication/User');

    try {
      // Build query parameters
      final Map<String, String> queryParams = {
        'name': name,
        'email': email,
        'password': password,
        'image': image != null ? base64Encode(image.readAsBytesSync()) : '',
      };

      // Add query parameters to the URL
      final Uri uriWithQuery = url.replace(queryParameters: queryParams);

      final HttpClient httpClient = HttpClient();
      final HttpClientRequest request = await httpClient.getUrl(uriWithQuery);
      final HttpClientResponse response = await request.close();

      if (response.statusCode == 200) {
        print('Registration successful');
      } else {
        print('Registration failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during registration: $e');
    }
  }
}

class AuthenticationRepository {
  final SupabaseClient _client = supabaseService.client;

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    File? image,
  }) async {
    final response = await _client.from('users').insert({
      'name': name,
      'email': email,
      'password': password, // Store hashed password in real application
    });

    if (response.error != null) {
      throw Exception('Registration failed: ${response.error.message}');
    } else {
      print('Registration successful');
    }
  }

  Future<void> authenticateUser(String email, String password) async {
    // Authentication logic
  }

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final response = await _client.from('users').select();

    if (response.isEmpty) {
      throw Exception('No users found');
    }
    return List<Map<String, dynamic>>.from(response);
  }
}
