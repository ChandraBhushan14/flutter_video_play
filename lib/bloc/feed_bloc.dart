import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/video.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc() : super(FeedLoading()) {
    on<LoadFeed>((event, emit) async {
      try {
        List<Video> videos = await fetchVideos();
        print("videos: $videos");
        emit(FeedLoaded(videos: videos));
      } catch (_) {
        emit(FeedError());
      }
    });
    on<UpdateVideoLikes>((event, emit) {
      if (state is FeedLoaded) {
        final updatedVideos = (state as FeedLoaded).videos.map((video) {
          return video.id == event.video.id ? event.video : video;
        }).toList();
        emit(FeedLoaded(videos: updatedVideos));
      }
    });
  }
}

Future<List<Video>> fetchVideos() async {
  // Simulate network request
  await Future.delayed(Duration(seconds: 2));
  return [
    Video(
      id: '1',
      url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',//'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      thumbnailUrl: 'https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg',
      username: 'Bees',
      likes: 0,
    ),
    Video(
      id: '2',
      url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      thumbnailUrl: 'https://images.unsplash.com/photo-1725113160838-9efa2a25aa0b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHw4fHx8ZW58MHx8fHx8',
      username: 'ElephantsDream',
      likes: 0,
    ),
    Video(
      id: '3',
      url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',//'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      thumbnailUrl: 'https://plus.unsplash.com/premium_photo-1713184149457-ce10583b4ccd?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHw1Nnx8fGVufDB8fHx8fA%3D%3D',
      username: 'User1',
      likes: 0,
    ),
    Video(
      id: '4',
      url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      thumbnailUrl: 'https://images.unsplash.com/photo-1724908549265-06972c22ca37?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHw3N3x8fGVufDB8fHx8fA%3D%3D',
      username: 'User2',
      likes: 0,
    ),
  ];
}
