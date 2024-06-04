import 'package:flutter/material.dart';
import 'package:onigiri_app/colors.dart';
import 'package:onigiri_app/3.Phone inquiries/Inquire by phone2.dart';
import 'package:onigiri_app/3.Phone inquiries/Whenareyou/step2/step2a.dart';
import 'package:onigiri_app/colors.dart';
import 'package:video_player/video_player.dart';

class WHSTEP1 extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<WHSTEP1> {
  late VideoPlayerController controller;

  @override
  void initState() {
    loadVideoPlayer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  loadVideoPlayer() {
    controller = VideoPlayerController.asset('assets/videos/Phone/S11-1.mp4');
    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'STEP1',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.turquoiseBlue,
        leading: IconButton(
          icon: Icon(
              Icons.close,
              color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return InquirebyphonePage2();
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation, // アニメーションの進行に応じて不透明度を変更
                    child: child,
                  );
                },
              ),
            );
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: [
                Center(
                  child: controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: controller.value.aspectRatio,
                          child: VideoPlayer(controller),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment(0.75, 0.83),
            child: Container(
              child: IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () async {
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WHSTEP2a(),
                    ),
                  );
                },
                iconSize: 60,
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.69, 0.86),
            child: Text(
              'STEP2',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.black, // この行を追加
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 62),
              child: MaterialButton(
                padding: EdgeInsets.all(15),
                child: Icon(
                  controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 30,
                ),
                onPressed: () async {
                  if (controller.value.isPlaying) {
                    await controller.pause();
                  } else {
                    await controller.play();
                  }
                  setState(() {});
                },
                color: AppColors.turquoiseBlue,
                textColor: Colors.white,
                shape: CircleBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
