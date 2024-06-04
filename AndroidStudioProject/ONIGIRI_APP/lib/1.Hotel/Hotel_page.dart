import 'package:flutter/material.dart';
import 'package:onigiri_app/colors.dart';
import 'package:onigiri_app/colors.dart';
import 'package:onigiri_app/1.Hotel/Confirming%20what%20you%20heard/Cwyh%20step1.dart';
import 'package:onigiri_app/1.Hotel/Confirming%20what%20you%20heard/Cwyh%20step2/Cwyh%20step2a.dart';
import 'package:onigiri_app/1.Hotel/Confirming%20what%20you%20heard/Cwyh%20step3.dart';
import 'package:onigiri_app/1.Hotel/Is%20this%20ann%20egg/egg%20step1.dart';
import 'package:onigiri_app/1.Hotel/Is%20this%20ann%20egg/egg%20step2/egg%20step2a.dart';
import 'package:onigiri_app/1.Hotel/Is%20this%20ann%20egg/egg%20step3.dart';
import 'package:onigiri_app/1.Hotel/Please and Thank you/PaT step2/PaT step2a.dart';
import 'package:onigiri_app/colors.dart';

import '../main.dart';
import 'Check into a hotel/CiH step3.dart';
import 'Check into a hotel/CiH step1.dart';
import 'Check into a hotel/flexible_test.dart';
import 'Check into a hotel/step2/check in step2a.dart';
import 'Please and Thank you/PaT step1.dart';
import 'Please and Thank you/PaT step3.dart';

class HotelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '1.Hotel',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.turquoiseBlue,
        elevation: 2,
        shadowColor: Colors.black,
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return Home();
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            );
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildStepCard(
                  '1.Check into a Hotel',
                  [
                    _buildStepButton(
                        'STEP1', context, Color(0xFF00afcc), CiHSTEP1()),
                    _buildStepButton(
                        'STEP2', context, Color(0xFF4593A0), CiHSTEP2a()),
                    _buildStepButton(
                        'STEP3', context, Color(0xFF476b6b), CiHSTEP3()),
                  ],
                  context),
              _buildStepCard(
                  '2."Please" and "Thank you"',
                  [
                    _buildStepButton(
                        'STEP1', context, Color(0xFF00afcc), PaTSTEP1()),
                    _buildStepButton(
                        'STEP2', context, Color(0xFF4593A0), PaTSTEP2a()),
                    _buildStepButton(
                        'STEP3', context, Color(0xFF476b6b), PaTSTEP3()),
                  ],
                  context),
              _buildStepCard(
                  '3.Confirming what you heard',
                  [
                    _buildStepButton(
                        'STEP1', context, Color(0xFF00afcc), CwyhSTEP1()),
                    _buildStepButton(
                        'STEP2', context, Color(0xFF4593A0), CwyhSTEP2a()),
                    _buildStepButton(
                        'STEP3', context, Color(0xFF476b6b), CwyhSTEP3()),
                  ],
                  context),
              _buildStepCard(
                  '4.Is this an egg?',
                  [
                    _buildStepButton(
                        'STEP1', context, Color(0xFF00afcc), eggSTEP1()),
                    _buildStepButton(
                        'STEP2', context, Color(0xFF4593A0), eggSTEP2a()),
                    _buildStepButton(
                        'STEP3', context, Color(0xFF476b6b), eggSTEP3()),
                  ],
                  context),
            ],
          ),
        ),
      ),
    );
  }

  //以下の部分は画面のサイズによってフレキシブルにconteinaerの大きさが変わるようになっている。元々のものだと文字のサイズによってサイズが変わってしまい
  //こういった形になった　なお7と9に関しては以前のコードを使用して残した状態にしてあるので参考にしたかったらそこを
  Widget _buildStepCard(
      String title, List<Widget> buttons, BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.84;

    return Container(
      width: width,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.turquoiseBlue,
          width: 6,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 27,
                color: AppColors.turquoiseBlue,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          ...buttons.map(
              (button) => Container(margin: EdgeInsets.all(10), child: button)),
        ],
      ),
    );
  }

  Widget _buildStepButton(
      String title, BuildContext context, Color color, Widget targetPage) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => targetPage,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      },
      child: Container(
        height: 75,
        width: 180,
        decoration: BoxDecoration(
          color: color, // Use the passed color
          borderRadius: BorderRadius.all(Radius.elliptical(100, 100)),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
