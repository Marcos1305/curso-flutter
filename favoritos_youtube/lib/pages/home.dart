import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/blocs/videos_bloc.dart';
import 'package:favoritos_youtube/delegates/data_search.dart';
import 'package:favoritos_youtube/tiles/video_tile.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Container(
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(2)),
          padding: EdgeInsets.all(4),
          child: Image.asset(
            'images/youtube-logo-1.png',
          ),
        ),
        backgroundColor: Colors.black87,
        elevation: 0,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text("0"),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result =
                  await showSearch(context: context, delegate: DataSearch());
              if (result != null) {
                BlocProvider.of<VideosBloc>(context).inSearch.add(result);
              }
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: BlocProvider.of<VideosBloc>(context).outVideos,
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length + 1,
                itemBuilder: (context, index) {
                  if (index < snapshot.data.length) {
                    return VideoTile(snapshot.data[index]);
                  } else if (index > 1) {
                    BlocProvider.of<VideosBloc>(context).inSearch.add(null);
                    return Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    );
                  } else {
                    return Container();
                  }
                });
          }
          return Container();
        },
      ),
    );
  }
}
