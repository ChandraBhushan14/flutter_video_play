part of 'feed_bloc.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final List<Video> videos;

  const FeedLoaded({required this.videos});

  @override
  List<Object> get props => [videos];
}

class FeedError extends FeedState {}
