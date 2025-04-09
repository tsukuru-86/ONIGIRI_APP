import 'package:flutter/material.dart';
import 'package:onigiri_app/colors.dart';
import 'package:onigiri_app/5.Food Takeaways/How about this/step2/step2e.dart';
import 'package:onigiri_app/5.Food Takeaways/How about this/step3.dart';
import 'package:onigiri_app/5.Food Takeaways/Take away_page.dart';

class HATSTEP2f extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HATSTEP2f> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'STEP2',
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
                  return TakeawayPage();
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
          Column(
            children: [
              Expanded(
                  child: Container(
                child: Image.asset(
                  'assets/videos/Takeaway/S18-2-6.png',
                  fit: BoxFit.cover,
                ),
              )),
            ],
          ),
          Align(
            alignment: Alignment(0.8, 0.915),
            child: Container(
              margin: EdgeInsets.only(bottom: 30.0),
              child: IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HATSTEP3(),
                    ),
                  );
                },
                iconSize: 60,
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
                        return HATSTEP2e();
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
            alignment: Alignment(0.74, 0.86),
            child: Text(
              'STEP3',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
