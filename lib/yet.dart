import 'package:flutter/material.dart';

class yet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'まだできてないよ',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Now creating',
          style: TextStyle(
            color: Colors.green,
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
