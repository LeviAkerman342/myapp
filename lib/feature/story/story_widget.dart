import 'package:flutter/material.dart';
import 'package:myapp/feature/story/story.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> stories = [{'type': 'image', 'url': 'https://i.pinimg.com/564x/e6/0d/a3/e60da318b135e5130c1d45e7789767af.jpg'},
    {'type': 'image', 'url': 'https://i.pinimg.com/564x/f9/47/bf/f947bfbb294cff3ab27d78b0c059870d.jpg'},
    {'type': 'image', 'url': 'https://i.pinimg.com/564x/f7/4e/0b/f74e0bd73320281938ec3ea61738c376.jpg'},
    {'type': 'gif', 'url': 'https://i.pinimg.com/originals/0f/b9/4d/0fb94dff52a5935e105ec497a0c010a5.gif'}
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Instagram Stories')),
      body: StoryWidget(stories: stories),
    );
  }
}
