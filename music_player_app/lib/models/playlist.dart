import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/models/song.dart';
import 'dart:math';

enum RepeatMode { NONE, ALL, ONE }

class Playlist extends ChangeNotifier{
  final List<Song> _playlist = [
    Song(
        songName: "BNQVNCS",
        artistName: "Dai Tu",
        albumArtImagePath: "assets/image/BNQVNCS.jpg",
        audioPath: "audio/BachNguyetQuangVaNotChuSa.mp3",
    ),
    Song(
        songName: "Danh mat em",
        artistName: "Quang Dang Tran",
        albumArtImagePath: "assets/image/DanhMatEm.jpg",
        audioPath: "audio/DanhMatEm.mp3",
    ),
    Song(
        songName: "Dem, dom dom va em",
        artistName: "AnyFace",
        albumArtImagePath: "assets/image/dem_domdom_em.jpg",
        audioPath: "audio/DemDomDomVaEm.mp3"
    ),
    Song(
        songName: "Kokuhaku",
        artistName: "Ayasa",
        albumArtImagePath: "assets/image/kokuhaku.jpg",
        audioPath: "audio/Kokuhaku.mp3"
    ),
    Song(
        songName: "LIABP",
        artistName: "Nightcore",
        albumArtImagePath: "assets/image/LoveIsABeautifulPain.jpg",
        audioPath: "audio/LoveIsABeautifulPain.mp3"
    ),
    Song(
        songName: "Mot duong no hoa",
        artistName: "On Dich Tam",
        albumArtImagePath: "assets/image/MotDuongNoHoa.jpg",
        audioPath: "audio/MotDuongDoiHoa.mp3"
    ),
    Song(
        songName: "Mot nguoi rat tot",
        artistName: "Duong Tieu Trang",
        albumArtImagePath: "assets/image/MotNguoiRatTot.jpg",
        audioPath: "audio/MotNguoiRatTot.mp3"
    ),
    Song(
        songName: "Senbonzakura",
        artistName: "Hatsune Miku",
        albumArtImagePath: "assets/image/Senbonzakura.jpg",
        audioPath: "audio/Senbonzakura.mp3"
    ),
    Song(
        songName: "Tu nga",
        artistName: "Nhat Chi Bach Duong",
        albumArtImagePath: "assets/image/TuNga.jpg",
        audioPath: "audio/TuNga.mp3"
    ),
    Song(
        songName: "Yeu mot nguoi co le",
        artistName: "Miu Le, Lou Hoang",
        albumArtImagePath: "assets/image/YeuMotNguoiCoLe.jpg",
        audioPath: "audio/YeuMotNguoiCoLe.mp3"
    ),
    Song(
        songName: "YumeToHazakura",
        artistName: "Hatsune Miku",
        albumArtImagePath: "assets/image/YumeToHazakura.jpg",
        audioPath: "audio/YumeToHazakura.mp3"
    ),
  ];

  int? _currentSongIndex;

  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  Playlist(){
    listenToDuration();
  }

  bool _isPlaying = false;

  void play() async {
    print('Phuong thuc play() duoc goi');
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseOrResume() async {
    if(_isPlaying){
      pause();
    }
    else {
      resume();
    }
    notifyListeners();
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void playNextSong() {
    if(_currentSongIndex != null) {
      if(_currentSongIndex! < _playlist.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
    }
  }

  void playPreviousSong() async {
    if(_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    }
    else {
      if(_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      }
      else {
        currentSongIndex = playlist.length - 1;
      }
    }
  }

  RepeatMode _repeatMode = RepeatMode.NONE;
  bool _isShuffle = false;

  RepeatMode get repeatMode => _repeatMode;
  bool get isShuffle => _isShuffle;

  // Hàm để chuyển đổi chế độ lặp lại
  void toggleRepeat() {
    switch (_repeatMode) {
      case RepeatMode.NONE:
        _repeatMode = RepeatMode.ALL;
        break;
      case RepeatMode.ALL:
        _repeatMode = RepeatMode.ONE;
        break;
      case RepeatMode.ONE:
        _repeatMode = RepeatMode.NONE;
        break;
    }
    notifyListeners();
  }

  // Hàm để chuyển đổi trạng thái shuffle
  void toggleShuffle() {
    _isShuffle = !_isShuffle;
    if (_isShuffle) {
      _shufflePlaylist();
    }
    notifyListeners();
  }

  // Hàm để trộn danh sách phát
  void _shufflePlaylist() {
    _playlist.shuffle();
  }

  // Hàm để lặp lại bài hát hiện tại
  void repeatCurrentSong() {
    if (_currentSongIndex != null) {
      currentSongIndex = _currentSongIndex;
    }
  }

  void listenToDuration(){
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {playNextSong();});
  }

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if(newIndex != null){
      play();
    }
    notifyListeners();
  }
}