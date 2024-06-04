import 'package:flutter/material.dart';
import 'package:onigiri_app/Numbers/1000-100000/page1.dart';
import 'package:onigiri_app/Numbers/1000-100000/page3.dart';
import 'package:onigiri_app/Numbers/1000-100000/page1.dart';
import 'package:onigiri_app/Numbers/1000-100000/page3.dart';
import 'package:onigiri_app/Numbers/Numbers.dart';
import 'package:onigiri_app/colors.dart';
import 'package:video_player/video_player.dart';

class Num1000PAGE2 extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Num1000PAGE2> {
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
    controller = VideoPlayerController.asset(
        'assets/videos/Numbers/1000-100000/Numbers1000-100000-2.mp4');
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
          '1,000-100,000',
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
                  return Numbers();
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
        children: [
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
            alignment: Alignment(0.8, 0.9),
            child: Container(
              margin: EdgeInsets.only(bottom: 30.0),
              child: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () async {
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Num1000PAGE3(),
                    ),
                  );
                },
                iconSize: 50,
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.8, 0.9),
            child: Container(
              margin: EdgeInsets.only(bottom: 30.0),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () async {
                  await Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return Num1000PAGE1();
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        final Offset begin = Offset(-1.0, 0.0); // 左から右
                        final Offset end = Offset.zero;
                        final Animatable<Offset> tween =
                        Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: Curves.easeInOut));
                        final Animation<Offset> offsetAnimation =
                        animation.drive(tween);
                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                        //したから上にスライドする画面遷移
                      },
                    ),
                  );
                },
                iconSize: 50,
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
