import 'package:flutter/material.dart';
import 'story_detail_screen.dart';

class StoryWidget extends StatelessWidget {
  final List<Map<String, String>> stories;

  const StoryWidget({super.key, required this.stories});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: stories.map((story) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoryDetailScreen(
                    stories: stories,
                    initialIndex: stories.indexOf(story),
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(story['url']!),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
