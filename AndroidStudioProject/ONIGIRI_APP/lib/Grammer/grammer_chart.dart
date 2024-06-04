import 'package:flutter/material.dart';
// Grammer screens imports
import 'package:onigiri_app/Grammer/1 Noun.dart';
import 'package:onigiri_app/Grammer/2 How to count.dart';
import 'package:onigiri_app/Grammer/3 ThisThatHereThere.dart';
import 'package:onigiri_app/Grammer/4 There is are.dart';
import 'package:onigiri_app/Grammer/5 adjective.dart';
import 'package:onigiri_app/Grammer/6 Verb Sentence.dart';
import 'package:onigiri_app/Grammer/7 comb verb.dart';
import 'package:onigiri_app/Grammer/8 want want to.dart';
import 'package:onigiri_app/Grammer/9 naimasudicte.dart';
import 'package:onigiri_app/colors.dart';
import 'package:onigiri_app/main.dart';

class Grammer extends StatelessWidget {
  Widget _buildButton(BuildContext context, String title, Widget targetPage,
      {double fontSize = 24}) {
    return Column(
      children: [
        SizedBox(height: 15),
        SizedBox(
          width: 310,
          height: 85,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              side: BorderSide(color: Color(0xFF4593A0), width: 6),
              primary: Colors.white,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () async {
              await Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    targetPage,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ));
            },
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF4593A0),
                  fontSize: fontSize,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Grammer chart',
            style: TextStyle(
                fontSize: 25,
                color: Colors.white,
            )),
        backgroundColor: Color(0xFF4593A0),
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
                pageBuilder: (context, animation, secondaryAnimation) => Home(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildButton(context, 'Noun Sentence', Noun()),
              _buildButton(context, 'How to count', count()),
              _buildButton(context, 'This/That/Here/There', TTHT(),
                  fontSize: 22),
              _buildButton(context, 'There is/are', isare()),
              _buildButton(context, 'Adjective Sentence', adjective()),
              _buildButton(context, 'Verb Sentence', Verb()),
              _buildButton(
                  context, 'Conbination of verbs and particles', comb(),
                  fontSize: 22),
              _buildButton(context, '"I want N" \n"I want to V"', want(),
                  fontSize: 20),
              _buildButton(context, 'masu-form\ndicitionary-form\nte-form',
                  naimasudicte(),
                  fontSize: 20),
            ],
          ),
        ),
      ),
    );
  }
}
