import 'package:flutter/material.dart';
import 'package:onigiri_app/colors.dart';
import 'package:onigiri_app/4.Shopping/Bycard/step1.dart';
import 'package:onigiri_app/4.Shopping/Bycard/step2/step2a.dart';
import 'package:onigiri_app/4.Shopping/Bycard/step3.dart';
import 'package:onigiri_app/4.Shopping/HaveL/step1.dart';
import 'package:onigiri_app/4.Shopping/HaveL/step2/step2a.dart';
import 'package:onigiri_app/4.Shopping/HaveL/step3.dart';
import 'package:onigiri_app/4.Shopping/Havewine/step1.dart';
import 'package:onigiri_app/4.Shopping/Havewine/step2/step2a.dart';
import 'package:onigiri_app/4.Shopping/Havewine/step3.dart';
import 'package:onigiri_app/4.Shopping/Itis/step1.dart';
import 'package:onigiri_app/4.Shopping/Itis/step2/step2a.dart';
import 'package:onigiri_app/4.Shopping/Itis/step3.dart';
import 'package:onigiri_app/4.Shopping/Lostitem/step1.dart';
import 'package:onigiri_app/4.Shopping/Lostitem/step2/step2a.dart';
import 'package:onigiri_app/4.Shopping/Lostitem/step3.dart';
import 'package:onigiri_app/colors.dart';

import '../main.dart';

class Shopping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '4.Shopping',
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
                  '1.Do you have this \n in L size?',
                  [
                    _buildStepButton(
                        'STEP1', context, Color(0xFF00afcc), HaveLSTEP1()),
                    _buildStepButton(
                        'STEP2', context, Color(0xFF4593A0), HaveLSTEP2a()),
                    _buildStepButton(
                        'STEP3', context, Color(0xFF476b6b), HaveLSTEP3()),
                  ],
                  context),
              _buildStepCard(
                  '2.Do you have Japanese wine?',
                  [
                    _buildStepButton(
                        'STEP1', context, Color(0xFF00afcc), WineSTEP1()),
                    _buildStepButton(
                        'STEP2', context, Color(0xFF4593A0), WineSTEP2a()),
                    _buildStepButton(
                        'STEP3', context, Color(0xFF476b6b), WineSTEP3()),
                  ],
                  context),
              _buildStepCard(
                  '3.It is cheap but tasty',
                  [
                    _buildStepButton(
                        'STEP1', context, Color(0xFF00afcc), ItSTEP1()),
                    _buildStepButton(
                        'STEP2', context, Color(0xFF4593A0), ItSTEP2a()),
                    _buildStepButton(
                        'STEP3', context, Color(0xFF476b6b), ItSTEP3()),
                  ],
                  context),
              _buildStepCard(
                  '4.By card',
                  [
                    _buildStepButton(
                        'STEP1', context, Color(0xFF00afcc), BySTEP1()),
                    _buildStepButton(
                        'STEP2', context, Color(0xFF4593A0), BySTEP2a()),
                    _buildStepButton(
                        'STEP3', context, Color(0xFF476b6b), BySTEP3()),
                  ],
                  context),
              _buildStepCard(
                  '5.Lost item',
                  [
                    _buildStepButton(
                        'STEP1', context, Color(0xFF00afcc), LostSTEP1()),
                    _buildStepButton(
                        'STEP2', context, Color(0xFF4593A0), LostSTEP2a()),
                    _buildStepButton(
                        'STEP3', context, Color(0xFF476b6b), LostSTEP3()),
                  ],
                  context),
            ],
          ),
        ),
      ),
    );
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
