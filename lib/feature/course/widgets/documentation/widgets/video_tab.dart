import 'package:flutter/material.dart';
import 'package:myapp/core/domain/entities/course_topic.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class VideoTab extends StatelessWidget {
  final CourseTopic topic;

  const VideoTab({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(topic.videoUrl)!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      ),
      showVideoProgressIndicator: true,
    );
  }
}
