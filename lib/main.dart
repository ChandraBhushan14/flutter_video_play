import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_feed_app/routes/app_routes.dart';
import 'feed_page.dart';
import 'models/video.dart';
import 'video_player_page.dart';
import 'bloc/feed_bloc.dart';
import 'bloc/video_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppRoutes myRoute = AppRoutes();
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedBloc>(
          create: (context) => FeedBloc()..add(LoadFeed()),
        ),
        BlocProvider<VideoBloc>(
          create: (context) => VideoBloc(feedBloc: BlocProvider.of<FeedBloc>(context)),
        ),
      ],
      child: MaterialApp(
        title: 'Video Feed App',
        onGenerateRoute: (settings) => myRoute.router(settings)
      ),
    );
  }
}
