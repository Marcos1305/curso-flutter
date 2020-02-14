import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/blocs/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

import '../api.dart';
import '../models/video.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Favoritos"),
          centerTitle: true,
          backgroundColor: Colors.black87,
        ),
        backgroundColor: Colors.black87,
        body: StreamBuilder<Map<String, Video>>(
          stream: bloc.outFav,
          builder: (context, snapshot) {
            return ListView(
              children: snapshot.data.values.map((v) {
                return InkWell(
                  onTap: () {
                    FlutterYoutube.playYoutubeVideoById(
                        apiKey: API_KEY, videoId: v.id);
                  },
                  onLongPress: () {
                    bloc.toggleFavorite(v);
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 100,
                        margin: EdgeInsets.only(right: 10),
                        child: Image.network(v.thumb),
                      ),
                      Expanded(
                          child: Text(
                        v.title,
                        style: TextStyle(color: Colors.white70),
                        maxLines: 2,
                      ))
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ));
  }
}
