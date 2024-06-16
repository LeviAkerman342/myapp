import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    // ignore: deprecated_member_use
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
        setState(() {
          _currentIndex++;
          _pageController.animateToPage(_currentIndex,
              duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
          _isVideo = widget.stories[_currentIndex]['type'] == 'video';
          if (_isVideo) {
            _initializeVideoController(widget.stories[_currentIndex]['url']!);
          } else {
            _videoController?.dispose();
            _videoController = null;
          }
        });
        _startAutoPlay();
      } else {
        Navigator.of(context).pop();
      }
    });
  }

  void _handleTapDown(TapDownDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (details.globalPosition.dx < screenWidth / 2) {
      if (_currentIndex > 0) {
        setState(() {
          _currentIndex--;
          _pageController.animateToPage(_currentIndex,
              duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
          _isVideo = widget.stories[_currentIndex]['type'] == 'video';
          if (_isVideo) {
            _initializeVideoController(widget.stories[_currentIndex]['url']!);
          } else {
            _videoController?.dispose();
            _videoController = null;
          }
        });
        _startAutoPlay();
      }
    } else {
      if (_currentIndex < widget.stories.length - 1) {
        setState(() {
          _currentIndex++;
          _pageController.animateToPage(_currentIndex,
              duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
          _isVideo = widget.stories[_currentIndex]['type'] == 'video';
          if (_isVideo) {
            _initializeVideoController(widget.stories[_currentIndex]['url']!);
          } else {
            _videoController?.dispose();
            _videoController = null;
          }
        });
        _startAutoPlay();
      }
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _pageController.dispose();
    _animationController.dispose();
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
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
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
          ],
        ),
      ),
    );
  }
}
