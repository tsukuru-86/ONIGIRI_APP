import 'package:flutter/material.dart';
import 'package:onigiri_app/colors.dart';
import 'package:onigiri_app/6.Shopping2/I will have this one/step1.dart';
import 'package:onigiri_app/6.Shopping2/I will have this one/step2/step2a.dart';
import 'package:onigiri_app/6.Shopping2/I will have this one/step3.dart';
import 'package:onigiri_app/6.Shopping2/Where is the camera/step1.dart';
import 'package:onigiri_app/6.Shopping2/Where is the camera/step2/step2a.dart';
import 'package:onigiri_app/6.Shopping2/Where is the camera/step3.dart';
import 'package:onigiri_app/6.Shopping2/what do you recommend/step1.dart';
import 'package:onigiri_app/6.Shopping2/what do you recommend/step2/step2a.dart';
import 'package:onigiri_app/6.Shopping2/what do you recommend/step3.dart';
import 'package:onigiri_app/colors.dart';

import '../main.dart';

class Shopping2Page extends StatelessWidget {
  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '6.Shoping2',
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
                  '1.Where is the camera?',
                  [
                    _buildStepButton(
                        'STEP1', context, Color(0xFF00afcc), cameraSTEP1()),
                    _buildStepButton(
                        'STEP2', context, Color(0xFF4593A0), cameraSTEP2a()),
                    _buildStepButton(
                        'STEP3', context, Color(0xFF476b6b), cameraSTEP3()),
                  ],
                  context),
              _buildStepCard(
                  '2.What do you recommend?',
                  [
                    _buildStepButton(
                        'STEP1', context, Color(0xFF00afcc), recommendSTEP1()),
                    _buildStepButton(
                        'STEP2', context, Color(0xFF4593A0), recommendSTEP2a()),
                    _buildStepButton(
                        'STEP3', context, Color(0xFF476b6b), recommendSTEP3()),
                  ],
                  context),
              _buildStepCard(
                  '3.I will have this one',
                  [
                    _buildStepButton(
                        'STEP1', context, Color(0xFF00afcc), thisoneSTEP1()),
                    _buildStepButton(
                        'STEP2', context, Color(0xFF4593A0), thisoneSTEP2a()),
                    _buildStepButton(
                        'STEP3', context, Color(0xFF476b6b), thisoneSTEP3()),
                  ],
                  context),
            ],
          ),
        ),
      ),
    );
  }
}

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
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
