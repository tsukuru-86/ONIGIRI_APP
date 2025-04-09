import 'package:flutter/material.dart';
import 'package:onigiri_app/5.Food Takeaways/Can I get this to go/step1.dart';
import 'package:onigiri_app/5.Food Takeaways/Can I get this to go/step2/step2a.dart';
import 'package:onigiri_app/5.Food Takeaways/Can I get this to go/step3.dart';
import 'package:onigiri_app/5.Food Takeaways/How about this/step1.dart';
import 'package:onigiri_app/5.Food Takeaways/How about this/step2/step2a.dart';
import 'package:onigiri_app/5.Food Takeaways/How about this/step3.dart';
import 'package:onigiri_app/5.Food Takeaways/No thank you/step1.dart';
import 'package:onigiri_app/5.Food Takeaways/No thank you/step2/step2a.dart';
import 'package:onigiri_app/5.Food Takeaways/No thank you/step3.dart';
import 'package:onigiri_app/colors.dart';

import '../main.dart';

class TakeawayPage extends StatelessWidget {
  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '5.Food Takeaways',
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
                  '1.Can I get this to go',
                  [
                    _buildStepButton(
                        'STEP1', context, Color(0xFF00afcc), CanSTEP1()),
                    _buildStepButton(
                        'STEP2', context, Color(0xFF4593A0), CanSTEP2a()),
                    _buildStepButton(
                        'STEP3', context, Color(0xFF476b6b), CanSTEP3()),
                  ],
                  context),
              _buildStepCard(
                  '2.How about this?',
                  [
                    _buildStepButton(
                        'STEP1', context, Color(0xFF00afcc), HATSTEP1()),
                    _buildStepButton(
                        'STEP2', context, Color(0xFF4593A0), HATSTEP2a()),
                    _buildStepButton(
                        'STEP3', context, Color(0xFF476b6b), HATSTEP3()),
                  ],
                  context),
              _buildStepCard(
                  '3.No thank you',
                  [
                    _buildStepButton(
                        'STEP1', context, Color(0xFF00afcc), NTYSTEP1()),
                    _buildStepButton(
                        'STEP2', context, Color(0xFF4593A0), NTYSTEP2a()),
                    _buildStepButton(
                        'STEP3', context, Color(0xFF476b6b), NTYSTEP3()),
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
