import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
// 必要な他のインポートを追加

class CiHSTEP1TEST extends StatefulWidget {
  @override
  _CiHSTEP1TESTState createState() => _CiHSTEP1TESTState();
}

class _CiHSTEP1TESTState extends State<CiHSTEP1TEST> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/Hotel/S1-1.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STEP1'),
        // AppBarの設定はここに続く...
      ),
      body: Stack(
        children: <Widget>[
          // ビデオプレーヤー
          _controller.value.isInitialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : Container(),
          // ボタンとテキストを動画の上に配置
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),
                  const SizedBox(height: 10), // ボタン間のスペース
                  TextButton(
                    onPressed: () {
                      // ここで次の画面に移動
                    },
                    child: const Text('Go to STEP2'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
