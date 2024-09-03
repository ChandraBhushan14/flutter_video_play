part of 'video_bloc.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class LikeVideo extends VideoEvent {
  final Video video;

  const LikeVideo(this.video);

  @override
  List<Object> get props => [video];
}
