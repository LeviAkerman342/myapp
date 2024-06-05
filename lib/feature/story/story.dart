import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> stories = [
    {'type': 'image', 'url': 'https://via.placeholder.com/150'},
    {'type': 'video', 'url': 'https://www.sample-videos.com/video123/mp4/480/asdasdas.mp4'},
    {'type': 'image', 'url': 'https://via.placeholder.com/150'},
    {'type': 'gif', 'url': 'https://media.giphy.com/media/3o7qE1YN7aBOFPRw8E/giphy.gif'}
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
                  builder: (context) => StoryDetailScreen(stories: stories, initialIndex: stories.indexOf(story)),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              width: 100,
              height: 100,
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

class StoryDetailScreen extends StatefulWidget {
  final List<Map<String, String>> stories;
  final int initialIndex;

  const StoryDetailScreen({super.key, required this.stories, required this.initialIndex});

  @override
  _StoryDetailScreenState createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late int _currentIndex;
  VideoPlayerController? _videoController;
  late bool _isVideo;
  late AnimationController _animationController;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 5))
      ..addListener(() {
        setState(() {});
      });
    _isVideo = widget.stories[_currentIndex]['type'] == 'video';
    if (_isVideo) {
      _initializeVideoController(widget.stories[_currentIndex]['url']!);
    }
    _startAutoPlay();
  }

  void _initializeVideoController(String url) {
    _videoController = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {});
        _videoController?.play();
      });
  }

  void _startAutoPlay() {
    _animationController.reset();
    _animationController.forward().whenComplete(() {
      if (_currentIndex < widget.stories.length - 1) {
        _currentIndex++;
        _pageController.animateToPage(_currentIndex, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        if (widget.stories[_currentIndex]['type'] == 'video') {
          _initializeVideoController(widget.stories[_currentIndex]['url']!);
        }
      } else {
        Navigator.of(context).pop();
      }
    });
  }

  void _handleTapDown(TapDownDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (details.globalPosition.dx < screenWidth / 2) {
      if (_currentIndex > 0) {
        _currentIndex--;
        _pageController.animateToPage(_currentIndex, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        if (widget.stories[_currentIndex]['type'] == 'video') {
          _initializeVideoController(widget.stories[_currentIndex]['url']!);
        }
      }
    } else {
      if (_currentIndex < widget.stories.length - 1) {
        _currentIndex++;
        _pageController.animateToPage(_currentIndex, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        if (widget.stories[_currentIndex]['type'] == 'video') {
          _initializeVideoController(widget.stories[_currentIndex]['url']!);
        }
      }
    }
    _startAutoPlay();
  }

 

  @override
  void dispose() {
    _videoController?.dispose();
    _pageController.dispose();
    _animationController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: _handleTapDown,
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: widget.stories.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                  _isVideo = widget.stories[index]['type'] == 'video';
                  if (_isVideo) {
                    _initializeVideoController(widget.stories[index]['url']!);
                  } else {
                    _videoController?.dispose();
                    _videoController = null;
                  }
                  _startAutoPlay();
                });
              },
              itemBuilder: (context, index) {
                final story = widget.stories[index];
                if (story['type'] == 'video') {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_videoController!.value.isPlaying) {
                          _videoController?.pause();
                          _animationController.stop();
                        } else {
                          _videoController?.play();
                          _animationController.forward();
                        }
                      });
                    },
                    child: _videoController?.value.isInitialized ?? false
                        ? AspectRatio(
                            aspectRatio: _videoController!.value.aspectRatio,
                            child: VideoPlayer(_videoController!),
                          )
                        : const Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return Center(
                    child: CachedNetworkImage(
                      imageUrl: story['url']!,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  );
                }
              },
            ),
            Positioned(
              top: 40,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: LinearProgressIndicator(
                value: _animationController.value,
                backgroundColor: Colors.white54,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            Positioned(
              bottom: 60,
              left: 10,
              right: 10,
              child: Column(
                children: [
                  TextField(
                    controller: _commentController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      hintStyle: const TextStyle(color: Colors.white54),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: () {
                          // _addComment(_commentController.text);
                        },
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // SizedBox(
                  //   height: 100,
                  //   child: ListView(
                  //     children: widget.stories[_currentIndex]['comments']!
                  //         .map<Widget>((comment) => ListTile(
                  //               title: Text(comment, style: const TextStyle(color: Colors.white)),
                  //             ))
                  //         .toList(),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}