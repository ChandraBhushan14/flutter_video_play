part of 'video_bloc.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoInitial extends VideoState {}

class VideoLiked extends VideoState {
  final Video video;

  const VideoLiked({required this.video});

  @override
  List<Object> get props => [video];
}
