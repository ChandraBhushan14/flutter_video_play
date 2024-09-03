import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/video.dart';
import 'feed_bloc.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final FeedBloc feedBloc;
  VideoBloc({required this.feedBloc}) : super(VideoInitial()) {
    on<LikeVideo>((event, emit) {
      final updatedVideo = event.video.copyWith(likes: event.video.likes + 1);
      feedBloc.add(UpdateVideoLikes(video: updatedVideo));
      emit(VideoLiked(video: updatedVideo));
    });
  }
}
