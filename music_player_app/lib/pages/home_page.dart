import 'package:flutter/material.dart';
import 'package:music_player_app/components/drawer.dart';
import 'package:music_player_app/models/playlist.dart';
import 'package:music_player_app/models/song.dart';
import 'package:provider/provider.dart';
import 'song_page.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final dynamic playlist;

  @override
  void initState() {
    super.initState();
    playlist = Provider.of<Playlist>(context, listen: false);
  }

  void goToSong(int songIndex) {
    playlist.currentSongIndex = songIndex;

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SongPage()),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: const Text("P L A Y L I S T"),),
      drawer: const MyDrawer(),
      body: Consumer<Playlist>(
        builder: (context, value, child) {
          final List<Song> playlist = value.playlist;
          return ListView.builder(
              itemCount: playlist.length,
              itemBuilder: (context, index) {
                final Song song = playlist[index];

                return ListTile(
                  title: Text(song.songName),
                  subtitle: Text(song.artistName),
                  leading: Image.asset(song.albumArtImagePath),
                  onTap: () => goToSong(index),
                );
              });
        }
      ),
    );
  }
}