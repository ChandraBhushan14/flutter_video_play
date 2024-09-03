import 'package:flutter/material.dart';
import 'package:video_feed_app/feed_page.dart';
import 'package:video_feed_app/models/video.dart';
import 'package:video_feed_app/video_player_page.dart';


class AppRoutes{

  router(RouteSettings settings) {
    switch(settings.name){
      case  '/':
        return MaterialPageRoute(
          builder: (_) => const FeedPage(),
        );

      case '/video':
        print("settings.arguments.toString(): ${settings.arguments.toString()}");
        Video video =  settings.arguments as Video;
        print("video ---- : $video");
        return MaterialPageRoute(
          builder: (_) => VideoPlayerPage(video : video),
        );
    }
  }
}