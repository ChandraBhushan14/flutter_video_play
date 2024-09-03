import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'bloc/feed_bloc.dart';
import 'models/video.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Feed')),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FeedLoaded) {
            List<Video> videos = state.videos;
            print("feed page videos: $videos");
            return ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                Video video = videos[index];
                print("feed page video thumbnailUrl: ${video.thumbnailUrl}");
                print("feed page video username : ${video.username}");
                return GestureDetector(
                  onTap: () async {
                 final updatedVideo = await Navigator.pushNamed(context, '/video', arguments: video);
                  if (updatedVideo != null ) {
                   setState(() {

                   });
                  }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    child: Column(children: [
                      SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                        imageUrl: video.thumbnailUrl,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(video.username),
                          Text('${video.likes} likes')
                        ],
                      ),
                    ],),
                  ),
                  /*ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: video.thumbnailUrl,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                    title: Text(video.username),
                    subtitle: Text('${video.likes} likes'),
                  ),*/
                );
              },
            );
          } else {
            return const Center(child: Text('Failed to load feed.'));
          }
        },
      ),
    );
  }
}
