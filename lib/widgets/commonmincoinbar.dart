import 'package:flutter/material.dart';

class CommonMinCoinBar extends StatelessWidget {
  final String text;
  const CommonMinCoinBar({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.8,
      color: Colors.white,
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
