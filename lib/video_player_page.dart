import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/video_bloc.dart';
import 'models/video.dart';

class VideoPlayerPage extends StatefulWidget {
  final Video video;
  const VideoPlayerPage({super.key, required this.video});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  late Video video;

  @override
  void initState() {
    super.initState();
    video = widget.video;
    _controller = VideoPlayerController.network(video.url)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context, video),
        ), ),
        body: Column(
          children: [
            if (_controller.value.isInitialized)
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            VideoProgressIndicator(_controller, allowScrubbing: true),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                ),
                BlocConsumer<VideoBloc, VideoState>(
                  listener: (context, state) {
                    if (state is VideoLiked) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('You liked the video!')),
                      );
                      setState(() {
                        video = state.video;
                      });
                    }
                  },
                  builder: (context, state) {
                    return Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.thumb_up),
                          onPressed: () {
                            context.read<VideoBloc>().add(LikeVideo(video));
                          },
                        ),
                        Text('${video.likes} likes'),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
