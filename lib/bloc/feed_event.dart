part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object> get props => [];
}

class LoadFeed extends FeedEvent {}

class UpdateVideoLikes extends FeedEvent {
  final Video video;

  const UpdateVideoLikes({required this.video});

  @override
  List<Object> get props => [video];
}
